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
        
        // 创建通知响应事件
        let accept = UNNotificationAction(identifier: String.UNNotificationAction.Accept.rawValue,
                                          title: "同意",
                                          options: UNNotificationActionOptions.foreground)
        let reject = UNNotificationAction(identifier: String.UNNotificationAction.Reject.rawValue,
                                           title: "不同意",
                                           options: UNNotificationActionOptions.destructive)
        
        let comment = UNTextInputNotificationAction(identifier: String.UNNotificationCategory.CheerText.rawValue, title: "说点什么", options: [])
        
        //  创建一个新的通知类型
        let normal = UNNotificationCategory(identifier: String.UNNotificationCategory.Normal.rawValue,
                                            actions: [ accept, reject ],
                                            minimalActions: [ accept, reject ],
                                            intentIdentifiers: [],
                                            options: [])
        
        //  创建新的通知类型， 并且加入 notification content plist
        let cheer = UNNotificationCategory(identifier: String.UNNotificationCategory.Cheer.rawValue,
                                           actions: [ accept, reject ],
                                           minimalActions: [ accept, reject ],
                                           intentIdentifiers: [],
                                           options: [])
        
        //  创建新的通知类型， 并且加入 notification content plist
        let cheerText = UNNotificationCategory(identifier: String.UNNotificationCategory.CheerText.rawValue,
                                               actions: [ accept, reject, comment ],
                                               minimalActions: [ accept, reject, comment ],
                                               intentIdentifiers: [],
                                               options: [])
        //  将新的通知类型加入通知中心
        center.setNotificationCategories([normal, cheer, cheerText])
        
    }
    
    @IBAction func localPush(_ sender: AnyObject) {

        //  创建通知内容
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Form cheer fans:", arguments: nil)
        content.subtitle = NSDate().description
        content.body = NSString.localizedUserNotificationString(forKey: "cheer music, best music\ncheer music, best music", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        content.categoryIdentifier = String.UNNotificationCategory.Normal.rawValue   //  设置通知类型
    
        //  加入 attachment 附件
        let path = Bundle.main().pathForResource("cheer", ofType: "png")
        let url = URL(fileURLWithPath: path!)
        let options: [NSObject : AnyObject] = [UNNotificationAttachmentOptionsThumbnailHiddenKey : false,
                                             UNNotificationAttachmentOptionsTypeHintKey : url.path!]
        let attachement = try? UNNotificationAttachment(identifier: "attachment", url: url, options: options)
        
        content.attachments = [attachement!]
        
        //  通知交付条件设定
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: true)
    
        //  创建通知请求
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.Test.rawValue, content: content, trigger: nil)
        
        //  将通知排入计划
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    
    
    @IBAction func localPushWithCustomUI1(_ sender: AnyObject) {

        //  创建通知内容
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Form cheer fans:", arguments: nil)
        content.subtitle = NSDate().description
        content.body = NSString.localizedUserNotificationString(forKey: "cheer music, best music\ncheer music, best music", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        content.categoryIdentifier = String.UNNotificationCategory.Cheer.rawValue   //  设置通知类型
        
        //  加入 attachment 附件
        let path = Bundle.main().pathForResource("cheer", ofType: "png")
        let url = URL(fileURLWithPath: path!)
        let attachement = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
        content.attachments = [attachement!]
        
        //  创建通知请求
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.Test.rawValue, content: content, trigger: nil)
        
        //  将通知排入计划
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    @IBAction func localPushWithCustomUI2(_ sender: AnyObject) {
        //  创建通知内容
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Form cheer fans:", arguments: nil)
        content.subtitle = NSDate().description
        content.body = NSString.localizedUserNotificationString(forKey: "cheer music, best music\ncheer music, best music", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        content.categoryIdentifier = String.UNNotificationCategory.CheerText.rawValue   //  设置通知类型
        
        //  加入 attachment 附件
        let path = Bundle.main().pathForResource("cheer", ofType: "png")
        let url = URL(fileURLWithPath: path!)
        let attachement = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
        content.attachments = [attachement!]
        
        //  创建通知请求
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.Test.rawValue, content: content, trigger: nil)
        
        //  将通知排入计划
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}

