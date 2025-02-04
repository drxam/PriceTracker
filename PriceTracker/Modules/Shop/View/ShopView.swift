//
//  ShopView.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import UIKit

final class ShopView: UIView {
    let screenTitle = UILabel()
    let backButton = UIButton(type: .system)
    let searchButton = UIButton(type: .system)
    let categories = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let goods = UITableView(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureShopType(_ shopType: ShopType) {
        switch shopType {
        case ShopType.paterochka:
            screenTitle.text = "Пятерочка"
        case .okey:
            screenTitle.text = "О'КЕЙ"
        case .perekrestok:
            screenTitle.text = "Перекресток"
        case .magnit:
            screenTitle.text = "Магнит"
        }
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
        configureScreenName()
        configureBackButton()
        configureSearchButton()
        configureCategories()
        configureGoods()
    }
    
    private func configureScreenName() {
        addSubview(screenTitle)
        screenTitle.font = UIFont.boldSystemFont(ofSize: 22)
        screenTitle.text = "Перекресток"
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
    
    private func configureSearchButton() {
        addSubview(searchButton)
        searchButton.pinCenterY(to: screenTitle)
        searchButton.pinRight(to: self.trailingAnchor, 15)
        searchButton.setHeight(40)
        searchButton.setWidth(40)
        searchButton.backgroundColor = UIColor(named: "wrap_color")
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        searchButton.tintColor = UIColor(named: "icon_color")
        searchButton.layer.cornerRadius = 20
        searchButton.layer.masksToBounds = true
    }
    
    private func configureCategories() {
        addSubview(categories)
        categories.pinTop(to: searchButton.bottomAnchor, 5)
        categories.pinLeft(to: self.leadingAnchor, 10)
        categories.pinRight(to: self.trailingAnchor, 10)
        categories.setHeight(35)
        categories.backgroundColor = .clear
        categories.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        categories.collectionViewLayout = layout
    }
    
    private func configureGoods() {
        addSubview(goods)
        goods.pinTop(to: categories.bottomAnchor, 10)
        goods.pinHorizontal(to: self, 15)
        goods.pinBottom(to: self.bottomAnchor)
        goods.backgroundColor = .clear
        goods.separatorStyle = .none
        goods.showsVerticalScrollIndicator = false
    }
}
