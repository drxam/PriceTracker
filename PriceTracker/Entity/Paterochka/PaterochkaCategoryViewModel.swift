//
//  PaterochkaCategoryViewModel.swift
//  PriceTracker
//
//  Created by dread on 26.01.2025.
//

import Foundation
import UIKit

struct PaterochkaCategoryViewModel {
    var categoryName: String
    var id: String
    var products: [PaterochkaProductViewModel]
    
    init(categoryName: String, id: String, products: [PaterochkaProductViewModel]) {
        self.categoryName = categoryName
        self.id = id
        self.products = products
    }
}
