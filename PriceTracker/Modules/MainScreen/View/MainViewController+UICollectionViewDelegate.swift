//
//  MainViewController+UICollectionViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 24.12.2024.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = displayedProducts[indexPath.item]
        router?.showProductScreen(from: product.shop, category: product.category ?? "", productId: product.id ?? "")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - scrollViewHeight - 100 {
            interactor?.loadMoreProducts()
        }
    }
}
