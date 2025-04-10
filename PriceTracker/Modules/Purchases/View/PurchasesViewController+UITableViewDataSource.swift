//
//  PurchasesViewController+UITableViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 29.12.2024.
//

import Foundation
import UIKit

extension PurchasesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TotalData.purchases.count >= 3 ? 3 : TotalData.purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchasesViewCell.reuseId, for: indexPath)
        guard let purchasesViewCell = cell as? PurchasesViewCell else { return cell }
        
        let purchasesCount = TotalData.purchases.count
        let index = indexPath.row
        if purchasesCount < 3 {
            purchasesViewCell.configure(TotalData.purchases[index])
        } else {
            purchasesViewCell.configure(TotalData.purchases[purchasesCount - 3 + index])
        }
        return purchasesViewCell
    }
}
