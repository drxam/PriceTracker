//
//  PurchasesPresentationLogic.swift
//  PriceTracker
//
//  Created by dread on 13.03.2025.
//

import Foundation

protocol PurchasesPresentationLogic: AnyObject {
    func presentPurchases(_ expenses: [Double])
}
