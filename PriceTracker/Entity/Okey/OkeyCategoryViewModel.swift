//
//  OkeyCategoryViewModel.swift
//  PriceTracker
//
//  Created by dread on 10.04.2025.
//

import Foundation

struct OkeyCategoryViewModel {
    var categoryName: String
    var id: Int
    var products: [OkeyProductViewModel]
    
    init(categoryName: String, id: Int, products: [OkeyProductViewModel]) {
        self.categoryName = categoryName
        self.id = id
        self.products = products
    }
}
