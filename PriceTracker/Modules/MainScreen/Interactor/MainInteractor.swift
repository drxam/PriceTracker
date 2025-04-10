//
//  MainInteractor.swift
//  PriceTracker
//
//  Created by dread on 24.01.2025.
//

import Foundation

final class MainInteractor: MainBusinessLogic {
    var presenter: MainPresentationLogic?
    private var currentPage = 0
    private let pageSize = 20
    private let allProducts: [ProductModel] = TotalData.allProducts
    
    func loadMoreProducts() {
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allProducts.count)
        
        guard startIndex < endIndex else { return }
        
        let newProducts = Array(allProducts[startIndex..<endIndex])
        currentPage += 1
        
        presenter?.presentProducts(newProducts)
    }
    
    func plusButtonTapped(for product: ProductModel?) {
        NotificationCenter.default.post(name: NSNotification.Name("AddNewItem"), object: product)
    }
}
