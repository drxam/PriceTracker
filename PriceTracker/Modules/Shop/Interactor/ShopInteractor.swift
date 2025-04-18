//
//  ShopInteractor.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation

final class ShopInteractor: ShopBusinessLogic {
    var presenter: ShopPresentationLogic?
    
    func fetchCategories(for shopType: ShopType) {
        var categories: [CategoryModel] = []

        switch shopType {
        case .magnit:
            categories = TotalData.magnitCat
        case .paterochka:
            categories = TotalData.paterochkaCat
        case .okey:
            categories = TotalData.okeyCat
        case .perekrestok:
            categories = TotalData.perekrestokCat
        }
        
        presenter?.presentCategories(categories)
    }
    
    func fetchProducts(for shopType: ShopType) {
        switch shopType {
        case .okey:
            presenter?.presentOkey(TotalData.okeyAll)
        case .perekrestok:
            presenter?.presentPerekrestok(TotalData.perekrestokAll)
        case .paterochka:
            presenter?.presentPaterochka(TotalData.paterochkaAll)
        case .magnit:
            presenter?.presentMagnit(TotalData.magnitAll)
        }
    }
    
    func fetchProductsForCategory(for shopType: ShopType, with categoryId: String) {
        switch shopType {
        case .okey:
            if let index = TotalData.okeyAll.firstIndex(where: { String($0.id) == categoryId }) {
                presenter?.presentMagnitCategory(index)
            } else {
                print("Категория с id \(categoryId) не найдена.")
            }
        case .perekrestok:
            if let index = TotalData.perekrestokAll.firstIndex(where: { $0.id == categoryId }) {
                presenter?.presentPaterochkaCategory(index)
            } else {
                print("Категория с id \(categoryId) не найдена.")
            }
        case .paterochka:
            if let index = TotalData.paterochkaAll.firstIndex(where: { $0.id == categoryId }) {
                presenter?.presentPaterochkaCategory(index)
            } else {
                print("Категория с id \(categoryId) не найдена.")
            }
        case .magnit:
            if let index = TotalData.magnitAll.firstIndex(where: { String($0.id) == categoryId }) {
                presenter?.presentMagnitCategory(index)
            } else {
                print("Категория с id \(categoryId) не найдена.")
            }
        }
    }
    
    func plusButtonTapped(for product: ProductModel?) {
        NotificationCenter.default.post(name: NSNotification.Name("AddNewItem"), object: product)
    }
}
