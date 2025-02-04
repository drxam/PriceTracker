//
//  BasketRouter.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation
import UIKit

final class BasketRouter: BasketRouterProtocol {
    weak var view: UIViewController?
    
    func showProductScreen() {
        let vc = ProductAssembly.configureModule(shop: ShopType.magnit, category: "", productId: "")
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true)
    }
    
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
