//
//  ProductPresenter.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

final class ProductPresenter: ProductPresentationLogic {
    weak var view: ProductDisplayLogic?
    
    func presentProduct(product: PaterochkaProduct) {
        view?.displayProduct(product: product)
    }
    
    func presentProduct(product: MagnitProduct) {
        view?.displayProduct(product: product)
    }
    
    func setProduct(product: ProductModel) {
        view?.setProduct(product: product)
    }
}
