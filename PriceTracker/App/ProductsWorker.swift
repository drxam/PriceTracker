//
//  ProductsWorker.swift
//  PriceTracker
//
//  Created by dread on 21.01.2025.
//

import Foundation

final class ProductsWorker {
    func loadProducts(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchProducts(from: "http://127.0.0.1:5000/magnit") { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let magnitResponse = try decoder.decode(MagnitResponse.self, from: data)
                    TotalData.magnitRawAll = magnitResponse.categories
                } catch {
                    print("Ошибка декодирования магнита: \(error)")
                }
            case .failure(let error):
                print("Ошибка загрузки данных: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchProducts(from: "http://127.0.0.1:5000/5ka") { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let paterochkaResponse = try decoder.decode(PaterochkaResponse.self, from: data)
                    TotalData.paterochkaRawAll = paterochkaResponse.categories
                } catch {
                    print("Ошибка декодирования пятерочки: \(error)")
                }
            case .failure(let error):
                print("Ошибка загрузки данных: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchProducts(from: "http://127.0.0.1:5000/5ka_cat") { result in
            switch result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode([CategoryModel].self, from: data)
                    TotalData.paterochkaCat = categories
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            case .failure(let error):
                print("Ошибка загрузки данных: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchProducts(from: "http://127.0.0.1:5000/magnit_cat") { result in
            switch result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode([CategoryModel].self, from: data)
                    TotalData.magnitCat = categories
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            case .failure(let error):
                print("Ошибка загрузки данных: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func fetchProducts(from url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
