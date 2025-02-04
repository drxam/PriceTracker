//
//  ProductDisplayLogic.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

protocol ProductDisplayLogic: AnyObject {
    func displayProduct(product: PaterochkaProduct)
    func displayProduct(product: MagnitProduct)
}
