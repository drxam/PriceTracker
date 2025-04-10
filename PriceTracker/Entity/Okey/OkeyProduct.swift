//
//  OkeyProduct.swift
//  PriceTracker
//
//  Created by dread on 10.04.2025.
//

import Foundation

struct OkeyProduct: Decodable {
    let category: String?
    let commentsCount: Int?
    let images: [String]?
    let name: String?
    let oldPrice: Int?
    let price: Int?
    let productId: String?
    let rating: Double?
    let scoresCount: Int?
}
