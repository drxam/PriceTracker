//
//  CategoryCell.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    static let reuseId = "CategoryCell"
    let wrap = UIView()
    let name = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            wrap.backgroundColor = isSelected ? UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1) : UIColor(named: "wrap_color")
        }
    }
    
    func configure(with name: String?) {
        self.name.text = name?.isEmpty == false ? name : "Молоко, яйцо, сыр"
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        addSubview(wrap)
        wrap.pin(to: self)
        wrap.layer.cornerRadius = 12
        wrap.layer.masksToBounds = true
        wrap.backgroundColor = UIColor(named: "wrap_color")
        
        wrap.addSubview(name)
        name.pinCenter(to: wrap)
        name.font = .systemFont(ofSize: 14)
    }
}
