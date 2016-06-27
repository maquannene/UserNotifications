//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by 马权 on 6/23/16.
//  Copyright © 2016 马权. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //  设置通知处理代理
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        //  请求认证通知
        center.requestAuthorization([.alert, .sound, .badge]) { (granted, error) in
            if granted == true {
                application.registerForRemoteNotifications()
            }
        }
        return true
    }
}

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("设备 token = " + deviceToken.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: ""))
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("如果需要实验远程推送，请确保使用真机");
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //  将要展示通知的回调
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    //  通知接到响应事件回调
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: () -> Void) {
        
        let responseNotificationRequestIdentifier = response.notification.request.identifier
        
        //  判断具体通知请求功能
        if responseNotificationRequestIdentifier == String.UNNotificationRequest.NormalLocalPush.rawValue ||
            responseNotificationRequestIdentifier == String.UNNotificationRequest.LocalPushWithTrigger.rawValue ||
            responseNotificationRequestIdentifier == String.UNNotificationRequest.LocalPushWithCustomUI1.rawValue ||
            responseNotificationRequestIdentifier == String.UNNotificationRequest.LocalPushWithCustomUI2.rawValue {
            
            let actionIdentifier = response.actionIdentifier
            switch actionIdentifier {
            case String.UNNotificationAction.Accept.rawValue:
                
                break
            case String.UNNotificationAction.Reject.rawValue:
                
                break
            case String.UNNotificationAction.Input.rawValue:
                
                break
            case UNNotificationDismissActionIdentifier:
                
                break
            case UNNotificationDefaultActionIdentifier:
                
                break
            default:
                break
            }
        }
        completionHandler();
    }
}

