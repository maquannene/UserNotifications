//
//  NotificationService.swift
//  NotificationService
//
//  Created by 马权 on 6/23/16.
//  Copyright © 2016 马权. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler:(UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
    
//        let path = Bundle.main().pathForResource("cheer", ofType: "png")
//        let url = URL(fileURLWithPath: path!)
//        var attachement = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
        
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
