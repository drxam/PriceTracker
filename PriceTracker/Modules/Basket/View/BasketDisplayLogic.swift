//
//  BasketDisplayLogic.swift
//  PriceTracker
//
//  Created by dread on 08.02.2025.
//

import Foundation

protocol BasketDisplayLogic: AnyObject {
    func displayNewProducts(_ products: [ShopType: ProductModel?])
    func updateAllPrices(_ prices: [ShopType: String], _ oldPrices: [ShopType: String])
}
