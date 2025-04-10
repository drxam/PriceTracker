//
//  ProductModel.swift
//  PriceTracker
//
//  Created by dread on 24.01.2025.
//

import Foundation
import UIKit

struct ProductModel: Hashable {
    var image: URL?
    var name: String
    var price: String
    var oldPrice: String?
    var shop: ShopType
    var category: String?
    var id: String?
}
