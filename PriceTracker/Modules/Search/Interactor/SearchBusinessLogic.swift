//
//  SearchBusinessLogic.swift
//  PriceTracker
//
//  Created by dread on 07.02.2025.
//

import Foundation

protocol SearchBusinessLogic: AnyObject {
    func searchProducts(_ query: String, _ shopType: ShopType?)
    func loadMoreProducts()
    func plusButtonTapped(for product: ProductModel?)
}
