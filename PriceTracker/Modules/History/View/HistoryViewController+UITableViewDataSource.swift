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
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MonthViewCell.reuseId, for: indexPath)
            guard let monthViewCell = cell as? MonthViewCell else { return cell }
            return monthViewCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchasesViewCell.reuseId, for: indexPath)
        guard let purchasesViewCell = cell as? PurchasesViewCell else { return cell }
        return purchasesViewCell
    }
}
