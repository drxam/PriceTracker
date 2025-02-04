//
//  MagnitCategoryViewModel.swift
//  PriceTracker
//
//  Created by dread on 23.01.2025.
//

import Foundation
import UIKit

struct MagnitCategoryViewModel {
    var categoryName: String
    var id: Int
    var products: [MagnitProductViewModel]
    
    init(categoryName: String, id: Int, products: [MagnitProductViewModel]) {
        self.categoryName = categoryName
        self.id = id
        self.products = products
    }
}
