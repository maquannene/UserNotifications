//
//  ViewController.swift
//  NotificationDemo
//
//  Created by 马权 on 6/23/16.
//  Copyright © 2016 马权. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        
        // create Notification Action
        let accept = UNNotificationAction(identifier: String.UNNotificationAction.Accept.rawValue,
                                          title: "Agree",
                                          options: UNNotificationActionOptions.foreground)
        let reject = UNNotificationAction(identifier: String.UNNotificationAction.Reject.rawValue,
                                           title: "DisAgree",
                                           options: UNNotificationActionOptions.destructive)
        
        let comment = UNTextInputNotificationAction(identifier: String.UNNotificationAction.Input.rawValue,
                                                    title: "Input Someting",
                                                    options: [],
                                                    textInputButtonTitle: "Comment",
                                                    textInputPlaceholder: "Input Someting")
        
        //  create Notification Category
        let normal = UNNotificationCategory(identifier: String.UNNotificationCategory.Normal.rawValue,
                                            actions: [ accept, reject ],
                                            minimalActions: [ accept, reject ],
                                            intentIdentifiers: [],
                                            options: [])
        
        //  create Notification Category, and add category to NotificationContentExtension plist
        let cheer = UNNotificationCategory(identifier: String.UNNotificationCategory.Cheer.rawValue,
                                           actions: [ accept, reject ],
                                           minimalActions: [ accept, reject ],
                                           intentIdentifiers: [],
                                           options: [])
        
        //  create Notification Category, and add category to NotificationContentExtension plist
        let cheerText = UNNotificationCategory(identifier: String.UNNotificationCategory.CheerText.rawValue,
                                               actions: [ accept, reject, comment ],
                                               minimalActions: [ accept, comment, reject ],
                                               intentIdentifiers: [],
                                               options: [])
        //  add category to notification center categroies
        center.setNotificationCategories([normal, cheer, cheerText])
    }
    
    //  MARK: General Notification
    @IBAction func localPush(_ sender: AnyObject) {
        
        //  1. Create Notification Content
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Form cheer fans:",
                                                                 arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "cheer music,best music.\nDrop-Down Show More",
                                                                arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        content.categoryIdentifier = String.UNNotificationCategory.Normal.rawValue   //  设置通知类型标示
    
        //  2. Create Notification Attachment
        let attachement = try? UNNotificationAttachment(identifier: "attachment", url: URL.resource(type: .Local1), options: nil)
        content.attachments = [attachement!]
    
        //  3. Create Notification Request
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.NormalLocalPush.rawValue,
                                                 content: content, trigger: nil)
        
        //  4. Add to NotificationCenter
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    
    //  MARK: Push Notification with Trigger
    @IBAction func localPushWithTrigger(_ sender: AnyObject) {
        
        //  1. Create Notification Content
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Form cheer fans:",
                                                                 arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "cheer music,best music.\nDrop-Down Show More",
                                                                arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        content.categoryIdentifier = String.UNNotificationCategory.Normal.rawValue   //  设置通知类型标示
        
        //  2. Create trigger
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 2, repeats: true)
        
        //  3. Create Notification Request，set content and trigger
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.LocalPushWithTrigger.rawValue,
                                                 content: content,
                                                 trigger: trigger)
        
        //  4. Add to NotificationCenter
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    //  MARK: Push Notification and support NotificationContentExtension
    @IBAction func localPushWithCustomUI1(_ sender: AnyObject) {

        //  1. Create Notification Content
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Form cheer fans:",
                                                                 arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "cheer music,best music.\nDrop-Down Show More",
                                                                arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        //  set categoryIdentifier which already added to NotificationContentExtension plist
        content.categoryIdentifier = String.UNNotificationCategory.Cheer.rawValue
        content.userInfo["imageAbsoluteString"] = URL.resource(type: .Remote).absoluteString
        
        //  2. Create Notification Attachment
        let attachement = try? UNNotificationAttachment(identifier: "attachment", url: URL.resource(type: .Local), options: nil)
        content.attachments = [attachement!]
        
        //  3. Create Notification Request
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.LocalPushWithCustomUI1.rawValue, content: content, trigger: nil)
        
        //  4. Add to NotificationCenter
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    //  MARK: Push Notification and support NotificationContentExtension and UNTextInputNotificationAction
    @IBAction func localPushWithCustomUI2(_ sender: AnyObject) {
        
        //  1. Create Notification Content
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Form cheer fans:",
                                                                 arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "cheer music,best music.\nDrop-Down Show More",
                                                                arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        //  set categoryIdentifier which already added to NotificationContentExtension plist
        content.categoryIdentifier = String.UNNotificationCategory.CheerText.rawValue
        content.userInfo["imageAbsoluteString"] = URL.resource(type: .Remote).absoluteString
        
        //  2. Create Notification Attachment
        let attachement = try? UNNotificationAttachment(identifier: "attachment", url: URL.resource(type: .Local), options: nil)
        content.attachments = [attachement!]
        
        //  3. Create Notification Request
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.LocalPushWithCustomUI2.rawValue, content: content, trigger: nil)
        
        //  4. Add to NotificationCenter
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    //  MARK: Remove Notification
    @IBAction func removeNotify(_ sender: AnyObject) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        //  remove specified notification
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String.UNNotificationRequest.LocalPushWithTrigger.rawValue])
    }
}

