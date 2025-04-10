//
//  MainRouterProtocol.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    func showShopScreen(with shopType: ShopType)
    func showProductScreen(from: ShopType, category: String, productId: String)
    func showSearchScreen(_ query: String)
}
