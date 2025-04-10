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
            async let perekrestokData = fetchProducts(from: "http://127.0.0.1:5000/perekrestok")
            async let okeyData = fetchProducts(from: "http://127.0.0.1:5000/okey")
            
            async let magnitCategoriesData = fetchProducts(from: "http://127.0.0.1:5000/magnit_cat")
            async let paterochkaCategoriesData = fetchProducts(from: "http://127.0.0.1:5000/5ka_cat")
            async let perekrestokCategoriesData = fetchProducts(from: "http://127.0.0.1:5000/perekrestok_cat")
            async let okeyCategoriesData = fetchProducts(from: "http://127.0.0.1:5000/okey_cat")

            let (magnitResponse, paterochkaResponse, perekrestokResponse, okeyResponse, magnitCategories, paterochkaCategories, perekrestokCategories, okeyCategories) = try await (
                decode(MagnitResponse.self, from: magnitData),
                decode(PaterochkaResponse.self, from: paterochkaData),
                decode(PaterochkaResponse.self, from: perekrestokData),
                decode(MagnitResponse.self, from: okeyData),
                decode([CategoryModel].self, from: magnitCategoriesData),
                decode([CategoryModel].self, from: paterochkaCategoriesData),
                decode([CategoryModel].self, from: perekrestokCategoriesData),
                decode([CategoryModel].self, from: okeyCategoriesData)
            )

            TotalData.magnitRawAll = magnitResponse.categories
            TotalData.paterochkaRawAll = paterochkaResponse.categories
            TotalData.perekrestokRawAll = perekrestokResponse.categories
            TotalData.okeyRawAll = okeyResponse.categories
            
            TotalData.magnitCat = magnitCategories
            TotalData.paterochkaCat = paterochkaCategories
            TotalData.perekrestokCat = perekrestokCategories
            TotalData.okeyCat = okeyCategories

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
