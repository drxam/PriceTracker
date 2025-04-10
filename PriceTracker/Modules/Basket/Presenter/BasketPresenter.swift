//
//  BasketPresenter.swift
//  PriceTracker
//
//  Created by dread on 08.02.2025.
//

import Foundation

final class BasketPresenter: BasketPresentationLogic {
    weak var view: BasketDisplayLogic?
    
    func presentNewProducts(_ products: [ShopType: ProductModel?]) {
        view?.displayNewProducts(products)
    }
    
    func formatAllPrices(_ prices: [ShopType: Double], _ oldPrices: [ShopType: Double]) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = ""
        
        var formattedPrices: [ShopType: String] = [:]
        for (shop, price) in prices {
            if let formattedString = formatter.string(from: NSNumber(value: price)) {
                formattedPrices[shop] = "\(formattedString) ₽"
            }
        }
        
        var formattedOldPrices: [ShopType: String] = [:]
        for (shop, price) in oldPrices {
            if let formattedString = formatter.string(from: NSNumber(value: price)) {
                formattedOldPrices[shop] = "\(formattedString) ₽"
            }
            if price == 0 {
                formattedOldPrices[shop] = ""
            }
        }
        
        view?.updateAllPrices(formattedPrices, formattedOldPrices)
    }
}
