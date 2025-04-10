//
//  TotalData.swift
//  PriceTracker
//
//  Created by dread on 22.01.2025.
//

import Foundation

final class TotalData {
    static var paterochkaCat: [CategoryModel] = []
    static var paterochkaRawAll: [PaterochkaCategory] = []
    static var paterochkaAll: [PaterochkaCategoryViewModel] = []
    static var paterochkaAllProducts: [ProductModel] = []
    
    static var magnitCat: [CategoryModel] = []
    static var magnitRawAll: [MagnitCategory] = []
    static var magnitAll: [MagnitCategoryViewModel] = []
    static var magnitAllProducts: [ProductModel] = []
    
    static var perekrestokCat: [CategoryModel] = []
    static var perekrestokRawAll: [PaterochkaCategory] = []
    static var perekrestokAll: [PerekrestokCategoryViewModel] = []
    static var perekrestokAllProducts: [ProductModel] = []
    
    static var okeyCat: [CategoryModel] = []
    static var okeyRawAll: [MagnitCategory] = []
    static var okeyAll: [OkeyCategoryViewModel] = []
    static var okeyAllProducts: [ProductModel] = []
    
    static var allProducts: [ProductModel] = []
    
    static var purchases: [PurchaseModel] = []
}
