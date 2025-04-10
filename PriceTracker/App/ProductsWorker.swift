//
//  ProductsWorker.swift
//  PriceTracker
//
//  Created by dread on 21.01.2025.
//

import Foundation

final class ProductsWorker {
    static let shared = ProductsWorker()
    private init() {}
    
    func loadProducts() async {
        do {
            async let magnitData = fetchProducts(from: "http://127.0.0.1:5000/magnit")
            async let paterochkaData = fetchProducts(from: "http://127.0.0.1:5000/5ka")
            async let magnitCategoriesData = fetchProducts(from: "http://127.0.0.1:5000/magnit_cat")
            async let paterochkaCategoriesData = fetchProducts(from: "http://127.0.0.1:5000/5ka_cat")

            let (magnitResponse, paterochkaResponse, magnitCategories, paterochkaCategories) = try await (
                decode(MagnitResponse.self, from: magnitData),
                decode(PaterochkaResponse.self, from: paterochkaData),
                decode([CategoryModel].self, from: magnitCategoriesData),
                decode([CategoryModel].self, from: paterochkaCategoriesData)
            )

            TotalData.magnitRawAll = magnitResponse.categories
            TotalData.paterochkaRawAll = paterochkaResponse.categories
            TotalData.magnitCat = magnitCategories
            TotalData.paterochkaCat = paterochkaCategories

        } catch {
            print("Ошибка загрузки данных: \(error.localizedDescription)")
        }
    }

    private func fetchProducts(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
