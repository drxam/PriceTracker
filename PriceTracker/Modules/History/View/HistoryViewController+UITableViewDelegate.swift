//
//  HistoryViewController+UITableViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 4 == 0 {
            return 30
        }
        return 70
    }
}
