//
//  PurchasesViewController+UITableViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 29.12.2024.
//

import Foundation
import UIKit

extension PurchasesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 3
    }
}
