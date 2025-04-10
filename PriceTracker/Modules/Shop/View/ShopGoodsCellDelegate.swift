//
//  ShopGoodsCellDelegate.swift
//  PriceTracker
//
//  Created by dread on 08.02.2025.
//

import Foundation

protocol ShopGoodsCellDelegate: AnyObject {
    func didTapAddButton(for product: ProductModel?)
}
