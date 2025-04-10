//
//  ProductBusinessLogic.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

protocol ProductBusinessLogic: AnyObject {
    func fetchProduct(from: ShopType, category: String, productId: String)
    func plusButtonTapped(for product: ProductModel?)
}
