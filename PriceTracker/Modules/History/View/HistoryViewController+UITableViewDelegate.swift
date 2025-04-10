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
        return 70
    }
}
