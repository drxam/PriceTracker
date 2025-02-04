//
//  BasketViewController+UITableViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import Foundation
import UIKit

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showProductScreen()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}
