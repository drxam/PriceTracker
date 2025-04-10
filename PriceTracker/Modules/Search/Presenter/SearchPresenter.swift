//
//  SearchPresenter.swift
//  PriceTracker
//
//  Created by dread on 07.02.2025.
//

import Foundation

final class SearchPresenter: SearchPresentationLogic {
    weak var view: SearchDisplayLogic?
    
    func presentProducts(_ products: [ProductModel]) {
        view?.displayProducts(products)
    }
}
