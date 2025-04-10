//
//  ShopViewController+UITableViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import Foundation
import UIKit

extension ShopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch shopType {
        case .okey:
            return displayedProductsOkey.count
        case .perekrestok:
            return displayedProductsPerekrestok.count
        case .paterochka:
            return displayedProductsPaterochka.count
        case .magnit:
            return displayedProductsMagnit.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopGoodsCell.reuseId, for: indexPath)
        guard let shopGoodsCell = cell as? ShopGoodsCell else { return cell }
        switch shopType {
        case .okey:
            shopGoodsCell.configureOkey(TotalData.okeyAll[currentCategoryIndex].products[indexPath.row])
        case .perekrestok:
            shopGoodsCell.configurePerekrestok(TotalData.perekrestokAll[currentCategoryIndex].products[indexPath.row])
        case .paterochka:
            shopGoodsCell.configurePaterochka(TotalData.paterochkaAll[currentCategoryIndex].products[indexPath.row])
        case .magnit:
            shopGoodsCell.configureMagnit(TotalData.magnitAll[currentCategoryIndex].products[indexPath.row])
        }
        shopGoodsCell.delegate = self
        return shopGoodsCell
    }
}
