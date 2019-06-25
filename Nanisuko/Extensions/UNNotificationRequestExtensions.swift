//
//  UNNotificationRequestExtensions.swift
//  Nanisuko
//
//  Created by 福田走 on 2019/06/25.
//  Copyright © 2019 福田走. All rights reserved.
//

import Foundation
import UserNotifications

extension UNNotificationRequest {
    static func createNanisuko() -> UNNotificationRequest {
         return UNNotificationRequest(identifier: "uuid", content: getContent(), trigger: getTrigger())
    }
    

    private static func getContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = "今日はなにすこ？"
        content.sound = UNNotificationSound.default
        content.badge = 1
        return content
    }
    
    private static func getTrigger() -> UNNotificationTrigger {
        var notificationTime = DateComponents()
        notificationTime.hour = 18
        notificationTime.minute = 0
        
        // return UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        return UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
    }
}
