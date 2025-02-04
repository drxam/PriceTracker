//
//  BasketViewController+UITableViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import Foundation
import UIKit

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketViewCell.reuseId, for: indexPath)
        guard let basketViewCell = cell as? BasketViewCell else { return cell }
        return basketViewCell
    }
}
