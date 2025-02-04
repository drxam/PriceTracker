//
//  MagnitResponse.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation

struct MagnitResponse: Decodable {
    let categories: [MagnitCategory]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempCategories: [MagnitCategory] = []
        for key in container.allKeys {
            let categoryName = key.stringValue.isEmpty ? "Молоко, яйцо, сыр" : key.stringValue
            let nestedContainer = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: key)
            let id = try nestedContainer.decode(Int.self, forKey: .id)
            let products = try nestedContainer.decode([MagnitProduct].self, forKey: .products)

            let model = MagnitCategory(categoryName: categoryName, id: id, products: products)
            tempCategories.append(model)
        }
        self.categories = tempCategories
    }

    private enum NestedKeys: String, CodingKey {
        case id
        case products
    }

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            return nil
        }
    }
}
