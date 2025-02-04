//
//  MainPresenter.swift
//  PriceTracker
//
//  Created by dread on 24.01.2025.
//

import Foundation

final class MainPresenter: MainPresentationLogic {
    weak var view: MainDisplayLogic?
    
    func presentProducts(_ products: [ProductModel]) {
        view?.displayProducts(products)
    }
}
