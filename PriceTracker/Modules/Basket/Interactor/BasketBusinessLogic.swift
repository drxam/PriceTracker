//
//  BasketBusinessLogic.swift
//  PriceTracker
//
//  Created by dread on 08.02.2025.
//

import Foundation
import UIKit

protocol BasketBusinessLogic: AnyObject {
    func addNewProduct(product: ProductModel)
    func multiplyPriceString(_ price: String?, by factor: Int) -> String
    func updateAllPrices(_ prices: [ShopType: [ProductModel?: Int]])
    func changeCount(_ product: String, _ data: [ShopType: [ProductModel?: Int]], _ count: Int) -> [ShopType: [ProductModel?: Int]]
    func rearrangeStackView(_ views: [UIView], _ prices: [String]) -> [UIView]
    func buyButtonTapped(_ price: String, _ oldPrice: String, _ count: Int)
}
