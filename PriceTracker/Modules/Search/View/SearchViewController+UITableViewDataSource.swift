//
//  SearchViewController+UITableViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 07.02.2025.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchGoodsCell.reuseId, for: indexPath)
        guard let searchGoodsCell = cell as? SearchGoodsCell else { return cell }
        searchGoodsCell.configure(displayedProducts[indexPath.row])
        searchGoodsCell.delegate = self
        return searchGoodsCell
    }
}
