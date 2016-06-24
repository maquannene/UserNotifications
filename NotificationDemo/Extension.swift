//
//  Extension.swift
//  NotificationDemo
//
//  Created by 马权 on 6/24/16.
//  Copyright © 2016 马权. All rights reserved.
//

import Foundation

extension String {
    enum UNNotificationAction : String {
        case Accept
        case Reject
        case Input
    }
    
    enum UNNotificationCategory : String {
        case Normal
        case Cheer
        case CheerText
    }
    
    enum UNNotificationRequest : String {
        case Test
    }
}
