//
//  PurchasesViewCell.swift
//  PriceTracker
//
//  Created by dread on 29.12.2024.
//

import UIKit

final class PurchasesViewCell: UITableViewCell {
    static let reuseId = "PurchasesViewCell"
    
    var sum = UILabel()
    var date = UILabel()
    var count = UILabel()
    
    private let purchase = UILabel()
    private let image = UIImageView()
    
    @available(*, unavailable)
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    func configure(_ model: PurchaseModel) {
        sum.text = model.price
        self.count.text = "Товаров: \(model.count)"
        self.date.text = model.date
    }
    
    private func configureUI() {
        configurePurchase()
        configureSum()
        configureDate()
        configureCount()
        configureImage()
    }
    
    private func configurePurchase() {
        addSubview(purchase)
        purchase.text = "Покупка"
        purchase.font = UIFont.systemFont(ofSize: 14)
        purchase.pinLeft(to: self.leadingAnchor, 5)
        purchase.pinTop(to: self.topAnchor, 10)
        purchase.setHeight(20)
        purchase.setWidth(65)
    }
    
    private func configureSum() {
        addSubview(sum)
        sum.font = UIFont.boldSystemFont(ofSize: 13)
        sum.pinLeft(to: self.leadingAnchor, 5)
        sum.pinTop(to: purchase.bottomAnchor, 10)
        sum.setHeight(20)
        sum.setWidth(65)
    }
    
    private func configureDate() {
        addSubview(date)
        date.font = UIFont.systemFont(ofSize: 13)
        date.textColor = .gray
        date.pinLeft(to: purchase.trailingAnchor, 30)
        date.pinTop(to: self.topAnchor, 10)
        date.setHeight(20)
        date.setWidth(120)
    }
    
    private func configureCount() {
        addSubview(count)
        count.font = UIFont.systemFont(ofSize: 13)
        count.textColor = .gray
        count.pinLeft(to: sum.trailingAnchor, 30)
        count.pinTop(to: date.bottomAnchor, 10)
        count.setHeight(20)
        count.setWidth(120)
    }
    
    private func configureImage() {
        addSubview(image)
        image.backgroundColor = .clear
        image.image = UIImage(named: "mdi_cart")
        image.pinRight(to: self.trailingAnchor, 15)
        image.pinCenterY(to: self)
        image.setWidth(28)
        image.setHeight(28)
    }
}
