//
//  MainBusinessLogic.swift
//  PriceTracker
//
//  Created by dread on 24.01.2025.
//

import Foundation
import UIKit

protocol MainBusinessLogic: AnyObject {
    func loadMoreProducts()
    func plusButtonTapped(for product: ProductModel?)
}
