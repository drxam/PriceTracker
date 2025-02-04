//
//  SettingsInteractor.swift
//  PriceTracker
//
//  Created by dread on 28.01.2025.
//

import Foundation

final class SettingsInteractor: SettingsBusinessLogic {
    func toggleNotifications() {
        NotificationManager.shared.toggleDailyNotification()
    }
}
