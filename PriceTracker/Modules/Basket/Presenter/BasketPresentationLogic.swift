//
//  BasketPresentationLogic.swift
//  PriceTracker
//
//  Created by dread on 08.02.2025.
//

import Foundation

protocol BasketPresentationLogic: AnyObject {
    func presentNewProducts(_ products: [ShopType: ProductModel?])
    func formatAllPrices(_ prices: [ShopType: Double], _ oldPrices: [ShopType: Double])
}
