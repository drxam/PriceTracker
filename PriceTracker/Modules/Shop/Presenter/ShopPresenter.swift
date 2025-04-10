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
    
    func presentOkey(_ okey: [OkeyCategoryViewModel]) {
        view?.displayOkey(okey)
    }
    
    func presentPerekrestok(_ perekrestok: [PerekrestokCategoryViewModel]) {
        view?.displayPerekrestok(perekrestok)
    }
    
    func presentMagnitCategory(_ index: Int) {
        view?.displayMagnitCategory(index)
    }
    
    func presentPaterochkaCategory(_ index: Int) {
        view?.displayPaterochkaCategory(index)
    }
}
