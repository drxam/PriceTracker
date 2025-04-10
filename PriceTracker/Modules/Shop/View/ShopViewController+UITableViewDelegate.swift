//
//  ShopViewController+UITableViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import Foundation
import UIKit

extension ShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch shopType {
        case .okey:
            let product = displayedProductsOkey[indexPath.item]
            router?.showProductScreen(from: ShopType.okey, category: product.category ?? "", productId: product.id ?? "")
        case .perekrestok:
            let product = displayedProductsPerekrestok[indexPath.item]
            router?.showProductScreen(from: ShopType.perekrestok, category: product.category ?? "", productId: product.id ?? "")
        case .paterochka:
            let product = displayedProductsPaterochka[indexPath.item]
            router?.showProductScreen(from: ShopType.paterochka, category: product.category ?? "", productId: product.id ?? "")
        case .magnit:
            let product = displayedProductsMagnit[indexPath.item]
            router?.showProductScreen(from: ShopType.magnit, category: product.category ?? "", productId: product.id ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - scrollViewHeight - 100 {
            loadMoreProducts()
        }
    }
}
