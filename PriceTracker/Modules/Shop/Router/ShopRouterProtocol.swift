//
//  ShopRouterProtocol.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import Foundation

protocol ShopRouterProtocol: AnyObject {
    func dismissShopScreen()
    func showProductScreen(from: ShopType, category: String, productId: String)
    func showSearchScreen()
}
