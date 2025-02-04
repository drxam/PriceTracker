//
//  MonthViewCell.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import UIKit

final class MonthViewCell: UITableViewCell {
    static let reuseId = "MonthViewCell"
    
    let monthLabel = UILabel()
    let priceLabel = UILabel()

    @available(*, unavailable)
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    private func configureUI() {
        configureMonth()
        configurePrice()
    }
    
    private func configureMonth() {
        addSubview(monthLabel)
        monthLabel.pinLeft(to: self.leadingAnchor, 5)
        monthLabel.pinCenterY(to: self)
        monthLabel.setWidth(100)
        monthLabel.font = UIFont.boldSystemFont(ofSize: 14)
        monthLabel.text = "Сентябрь"
    }
    
    private func configurePrice() {
        addSubview(priceLabel)
        priceLabel.pinRight(to: self.trailingAnchor, 15)
        priceLabel.pinCenterY(to: self)
        priceLabel.setWidth(100)
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.text = "2002,95 ₽"
    }
}
