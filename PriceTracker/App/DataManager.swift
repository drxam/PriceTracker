//
//  DataManager.swift
//  PriceTracker
//
//  Created by dread on 24.01.2025.
//

import Foundation

final class DataManager {
    private init() {}
    static let shared = DataManager()
    
    func loadAllData() {
        loadMagnitData()
        loadPaterochkaData()
        loadPerekrestokData()
        loadOkeyData()
        
        collectAllProducts()
    }
    
    func loadPaterochkaData() {
        let categories = TotalData.paterochkaRawAll
        let resultCategories: [PaterochkaCategoryViewModel] = categories.map { category in
            let productsViewModels: [PaterochkaProductViewModel] = category.products?.compactMap { product in
                let imageUrl = product.images?.first.flatMap { URL(string: $0) }
                let price = product.price ?? product.oldPrice
                let oldPrice = product.price == nil ? nil : product.oldPrice
                
                return PaterochkaProductViewModel(
                    image: imageUrl,
                    price: formatPrice(price),
                    oldPrice: formatPrice(oldPrice),
                    name: product.name ?? "",
                    category: product.category,
                    id: product.productId
                )
            } ?? []
            
            return PaterochkaCategoryViewModel(
                categoryName: category.categoryName ?? "",
                id: category.id ?? "",
                products: productsViewModels
            )
        }
        
        TotalData.paterochkaAll = resultCategories
        
        TotalData.paterochkaAllProducts = convertToProductModels(from: TotalData.paterochkaAll)
    }

    
    private func loadMagnitData() {
        let magnit = TotalData.magnitRawAll
        let magnitCategories: [MagnitCategoryViewModel] = magnit.compactMap { category in
            let categoryName = (category.categoryName?.isEmpty ?? true) ? "Молоко, яйцо, сыр" : category.categoryName!
            
            guard let id = category.id,
                  let products = category.products else {
                return nil
            }
            
            let productViewModels: [MagnitProductViewModel] = products.compactMap { product in
                guard let name = product.name, let price = product.price else {
                    return nil
                }
                
                let formattedPrice = formatPrice(price)
                let formattedOldPrice = product.oldPrice != nil ? formatPrice(product.oldPrice!) : nil
                
                let imageUrl = product.images?.first.flatMap { URL(string: $0) }
                
                return MagnitProductViewModel(image: imageUrl, price: formattedPrice, oldPrice: formattedOldPrice, name: name, category: product.category, id: product.productId)
            }
            
            return MagnitCategoryViewModel(categoryName: categoryName, id: id, products: productViewModels)
        }
        
        TotalData.magnitAll = magnitCategories
        
        TotalData.magnitAllProducts = convertToProductModels(from: TotalData.magnitAll)
    }
    
    func loadPerekrestokData() {
        let categories = TotalData.perekrestokRawAll
        let resultCategories: [PerekrestokCategoryViewModel] = categories.map { category in
            let productsViewModels: [PerekrestokProductViewModel] = category.products?.compactMap { product in
                let imageUrl = product.images?.first.flatMap { URL(string: $0) }
                let price = product.price ?? product.oldPrice
                let oldPrice = product.price == nil ? nil : product.oldPrice
                
                return PerekrestokProductViewModel(
                    image: imageUrl,
                    price: formatPrice(price),
                    oldPrice: formatPrice(oldPrice),
                    name: product.name ?? "",
                    category: product.category,
                    id: product.productId
                )
            } ?? []
            
            return PerekrestokCategoryViewModel(
                categoryName: category.categoryName ?? "",
                id: category.id ?? "",
                products: productsViewModels
            )
        }
        
        TotalData.perekrestokAll = resultCategories
        
        TotalData.perekrestokAllProducts = convertToProductModels(from: TotalData.perekrestokAll)
    }
    
    private func loadOkeyData() {
        let magnit = TotalData.okeyRawAll
        let magnitCategories: [OkeyCategoryViewModel] = magnit.compactMap { category in
            let categoryName = (category.categoryName?.isEmpty ?? true) ? "Молоко, яйцо, сыр" : category.categoryName!
            
            guard let id = category.id,
                  let products = category.products else {
                return nil
            }
            
            let productViewModels: [OkeyProductViewModel] = products.compactMap { product in
                guard let name = product.name, let price = product.price else {
                    return nil
                }
                
                let formattedPrice = formatPrice(price)
                let formattedOldPrice = product.oldPrice != nil ? formatPrice(product.oldPrice!) : nil
                
                let imageUrl = product.images?.first.flatMap { URL(string: $0) }
                
                return OkeyProductViewModel(image: imageUrl, price: formattedPrice, oldPrice: formattedOldPrice, name: name, category: product.category, id: product.productId)
            }
            
            return OkeyCategoryViewModel(categoryName: categoryName, id: id, products: productViewModels)
        }
        
        TotalData.okeyAll = magnitCategories
        
        TotalData.okeyAllProducts = convertToProductModels(from: TotalData.okeyAll)
    }
    
    private func convertToProductModels(from сategories: [MagnitCategoryViewModel]) -> [ProductModel] {
        return сategories.flatMap { category in
            category.products.map { product in
                ProductModel(
                    image: product.image,
                    name: product.name,
                    price: product.price,
                    oldPrice: product.oldPrice,
                    shop: .magnit,
                    category: product.category,
                    id: product.id
                )
            }
        }
    }
    
    private func convertToProductModels(from сategories: [PaterochkaCategoryViewModel]) -> [ProductModel] {
        return сategories.flatMap { category in
            category.products.map { product in
                ProductModel(
                    image: product.image,
                    name: product.name,
                    price: product.price,
                    oldPrice: product.oldPrice,
                    shop: .paterochka,
                    category: product.category,
                    id: product.id
                )
            }
        }
    }
    
    private func convertToProductModels(from сategories: [OkeyCategoryViewModel]) -> [ProductModel] {
        return сategories.flatMap { category in
            category.products.map { product in
                ProductModel(
                    image: product.image,
                    name: product.name,
                    price: product.price,
                    oldPrice: product.oldPrice,
                    shop: .okey,
                    category: product.category,
                    id: product.id
                )
            }
        }
    }
    
    private func convertToProductModels(from сategories: [PerekrestokCategoryViewModel]) -> [ProductModel] {
        return сategories.flatMap { category in
            category.products.map { product in
                ProductModel(
                    image: product.image,
                    name: product.name,
                    price: product.price,
                    oldPrice: product.oldPrice,
                    shop: .perekrestok,
                    category: product.category,
                    id: product.id
                )
            }
        }
    }
    
    private func collectAllProducts() {
        TotalData.allProducts += TotalData.magnitAllProducts
        TotalData.allProducts += TotalData.paterochkaAllProducts
        TotalData.allProducts += TotalData.perekrestokAllProducts
        TotalData.allProducts += TotalData.okeyAllProducts
        TotalData.allProducts.shuffle()
    }
    
    private func formatPrice(_ price: Int) -> String {
        let priceInRubles = Double(price) / 100.0
        return String(format: "%.2f ₽", priceInRubles).replacingOccurrences(of: ".", with: ",")
    }
    
    func formatPrice(_ price: String?) -> String {
        guard let price = price else { return "" }
        if let doubleValue = Double(price) {
            let formattedPrice = String(format: "%.2f", doubleValue).replacingOccurrences(of: ".", with: ",")
            return "\(formattedPrice) ₽"
        }
        return price
    }
}
