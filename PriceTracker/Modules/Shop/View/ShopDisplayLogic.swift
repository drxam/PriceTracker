//
//  ShopDisplayLogic.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation

protocol ShopDisplayLogic: AnyObject {
    func displayCategories(_ categories: [CategoryModel])
    func displayMagnit(_ categories: [MagnitCategoryViewModel])
    func displayPaterochka(_ categories: [PaterochkaCategoryViewModel])
    func displayMagnitCategory(_ index: Int)
    func displayPaterochkaCategory(_ index: Int)
}
