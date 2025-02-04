//
//  ShopPresentationLogic.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation

protocol ShopPresentationLogic: AnyObject {
    func presentCategories(_ categories: [CategoryModel])
    func presentMagnit(_ magnit: [MagnitCategoryViewModel])
    func presentPaterochka(_ paterochka: [PaterochkaCategoryViewModel])
//    func presentPerekrestok(_ perekrestok: [MagnitCategoryModel])
//    func presentOkey(_ okey: [MagnitCategoryModel])
    
    func presentMagnitCategory(_ index: Int)
    func presentPaterochkaCategory(_ index: Int)
}
