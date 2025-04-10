//
//  ProductInteractor.swift
//  PriceTracker
//
//  Created by dread on 01.02.2025.
//

import Foundation

final class ProductInteractor: ProductBusinessLogic {
    var presenter: ProductPresentationLogic?
    
    func fetchProduct(from: ShopType, category: String, productId: String) {
        switch from {
        case .okey:
            let cat = category.trimmingCharacters(in: .whitespaces)
            if let categoryOut = TotalData.okeyRawAll.first(where: { $0.categoryName == cat }), let productOut = categoryOut.products?.first(where: { $0.productId == productId }) {
                presenter?.presentOkey(product: productOut)
            }
            
            if let product = TotalData.allProducts.first(where: { $0.category ?? "" == cat && $0.id == productId }) {
                presenter?.setProduct(product: product)
            }
        case .perekrestok:
            if let categoryOut = TotalData.perekrestokRawAll.first(where: { $0.categoryName == category }), let productOut = categoryOut.products?.first(where: { $0.productId == productId }) {
                presenter?.presentPerekrestok(product: productOut)
            }
            
            if let product = TotalData.allProducts.first(where: { $0.category ?? "" == category && $0.id == productId }) {
                presenter?.setProduct(product: product)
            }
        case .paterochka:
            if let categoryOut = TotalData.paterochkaRawAll.first(where: { $0.categoryName == category }), let productOut = categoryOut.products?.first(where: { $0.productId == productId }) {
                presenter?.presentPaterochka(product: productOut)
            }
            
            if let product = TotalData.allProducts.first(where: { $0.category ?? "" == category && $0.id == productId }) {
                presenter?.setProduct(product: product)
            }
        case .magnit:
            let cat = category.trimmingCharacters(in: .whitespaces)
            if let categoryOut = TotalData.magnitRawAll.first(where: { $0.categoryName == cat }), let productOut = categoryOut.products?.first(where: { $0.productId == productId }) {
                presenter?.presentMagnit(product: productOut)
            }
            
            if let product = TotalData.allProducts.first(where: { $0.category ?? "" == cat && $0.id == productId }) {
                presenter?.setProduct(product: product)
            }
        }
    }
    
    func plusButtonTapped(for product: ProductModel?) {
        NotificationCenter.default.post(name: NSNotification.Name("AddNewItem"), object: product)
    }
}
