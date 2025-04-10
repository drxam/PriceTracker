//
//  BasketViewCellDelegate.swift
//  PriceTracker
//
//  Created by dread on 12.02.2025.
//

import Foundation

protocol BasketViewCellDelegate: AnyObject {
    func didTapPlusButton(_ product: String)
    func didTapMinusButton(_ product: String)
}
