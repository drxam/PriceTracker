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
            print("ProductInteractor")
        case .perekrestok:
            print("ProductInteractor")
        case .paterochka:
            if let categoryOut = TotalData.paterochkaRawAll.first(where: { $0.categoryName == category }), let productOut = categoryOut.products?.first(where: { $0.productId == productId }) {
                presenter?.presentProduct(product: productOut)
            }
        case .magnit:
            if let categoryOut = TotalData.magnitRawAll.first(where: { $0.categoryName == category }), let productOut = categoryOut.products?.first(where: { $0.productId == productId }) {
                presenter?.presentProduct(product: productOut)
            }
        }
    }
}
