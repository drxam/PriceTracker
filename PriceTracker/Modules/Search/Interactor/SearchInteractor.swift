//
//  SearchInteractor.swift
//  PriceTracker
//
//  Created by dread on 07.02.2025.
//

import Foundation

final class SearchInteractor: SearchBusinessLogic {
    var presenter: SearchPresentationLogic?
    private var currentPage = 0
    private let pageSize = 20
    private var foundProducts: [ProductModel] = []
    
    func searchProducts(_ query: String, _ shopType: ShopType?) {
        clearData()
        var products = TotalData.allProducts
        
        if let shop = shopType {
            switch shop {
            case .magnit:
                products = TotalData.magnitAllProducts
            case .paterochka:
                products = TotalData.paterochkaAllProducts
            case .okey:
                print("SearchInteractor")
            case .perekrestok:
                print("SearchInteractor")
            }
        }
        
        let lowercasedQueryWords = query.lowercased().split(separator: " ")
        let queryWordCount = lowercasedQueryWords.count // Количество слов в запросе
        
        foundProducts = products
            .compactMap { product -> (ProductModel, Int, Bool, Int, Int, Bool)? in
                let name = product.name.lowercased()
                let nameWords = name.split(separator: " ")
                let matches = lowercasedQueryWords.filter { nameWords.contains($0) }.count
                let firstMatchIndex = nameWords.firstIndex(where: { lowercasedQueryWords.contains($0) }) ?? Int.max
                let hasExactWordCount = nameWords.count == queryWordCount // Совпадает ли количество слов
                let nameWordCount = nameWords.count // Количество слов в названии
                let hasDiscount = product.oldPrice != nil
                
                guard matches > 0 else { return nil }
                
                return (product, matches, hasExactWordCount, firstMatchIndex, nameWordCount, hasDiscount)
            }
            .sorted { lhs, rhs in
                if lhs.1 != rhs.1 { return lhs.1 > rhs.1 }
                if lhs.2 != rhs.2 { return lhs.2 }
                if lhs.3 != rhs.3 { return lhs.3 < rhs.3 }
                if lhs.4 != rhs.4 { return lhs.4 < rhs.4 }
                return !lhs.5
            }
            .map { $0.0 }
    }
    
    func loadMoreProducts() {
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, foundProducts.count)
        
        guard startIndex < endIndex else { return }
        
        let newProducts = Array(foundProducts[startIndex..<endIndex])
        currentPage += 1
        
        presenter?.presentProducts(newProducts)
    }
    
    func plusButtonTapped(for product: ProductModel?) {
        NotificationCenter.default.post(name: NSNotification.Name("AddNewItem"), object: product)
    }
    
    private func clearData() {
        currentPage = 0
        foundProducts = []
    }
}
