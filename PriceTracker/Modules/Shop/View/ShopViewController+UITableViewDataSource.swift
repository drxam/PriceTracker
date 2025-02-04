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
            return 5
        case .perekrestok:
            return 5
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
            print(2)
        case .perekrestok:
            print(2)
        case .paterochka:
            shopGoodsCell.configurePaterochka(TotalData.paterochkaAll[currentCategoryIndex].products[indexPath.row])
        case .magnit:
            shopGoodsCell.configureMagnit(TotalData.magnitAll[currentCategoryIndex].products[indexPath.row])
        }
        return shopGoodsCell
    }
}
