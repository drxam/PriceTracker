//
//  HistoryViewController+UITableViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TotalData.purchases.count == 0 ? 1 : TotalData.purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if TotalData.purchases.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyViewCell.reuseId, for: indexPath)
            guard let emptyCell = cell as? EmptyViewCell else { return cell }
            emptyCell.configure("История покупок пуста")
            return emptyCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchasesViewCell.reuseId, for: indexPath)
        guard let purchasesViewCell = cell as? PurchasesViewCell else { return cell }
        purchasesViewCell.configure(TotalData.purchases[indexPath.row])
        return purchasesViewCell
    }
}
