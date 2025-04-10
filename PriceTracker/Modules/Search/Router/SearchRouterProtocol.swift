//
//  SearchRouterProtocol.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import Foundation

protocol SearchRouterProtocol: AnyObject {
    func showProductScreen(from: ShopType, category: String, productId: String)
    func dismissSearchScreen()
}
