//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by 马权 on 6/23/16.
//  Copyright © 2016 马权. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var sublabel: UILabel!
    
    var actionCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  可以自定义 size
        self.preferredContentSize = CGSize(width: self.view.bounds.width, height: 300)
    }
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        self.label?.text = content.body
        if let attachement = content.attachments.first {
            if attachement.url.startAccessingSecurityScopedResource() {
                imageView.image = UIImage(contentsOfFile: attachement.url.path!)
                attachement.url.stopAccessingSecurityScopedResource()
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse,
                    completionHandler completion: (UNNotificationContentExtensionResponseOption) -> Void) {
        //  判断具体通知请求功能
        if response.notification.request.identifier == String.UNNotificationRequest.Test.rawValue {
            let actionIdentifier = response.actionIdentifier
            switch actionIdentifier {
            case String.UNNotificationAction.Accept.rawValue:
                sublabel.text = "你很有品味"
                actionCompletion = { completion(.dismiss) }
                perform(#selector(NotificationViewController.dismissssss), with: nil, afterDelay: 1)
                break
            case String.UNNotificationAction.Reject.rawValue:
                sublabel.text = "不能不同意"
                completion(.doNotDismiss)
                break
            case String.UNNotificationAction.Input.rawValue:
//                inputTextField.becomeFirstResponder()
                break
            default:
                break
            }
        }
    }
//    
//    override var inputAccessoryView: UIView? {
//        return inputTextField
//    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func dismissssss() {
        actionCompletion?()
        actionCompletion = nil
    }
}
