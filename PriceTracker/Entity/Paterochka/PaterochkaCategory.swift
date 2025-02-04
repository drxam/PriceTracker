//
//  PaterochkaCategory.swift
//  PriceTracker
//
//  Created by dread on 26.01.2025.
//

import Foundation
import UIKit

struct PaterochkaCategory: Decodable {
    var categoryName: String?
    var id: String?
    var products: [PaterochkaProduct]?
}
