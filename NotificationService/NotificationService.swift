//
//  NotificationService.swift
//  NotificationService
//
//  Created by 马权 on 6/23/16.
//  Copyright © 2016 马权. All rights reserved.
//


/*
 Service push data struct:
 
 {
    "aps" : {
        "alert" : {
        "title" : "title",
        "body" : "Your message Here"
        },
        "mutable-content" : "1",
        "category" : "Cheer"    //  if needn't use custom extensionContent, delete it.
    },
    "imageAbsoluteString" : "http://ww1.sinaimg.cn/large/65312d9agw1f59leskkcij20cs0csmym.jpg"  //  custom info
 }
 */

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest,
                             withContentHandler contentHandler:(UNNotificationContent) -> Void) {
        
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
     
        //  get app group fmURL. If you reset group, remember reset GroupIdentifier
        let fmURL: URL? = FileManager.default().containerURLForSecurityApplicationGroupIdentifier("group.emm")
        
        LOG_WARNING
        print("If you reset app group or provisioning Profile, remember reset GroupIdentifier")
        
        var attachement: UNNotificationAttachment? = nil
        
        //  use semaphore convert async download to sync
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.downloadImage(atURL: URL.resource(type: .AttachmentRemote)) { (data, error) in
            
            var url: URL? = nil
            do {
                //  have to set file extension which support by UNNotificationAttachment, png, jpeg, gif...
                url = try fmURL?.appendingPathComponent("customAttachmentPic").appendingPathExtension(".png")
            }
            catch {
                // out put error by notification
                if let bestAttemptContent = self.bestAttemptContent {
                    bestAttemptContent.title = "customAttachmentPic"
                    bestAttemptContent.body = String(error)
                    contentHandler(bestAttemptContent)
                    return
                }
            }

            //  write to app group file url
            try! data?.write(to: url!)
            
            //  create UNNotificationAttachment by app group file url
            attachement = try! UNNotificationAttachment(identifier: "attachment", url: url!, options: nil)
            
            semaphore.signal()
        }
        
        semaphore.wait()
        
        //  success set attachments
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            bestAttemptContent.attachments = [attachement!]
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
