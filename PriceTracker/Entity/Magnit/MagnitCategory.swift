//
//  MagnitCategoryModel.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation
import UIKit

struct MagnitCategory: Decodable {
    var categoryName: String?
    var id: Int?
    var products: [MagnitProduct]?
}
