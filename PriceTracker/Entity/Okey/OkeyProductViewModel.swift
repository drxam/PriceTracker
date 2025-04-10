//
//  OkeyProductViewModel.swift
//  PriceTracker
//
//  Created by dread on 10.04.2025.
//

import Foundation

struct OkeyProductViewModel {
    var image: URL?
    var price: String
    var oldPrice: String?
    var name: String
    var category: String?
    var id: String?
    
    init(image: URL? = nil, price: String, oldPrice: String? = nil, name: String, category: String? = nil, id: String? = nil) {
        self.image = image
        self.price = price
        self.oldPrice = oldPrice
        self.name = name
        self.category = category
        self.id = id
    }
}
