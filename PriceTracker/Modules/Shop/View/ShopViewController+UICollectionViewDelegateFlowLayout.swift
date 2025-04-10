//
//  ShopViewController+UICollectionViewDelegateFlowLayout.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import Foundation
import UIKit

extension ShopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = categoriesName[indexPath.row].name ?? ""
        let text = category.isEmpty == false ? category : "Молоко, яйцо, сыр"
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 20
        return CGSize(width: width, height: 30)
    }
}
