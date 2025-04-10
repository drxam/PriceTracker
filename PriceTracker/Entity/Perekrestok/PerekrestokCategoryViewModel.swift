//
//  PerekrestokCategoryViewModel.swift
//  PriceTracker
//
//  Created by dread on 10.04.2025.
//

import Foundation

struct PerekrestokCategoryViewModel {
    var categoryName: String
    var id: String
    var products: [PerekrestokProductViewModel]
    
    init(categoryName: String, id: String, products: [PerekrestokProductViewModel]) {
        self.categoryName = categoryName
        self.id = id
        self.products = products
    }
}
