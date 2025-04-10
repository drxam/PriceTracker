//
//  SearchRouter.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import Foundation
import UIKit

final class SearchRouter: SearchRouterProtocol {
    var view: UIViewController?
    
    func showProductScreen(from: ShopType, category: String, productId: String) {
        let vc = ProductAssembly.configureModule(shop: from, category: category, productId: productId)
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true)
    }
    
    func dismissSearchScreen() {
        view?.dismiss(animated: true)
    }
}
