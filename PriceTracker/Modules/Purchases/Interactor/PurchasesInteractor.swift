//
//  PurchasesInteractor.swift
//  PriceTracker
//
//  Created by dread on 13.03.2025.
//

import Foundation

final class PurchasesInteractor: PurchasesBusinessLogic {
    var presenter: PurchasesPresentationLogic?
    
    func addNewPurchase(_ new: PurchaseModel) {
        TotalData.purchases.append(new)
        let expenses: [Double] = calculateExpenses()
        presenter?.presentPurchases(expenses)
    }
    
    private func calculateExpenses() -> [Double] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let calendar = Calendar.current
        let currentDate = Date()
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        var totalExpenses: Double = 0
        var totalSavings: Double = 0
        var monthlyExpenses: Double = 0
        var monthlySavings: Double = 0
        
        let purchases = TotalData.purchases
        for purchase in purchases {
            func convertPrice(_ price: String) -> Double {
                let cleanedString = price.replacingOccurrences(of: "[^0-9,]", with: "", options: .regularExpression)
                    .replacingOccurrences(of: ",", with: ".")
                return Double(cleanedString) ?? 0
            }
            
            let priceValue = convertPrice(purchase.price)
            totalExpenses += priceValue
            
            if !purchase.oldPrice.isEmpty {
                let oldPriceValue = convertPrice(purchase.oldPrice)
                totalSavings += oldPriceValue - priceValue
            }
            
            if let purchaseDate = dateFormatter.date(from: purchase.date) {
                let purchaseYear = calendar.component(.year, from: purchaseDate)
                let purchaseMonth = calendar.component(.month, from: purchaseDate)
                
                if purchaseYear == currentYear && purchaseMonth == currentMonth {
                    monthlyExpenses += priceValue
                    
                    if !purchase.oldPrice.isEmpty {
                        let oldPriceValue = convertPrice(purchase.oldPrice)
                        monthlySavings += oldPriceValue - priceValue
                    }
                }
            }
        }
        
        return [totalExpenses, totalSavings, monthlyExpenses, monthlySavings]
    }
}
