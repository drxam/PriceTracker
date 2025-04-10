//
//  ShopBusinessLogic.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation

protocol ShopBusinessLogic: AnyObject {
    func fetchCategories(for shopType: ShopType)
    func fetchProducts(for shopType: ShopType)
    func fetchProductsForCategory(for shopType: ShopType, with categoryId: String)
    func plusButtonTapped(for product: ProductModel?)
}
