//
//  PurchasesBusinessLogic.swift
//  PriceTracker
//
//  Created by dread on 13.03.2025.
//

import Foundation

protocol PurchasesBusinessLogic: AnyObject {
    func addNewPurchase(_ new: PurchaseModel)
}
