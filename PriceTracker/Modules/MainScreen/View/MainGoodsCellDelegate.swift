//
//  MainGoodsCellDelegate.swift
//  PriceTracker
//
//  Created by dread on 08.02.2025.
//

import Foundation

protocol MainGoodsCellDelegate: AnyObject {
    func didTapAddButton(for product: ProductModel?)
}
