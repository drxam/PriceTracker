//
//  MainViewController+UICollectionViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 24.12.2024.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainGoodsCell.reuseId, for: indexPath)
        guard let mainGoodsCell = cell as? MainGoodsCell else { return cell }
        mainGoodsCell.configure(displayedProducts[indexPath.row])
        mainGoodsCell.delegate = self
        return mainGoodsCell
    }
}
