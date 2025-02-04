//
//  SettingsRouter.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation
import UIKit

final class SettingsRouter: SettingsRouterProtocol {
    weak var view: UIViewController?
    
    func showAlert(
        title: String,
        confirmTitle: String,
        cancelTitle: String,
        onConfirm: @escaping () -> Void
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            onConfirm()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        view?.present(alert, animated: true)
    }
}
