//
//  PaterochkaProduct.swift
//  PriceTracker
//
//  Created by dread on 26.01.2025.
//

import Foundation

struct PaterochkaProduct: Decodable {
    let category: String?
    let images: [String]?
    let name: String?
    let oldPrice: String?
    let price: String?
    let productId: String?
    let rating: Double?
    let scoresCount: Int?
}
