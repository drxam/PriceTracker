//
//  HistoryView.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import UIKit

final class HistoryView: UIView {
    private let screenTitle = UILabel()
    
    let scrollView = UIScrollView()
    let backButton = UIButton(type: .system)
    let wrap = UIView()
    let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
        configureScreenName()
        configureBackButton()
        configureScrollView()
        configureTableView()
    }
    
    private func configureScreenName() {
        addSubview(screenTitle)
        screenTitle.font = UIFont.boldSystemFont(ofSize: 22)
        screenTitle.text = "История покупок"
        screenTitle.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        screenTitle.pinLeft(to: self.leadingAnchor, 30)
        screenTitle.setHeight(25)
        screenTitle.setWidth(200)
    }
    
    private func configureBackButton() {
        addSubview(backButton)
        backButton.pinCenterY(to: screenTitle)
        backButton.pinLeft(to: self.leadingAnchor, 5)
        backButton.setHeight(32)
        backButton.setWidth(20)
        backButton.backgroundColor = .clear
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.tintColor = UIColor(named: "icon_color")
    }
    
    private func configureScrollView() {
        addSubview(scrollView)
        scrollView.pinHorizontal(to: self)
        scrollView.pinTop(to: screenTitle.bottomAnchor, 15)
        scrollView.pinBottom(to: self.bottomAnchor)
        scrollView.frame = self.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
    }
    
    private func configureTableView() {
        scrollView.addSubview(wrap)
        wrap.pinTop(to: scrollView.topAnchor)
        wrap.pinLeft(to: scrollView.safeAreaLayoutGuide.leadingAnchor, 15)
        wrap.pinRight(to: scrollView.safeAreaLayoutGuide.trailingAnchor, 15)
        wrap.pinBottom(to: scrollView.contentLayoutGuide.bottomAnchor)
        wrap.layer.cornerRadius = 30
        wrap.backgroundColor = UIColor(named: "wrap_color")
        
        wrap.addSubview(tableView)
        tableView.pinTop(to: wrap.topAnchor, 10)
        tableView.pinHorizontal(to: wrap, 15)
        tableView.pinBottom(to: wrap.bottomAnchor, 10)
        tableView.setHeight(12 * 80)
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
    }
}
