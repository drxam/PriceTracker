//
//  SearchView.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import UIKit

final class SearchView: UIView {
    let scrollView = UIScrollView()
    
    let screenTitle = UILabel()
    
    let searchText = UITextView()
    let searchWrap = UIView()
    let searchIcon = UIImageView()
    
    let backButton = UIButton(type: .system)
    let goods = UITableView(frame: .zero)
    
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
        configureScreenName()
        configureSearch()
        configureBackButton()
        configureGoods()
    }
    
    private func configureScreenName() {
        addSubview(screenTitle)
        screenTitle.font = UIFont.boldSystemFont(ofSize: 22)
        screenTitle.text = "Поиск"
        screenTitle.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        screenTitle.pinLeft(to: self.safeAreaLayoutGuide.leadingAnchor, 30)
        screenTitle.setHeight(20)
        screenTitle.setWidth(100)
    }
    
    private func configureSearch() {
        addSubview(searchWrap)
        searchWrap.backgroundColor = UIColor(named: "wrap_color")
        searchWrap.layer.cornerRadius = 22.5
        searchWrap.pinTop(to: screenTitle.bottomAnchor, 13)
        searchWrap.pinLeft(to: self.safeAreaLayoutGuide.leadingAnchor, 15)
        searchWrap.pinRight(to: self.safeAreaLayoutGuide.trailingAnchor, 15)
        searchWrap.setHeight(45)
        
        searchWrap.addSubview(searchIcon)
        searchIcon.backgroundColor = .clear
        searchIcon.image = UIImage(named: "search")
        searchIcon.pinCenterY(to: searchWrap)
        searchIcon.pinLeft(to: searchWrap.leadingAnchor, 15)
        searchIcon.setWidth(25)
        searchIcon.setHeight(25)
        
        searchWrap.addSubview(searchText)
        searchText.textColor = .systemGray3
        searchText.font = UIFont.boldSystemFont(ofSize: 18)
        searchText.text = "Поиск продуктов"
        searchText.backgroundColor = .clear
        searchText.textAlignment = .natural
        searchText.pinLeft(to: searchIcon.trailingAnchor, 15)
        searchText.pinVertical(to: searchWrap, 4)
        searchText.pinCenterY(to: searchWrap)
        searchText.pinRight(to: searchWrap.trailingAnchor, 5)
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
    
    private func configureGoods() {
        addSubview(goods)
        goods.pinTop(to: searchWrap.bottomAnchor, 10)
        goods.pinHorizontal(to: self, 15)
        goods.pinBottom(to: self.bottomAnchor)
        goods.backgroundColor = .clear
        goods.separatorStyle = .none
        goods.showsVerticalScrollIndicator = false
    }
}
