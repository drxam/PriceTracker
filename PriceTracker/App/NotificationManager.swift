//
//  NotificationManager.swift
//  PriceTracker
//
//  Created by dread on 26.01.2025.
//

import Foundation
import UserNotifications

final class NotificationManager {
    private init() {}
    static let shared = NotificationManager()
    private let notificationStateKey = "isNotificationEnabled"
    
    var isNotificationEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: notificationStateKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: notificationStateKey)
        }
    }
    
    func toggleDailyNotification() {
        if isNotificationEnabled {
            cancelDailyDiscountNotification()
            isNotificationEnabled = false
        } else {
            scheduleDailyDiscountNotification()
            isNotificationEnabled = true
        }
    }

    
    private func scheduleDailyDiscountNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Новые скидки!"
        content.body = "Проверьте новые скидки в приложении!"
        content.sound = .default
        content.badge = 1

        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 38
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "daily_discount_reminder", content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Ошибка при планировании уведомления: \(error.localizedDescription)")
            } else {
                print("Ежедневное уведомление запланировано!")
            }
        }
    }
    
    private func cancelDailyDiscountNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["daily_discount_reminder"])
        print("Ежедневное уведомление отключено.")
    }
}
