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

class NotificationViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var sublabel: UILabel!
    
    var actionCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  可以自定义 size
        self.preferredContentSize = CGSize(width: self.view.bounds.width, height: 300)
    }
    
    func dismissssss() {
        actionCompletion?()
        actionCompletion = nil
    }
}

extension NotificationViewController : UNNotificationContentExtension {
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        self.label?.text = content.body
        
        if let imageAbsoluteString = content.userInfo["imageAbsoluteString"] as? String,
            url = URL(string: imageAbsoluteString) {
            URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                if let _ = error {
                    return
                }
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                    self?.imageView.isHidden = false
                }
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse,
                    completionHandler completion: (UNNotificationContentExtensionResponseOption) -> Void) {
        
        //  如果 action 来自于 textInput
        if let textInputResponse = response as? UNTextInputNotificationResponse {
            print(textInputResponse.userText)   //  打印输入内容
            completion(.dismiss)
            return
        }
        
        let responseNotificationRequestIdentifier = response.notification.request.identifier
        //  判断具体通知请求功能
        if responseNotificationRequestIdentifier == String.UNNotificationRequest.NormalLocalPush.rawValue ||
            responseNotificationRequestIdentifier == String.UNNotificationRequest.LocalPushWithTrigger.rawValue ||
            responseNotificationRequestIdentifier == String.UNNotificationRequest.LocalPushWithCustomUI1.rawValue ||
            responseNotificationRequestIdentifier == String.UNNotificationRequest.LocalPushWithCustomUI2.rawValue {
            
            let actionIdentifier = response.actionIdentifier
            switch actionIdentifier {
            case String.UNNotificationAction.Accept.rawValue:
                sublabel.text = "你很有品味"
                actionCompletion = { completion(.dismiss) }
                perform(#selector(NotificationViewController.dismissssss), with: nil, afterDelay: 1)
                break
            case String.UNNotificationAction.Reject.rawValue:
                sublabel.text = "不能不同意，无法 dismiss"
                completion(.doNotDismiss)
                break
            case String.UNNotificationAction.Input.rawValue:
                becomeFirstResponder()
                break
            default:
                break
            }
        }
    }
}
