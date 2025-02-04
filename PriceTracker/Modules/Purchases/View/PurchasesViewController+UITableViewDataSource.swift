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
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchasesViewCell.reuseId, for: indexPath)
        guard let purchasesViewCell = cell as? PurchasesViewCell else { return cell }
        return purchasesViewCell
    }
}
