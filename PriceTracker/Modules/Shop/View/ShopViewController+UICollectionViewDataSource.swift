//
//  ShopViewController+UICollectionViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import Foundation
import UIKit

extension ShopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath)
        guard let categoryCell = cell as? CategoryCell else { return cell }
        categoryCell.configure(with: categoriesName[indexPath.row].name)
        cell.isSelected = indexPath == selectedIndex
        return categoryCell
    }
}
