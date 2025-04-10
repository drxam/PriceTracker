//
//  PurchasesPresenter.swift
//  PriceTracker
//
//  Created by dread on 13.03.2025.
//

import Foundation

final class PurchasesPresenter: PurchasesPresentationLogic {
    var view: PurchasesDisplayLogic?
    
    func presentPurchases(_ expenses: [Double]) {
        var res: [String] = []
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = ""
        
        for value in expenses {
            if let formattedString = formatter.string(from: NSNumber(value: value)) {
                res.append("\(formattedString) ₽")
            } else {
                res.append("")
            }
        }
        
        view?.displayPurchases(res)
    }
}
