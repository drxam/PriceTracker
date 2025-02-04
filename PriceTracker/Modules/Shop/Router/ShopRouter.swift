//
//  ShopRouter.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import Foundation
import UIKit

final class ShopRouter: ShopRouterProtocol {
    var view: UIViewController?
    
    func dismissShopScreen() {
        view?.dismiss(animated: true)
    }
    
    func showProductScreen(from: ShopType, category: String, productId: String) {
        let vc = ProductAssembly.configureModule(shop: from, category: category, productId: productId)
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true)
    }
    
    func showSearchScreen() {
        let vc = SearchAssembly.configureModule()
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true)
    }
}
