//
//  PerekrestokProduct.swift
//  PriceTracker
//
//  Created by dread on 10.04.2025.
//

import Foundation

struct PerekrestokProduct: Decodable {
    let category: String?
    let images: [String]?
    let name: String?
    let oldPrice: String?
    let price: String?
    let productId: String?
    let rating: Double?
    let scoresCount: Int?
}
