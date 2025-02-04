//
//  SettingsRouterProtocol.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation

protocol SettingsRouterProtocol: AnyObject {
    func showAlert(
        title: String,
        confirmTitle: String,
        cancelTitle: String,
        onConfirm: @escaping () -> Void
    )
}
