//
//  PaterochkaResponse.swift
//  PriceTracker
//
//  Created by dread on 26.01.2025.
//

import Foundation

struct PaterochkaResponse: Decodable {
    let categories: [PaterochkaCategory]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempCategories: [PaterochkaCategory] = []
        for key in container.allKeys {
            let categoryName = key.stringValue
            let nestedContainer = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: key)
            let id = try nestedContainer.decode(String.self, forKey: .id)
            let rawProducts = try nestedContainer.decode([RawPaterochkaProduct].self, forKey: .products)

            let products = rawProducts.map { rawProduct in
                PaterochkaProduct(
                    category: categoryName,
                    images: rawProduct.imageLinks.normal,
                    name: rawProduct.name,
                    oldPrice: rawProduct.prices.regular,
                    price: rawProduct.prices.discount,
                    productId: String(rawProduct.plu),
                    rating: rawProduct.rating,
                    scoresCount: rawProduct.ratesCount
                )
            }

            let model = PaterochkaCategory(categoryName: categoryName, id: id, products: products)
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

private struct RawPaterochkaProduct: Decodable {
    let imageLinks: ImageLinks
    let name: String
    let prices: Prices
    let plu: Int
    let rating: Double?
    let ratesCount: Int?

    private enum CodingKeys: String, CodingKey {
        case imageLinks = "image_links"
        case name, prices, plu, rating
        case ratesCount = "rates_count"
    }
}

private struct ImageLinks: Decodable {
    let normal: [String]
}

private struct Prices: Decodable {
    let discount: String?
    let regular: String
}
