//
//  ProductDisplayLogic.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

protocol ProductDisplayLogic: AnyObject {
    func displayPaterochka(product: PaterochkaProduct)
    func displayMagnit(product: MagnitProduct)
    func displayPerekrestok(product: PaterochkaProduct)
    func displayOkey(product: MagnitProduct)
    
    func setProduct(product: ProductModel)
}
