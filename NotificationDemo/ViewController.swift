//
//  ViewController.swift
//  NotificationDemo
//
//  Created by 马权 on 6/23/16.
//  Copyright © 2016 马权. All rights reserved.
//

import UIKit
import UserNotifications

extension String {
    enum UNNotificationAction : String {
        case Accept
        case Reject
        case Ignore
    }
    
    enum UNNotificationCategory : String {
        case Fuck
    }
    
    enum UNNotificationRequest : String {
        case Test
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        
        // 创建通知响应事件
        let accept = UNNotificationAction.init(identifier: String.UNNotificationAction.Accept.rawValue,
                                               title: "接受",
                                               options: UNNotificationActionOptions.foreground)
        let decline = UNNotificationAction.init(identifier: String.UNNotificationAction.Reject.rawValue,
                                                title: "拒绝",
                                                options: UNNotificationActionOptions.destructive)
        let snooze = UNNotificationAction.init(identifier: String.UNNotificationAction.Ignore.rawValue,
                                               title: "无视",
                                               options: [])
        let actions = [ accept, decline, snooze ]
        
        //  创建一个新的通知类型
        let inviteCategory = UNNotificationCategory(identifier: String.UNNotificationCategory.Fuck.rawValue,
                                                    actions: actions,
                                                    minimalActions: actions,
                                                    intentIdentifiers: [],
                                                    options: [])
        
        //  将新的通知类型加入通知中心
        center.setNotificationCategories([inviteCategory])
    }
    
    @IBAction func scheduleAction(_ sender: AnyObject) {
        //  创建通知内容
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "来自火星：", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "fuck, fuck, fuck", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared().applicationIconBadgeNumber + 1;
        content.categoryIdentifier = String.UNNotificationCategory.Fuck.rawValue    //  设置通知类型
    
        //  通知交付条件设定
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: true)
        let request = UNNotificationRequest.init(identifier: String.UNNotificationRequest.Test.rawValue, content: content, trigger: nil)
        
        //  将通知排入计划
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    @IBAction func stopAction(_ sender: AnyObject) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [String.UNNotificationRequest.Test.rawValue])
    }
}

