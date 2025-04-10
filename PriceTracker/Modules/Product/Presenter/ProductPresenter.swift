//
//  ProductPresenter.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

final class ProductPresenter: ProductPresentationLogic {
    weak var view: ProductDisplayLogic?
    
    func presentPaterochka(product: PaterochkaProduct) {
        view?.displayPaterochka(product: product)
    }
    
    func presentMagnit(product: MagnitProduct) {
        view?.displayMagnit(product: product)
    }
    
    func presentPerekrestok(product: PaterochkaProduct) {
        view?.displayPerekrestok(product: product)
    }
    
    func presentOkey(product: MagnitProduct) {
        view?.displayOkey(product: product)
    }
    
    func setProduct(product: ProductModel) {
        view?.setProduct(product: product)
    }
}
