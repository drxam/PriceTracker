//
//  ProductPresentationLogic.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

protocol ProductPresentationLogic: AnyObject {
    func presentPaterochka(product: PaterochkaProduct)
    func presentMagnit(product: MagnitProduct)
    func presentPerekrestok(product: PaterochkaProduct)
    func presentOkey(product: MagnitProduct)
    
    func setProduct(product: ProductModel)
}
