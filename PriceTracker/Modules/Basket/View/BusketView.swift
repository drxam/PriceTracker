//
//  BasketView.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import UIKit

class BasketView: UIView {
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
    }
}
