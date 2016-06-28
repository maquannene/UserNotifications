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
        "category" : "Cheer"
    },
    "imageAbsoluteString" : "http://ww1.sinaimg.cn/large/65312d9agw1f59leskkcij20cs0csmym.jpg"
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
        
        //  这里我直接将资源文件加入了 bundle然后读取
        //  如果想要使用 container app 下载的文件，需要先加入同一个 App Groups，并且下载的文件存入共享位置
        let url = URL.resource(type: .Local)
        let attachement = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
        
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
