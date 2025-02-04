//
//  MainRouter.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

final class MainRouter: MainRouterProtocol {
    weak var view: UIViewController?
    
    func showShopScreen(with shopType: ShopType) {
        let vc = ShopAssembly.configureModule(with: shopType)
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true)
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
