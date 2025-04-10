//
//  SearchViewController+UITableViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 07.02.2025.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = displayedProducts[indexPath.item]
        router?.showProductScreen(from: product.shop, category: product.category ?? "", productId: product.id ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
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
