//
//  ShopPresenter.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation
import UIKit

final class ShopPresenter: ShopPresentationLogic {
    weak var view: ShopDisplayLogic?
    
    func presentCategories(_ categories: [CategoryModel]) {
        view?.displayCategories(categories)
    }
    
    func presentMagnit(_ magnit: [MagnitCategoryViewModel]) {
        view?.displayMagnit(magnit)
    }
    
    func presentPaterochka(_ paterochka: [PaterochkaCategoryViewModel]) {
        view?.displayPaterochka(paterochka)
    }
    
    func presentMagnitCategory(_ index: Int) {
        view?.displayMagnitCategory(index)
    }
    
    func presentPaterochkaCategory(_ index: Int) {
        view?.displayPaterochkaCategory(index)
    }
    
    private func formatPrice(_ price: Int) -> String {
        let priceInRubles = Double(price) / 100.0
        return String(format: "%.2f ₽", priceInRubles).replacingOccurrences(of: ".", with: ",")
    }
}
