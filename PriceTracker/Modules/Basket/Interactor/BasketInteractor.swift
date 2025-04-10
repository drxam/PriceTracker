//
//  BasketInteractor.swift
//  PriceTracker
//
//  Created by dread on 08.02.2025.
//

import Foundation
import UIKit

final class BasketInteractor: BasketBusinessLogic {
    var presenter: BasketPresentationLogic?
    
    func addNewProduct(product: ProductModel) {
        DispatchQueue.global().async {
            let currentShop = product.shop
            var foundedProducts: [ShopType: ProductModel?] = [
                .okey: nil,
                .perekrestok: nil,
                .magnit: nil,
                .paterochka: nil
            ]
            
            foundedProducts[currentShop] = product
            
            for shop in ShopType.allCases where shop != currentShop {
                foundedProducts[shop] = self.searchProducts(product.name, shop)
            }
            
            DispatchQueue.main.async {
                self.presenter?.presentNewProducts(foundedProducts)
            }
        }
    }
    
    func searchProducts(_ query: String, _ shopType: ShopType) -> ProductModel? {
        var products = TotalData.allProducts
        
        switch shopType {
        case .magnit:
            products = TotalData.magnitAllProducts
        case .paterochka:
            products = TotalData.paterochkaAllProducts
        case .okey:
            print("BasketInteractor")
        case .perekrestok:
            print("BasketInteractor")
        }
        
        return searchProduct(query, from: products)
    }
    
    func searchProduct(_ query: String, from products: [ProductModel]) -> ProductModel? {
        let lowercasedQueryWords = query.lowercased().split(separator: " ")
        let queryWordCount = lowercasedQueryWords.count
        
        let foundProducts = products
            .compactMap { product -> (ProductModel, Int, Bool, Int, Int, Bool)? in
                let name = product.name.lowercased()
                let nameWords = name.split(separator: " ")
                let matches = lowercasedQueryWords.filter { nameWords.contains($0) }.count
                let firstMatchIndex = nameWords.firstIndex(where: { lowercasedQueryWords.contains($0) }) ?? Int.max
                let hasExactWordCount = nameWords.count == queryWordCount
                let nameWordCount = nameWords.count
                let hasDiscount = product.oldPrice != nil
                
                guard matches > 0 else { return nil }
                
                return (product, matches, hasExactWordCount, firstMatchIndex, nameWordCount, hasDiscount)
            }
            .sorted { lhs, rhs in
                if lhs.1 != rhs.1 { return lhs.1 > rhs.1 }
                if lhs.2 != rhs.2 { return lhs.2 }
                if lhs.3 != rhs.3 { return lhs.3 < rhs.3 }
                if lhs.4 != rhs.4 { return lhs.4 < rhs.4 }
                return !lhs.5
            }
            .map { $0.0 }
        if foundProducts.isEmpty {
            return nil
        } else {
            return foundProducts[0]
        }
    }
    
    func changeCount(_ product: String, _ data: [ShopType: [ProductModel?: Int]], _ count: Int) -> [ShopType: [ProductModel?: Int]] {
        var updatedData = data
        
        for shop in ShopType.allCases {
            guard let products = updatedData[shop] else { continue }
            
            let productList = products.keys.compactMap { $0 }
            guard let foundProduct = searchProduct(product, from: productList) else { continue }
            
            if let currentCount = updatedData[shop]?[foundProduct] {
                let newCount = currentCount + count
                
                if newCount > 0 {
                    updatedData[shop]?[foundProduct] = newCount
                } else {
                    updatedData[shop]?.removeValue(forKey: foundProduct)
                }
            }
        }
        
        return updatedData
    }
    
    func multiplyPriceString(_ price: String?, by factor: Int) -> String {
        guard let price = price else { return "" }
        
        let cleanedString = price.replacingOccurrences(of: "[^0-9,]", with: "", options: .regularExpression)
        
        let decimalString = cleanedString.replacingOccurrences(of: ",", with: ".")
        
        guard let value = Double(decimalString) else { return "" }
        
        let newValue = value * Double(factor)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = ""
        
        if let formattedString = formatter.string(from: NSNumber(value: newValue)) {
            return "\(formattedString) ₽"
        }
        
        return ""
    }
    
    func updateAllPrices(_ prices: [ShopType: [ProductModel?: Int]]) {
        var totalPrices: [ShopType: Double] = [:]
        var totalPricesWithoutDiscount: [ShopType: Double] = [:]
        
        for shop in ShopType.allCases {
            let products = prices[shop] ?? [:]
            var total: Double = 0.0
            
            for (product, quantity) in products {
                guard let product = product else { continue }
                
                let cleanedPriceString = product.price.replacingOccurrences(of: "[^0-9,]", with: "", options: .regularExpression)
                let decimalPriceString = cleanedPriceString.replacingOccurrences(of: ",", with: ".")

                guard let cleanedPrice = Double(decimalPriceString) else { continue }
                
                total += cleanedPrice * Double(quantity)
            }
            totalPrices[shop] = total
        }
        
        for shop in ShopType.allCases {
            let products = prices[shop] ?? [:]
            var total: Double = 0.0
            
            for (product, quantity) in products {
                guard let product = product else { continue }
                
                var cleanedPriceString: String = ""
                if let oldPrices = product.oldPrice, !oldPrices.isEmpty {
                    cleanedPriceString = oldPrices.replacingOccurrences(of: "[^0-9,]", with: "", options: .regularExpression)
                } else {
                    cleanedPriceString = product.price.replacingOccurrences(of: "[^0-9,]", with: "", options: .regularExpression)
                }
                
                let decimalPriceString = cleanedPriceString.replacingOccurrences(of: ",", with: ".")
                guard let cleanedPrice = Double(decimalPriceString) else { continue }
                total += cleanedPrice * Double(quantity)
            }
            totalPricesWithoutDiscount[shop] = total
        }
        
        presenter?.formatAllPrices(totalPrices, totalPricesWithoutDiscount)
    }
    
    func rearrangeStackView(_ views: [UIView], _ prices: [String]) -> [UIView] {
        var prices_double: [Double] = []
        for price in prices {
            let cleanedPriceString = price.replacingOccurrences(of: "[^0-9,]", with: "", options: .regularExpression)
            let decimalPriceString = cleanedPriceString.replacingOccurrences(of: ",", with: ".")
            
            guard let cleanedPrice = Double(decimalPriceString) else { continue }
            
            prices_double.append(cleanedPrice)
        }
        
        var viewPricePairs = zip(views, prices_double).map { (view: $0, price: $1) }
        viewPricePairs.sort { $0.price < $1.price }
        
        var resultViews: [UIView] = []
        for pair in viewPricePairs {
            resultViews.append(pair.view)
        }
        
        return resultViews
    }
    
    func buyButtonTapped(_ price: String, _ oldPrice: String, _ count: Int) {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let formattedDate = dateFormatter.string(from: date)
        
        let purchaseModel = PurchaseModel(price: price, oldPrice: oldPrice, count: count, date: formattedDate)
        NotificationCenter.default.post(name: NSNotification.Name("AddNewPurchase"), object: purchaseModel)
    }
}
