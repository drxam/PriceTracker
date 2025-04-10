//
//  ShopViewController+UICollectionViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import Foundation
import UIKit

extension ShopViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath {
            selectedIndex = indexPath
            interactor?.fetchProductsForCategory(for: shopType, with: categoriesName[indexPath.row].id ?? "")
        }
    }
}
