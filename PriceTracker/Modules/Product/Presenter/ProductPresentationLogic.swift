//
//  ProductPresentationLogic.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

protocol ProductPresentationLogic: AnyObject {
    func presentProduct(product: PaterochkaProduct)
    func presentProduct(product: MagnitProduct)
}
