//
//  LocalNotification.swift
//  Planner
//
//  Created by Gamze Akyüz on 20.04.2023.
//

import Foundation
import UserNotifications

class NotificationHandler{
    
    func sendNotification(for plnr: Planner) {
        guard let title = plnr.title,
              let date = plnr.date,
              let id = plnr.id?.uuidString
        else {
            return
        }

        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)


        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Sınav Saatin Geldi..Başarılar..Kendine Güven✨"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UserNotifications.UNUserNotificationCenter.current().add(request)
    }
}


