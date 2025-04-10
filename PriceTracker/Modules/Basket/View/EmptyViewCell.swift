//
//  EmptyViewCell.swift
//  PriceTracker
//
//  Created by dread on 09.02.2025.
//

import UIKit

final class EmptyViewCell: UITableViewCell {
    static let reuseId = "EmptyViewCell"
    private let label = UILabel()

    @available(*, unavailable)
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(_ text: String) {
        label.text = text
    }

    private func configureUI() {
        self.selectionStyle = .none
        backgroundColor = .clear
        configureLabel()
    }
    
    private func configureLabel() {
        addSubview(label)
        label.pinCenter(to: self)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
//        label.text = "В корзине нет товаров"
    }
}
