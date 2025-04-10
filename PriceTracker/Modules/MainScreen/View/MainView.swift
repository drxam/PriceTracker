//
//  MainView.swift
//  PriceTracker
//
//  Created by dread on 24.12.2024.
//

import UIKit

final class MainView: UIView {
    let scrollView = UIScrollView()
    
    let screenTitle = UILabel()
    
    let searchText = UITextView()
    let searchWrap = UIView()
    let searchIcon = UIImageView()
    
    let shopsTitle = UILabel()
    let shopsWrap = UIView()
    var shops: [UIButton] = []
    
    let goodsTitle = UILabel()
    let goodsWrap = UIView()
    var goodsTable = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        configureScrollView()
        configureShops()
        configureTable()
    }
    
    private func configureScrollView() {
        addSubview(scrollView)
        scrollView.pinHorizontal(to: self)
        scrollView.pinTop(to: searchWrap.bottomAnchor, 15)
        scrollView.pinBottom(to: self.bottomAnchor)
        scrollView.frame = self.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
    }
    
    private func configureScreenName() {
        addSubview(screenTitle)
        screenTitle.font = UIFont.boldSystemFont(ofSize: 22)
        screenTitle.text = "Главная"
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
    
    private func configureShops() {
        scrollView.addSubview(shopsWrap)
        shopsWrap.backgroundColor = UIColor(named: "wrap_color")
        shopsWrap.layer.cornerRadius = 30
        shopsWrap.pinTop(to: scrollView.topAnchor)
        shopsWrap.pinLeft(to: scrollView.safeAreaLayoutGuide.leadingAnchor, 15)
        shopsWrap.pinRight(to: scrollView.safeAreaLayoutGuide.trailingAnchor, 15)
        shopsWrap.setHeight(400)
        
        shopsWrap.addSubview(shopsTitle)
        shopsTitle.text = "Магазины"
        shopsTitle.textColor = UIColor.label
        shopsTitle.font = .systemFont(ofSize: 18, weight: .bold)
        shopsTitle.pinTop(to: shopsWrap.topAnchor, 15)
        shopsTitle.pinLeft(to: shopsWrap.leadingAnchor, 20)
        shopsTitle.setWidth(140)
        shopsTitle.setHeight(20)
        
        shops = [createShop("5ka"), createShop("okey"), createShop("perekrestok"), createShop("magnit")]
        shops.forEach { shopsWrap.addSubview($0) }
        
        shops[0].pinLeft(to: shopsWrap.leadingAnchor, 15)
        shops[0].pinTop(to: shopsTitle.bottomAnchor, 15)
        
        shops[1].pinRight(to: shopsWrap.trailingAnchor, 15)
        shops[1].pinTop(to: shopsTitle.bottomAnchor, 15)
        
        shops[2].pinLeft(to: shopsWrap.leadingAnchor, 15)
        shops[2].pinBottom(to: shopsWrap.bottomAnchor, 15)
        
        shops[3].pinRight(to: shopsWrap.trailingAnchor, 15)
        shops[3].pinBottom(to: shopsWrap.bottomAnchor, 15)
        
        shops.forEach {
            $0.setHeight(160)
            $0.setWidth(160)
        }
    }
    
    private func configureTable() {
        scrollView.addSubview(goodsWrap)
        
        goodsWrap.pinTop(to: shopsWrap.bottomAnchor, 15)
        goodsWrap.pinLeft(to: scrollView.safeAreaLayoutGuide.leadingAnchor, 15)
        goodsWrap.pinRight(to: scrollView.safeAreaLayoutGuide.trailingAnchor, 15)
        goodsWrap.pinBottom(to: scrollView.contentLayoutGuide.bottomAnchor, 60)
        
        goodsWrap.backgroundColor = UIColor(named: "wrap_color")
        goodsWrap.layer.cornerRadius = 30
        
        let goodsTitle = UILabel()
        goodsWrap.addSubview(goodsTitle)
        goodsTitle.text = "Продукты"
        goodsTitle.font = .systemFont(ofSize: 18, weight: .bold)
        goodsTitle.pinTop(to: goodsWrap.topAnchor, 15)
        goodsTitle.pinLeft(to: goodsWrap.leadingAnchor, 20)
        goodsTitle.setWidth(140)
        goodsTitle.setHeight(20)
        
        goodsWrap.addSubview(goodsTable)
        goodsTable.pinTop(to: goodsTitle.bottomAnchor, 15)
        goodsTable.pinBottom(to: goodsWrap.bottomAnchor, 25)
        goodsTable.pinHorizontal(to: goodsWrap, 15)
        
        guard let layout = goodsTable.collectionViewLayout as? UICollectionViewFlowLayout else {
            print("Ошибка: layout не является UICollectionViewFlowLayout")
            return
        }

        layout.itemSize = CGSize(width: 162, height: 260)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        
        let collectionViewHeight = calculateCollectionViewHeight()
//        goodsTable.setHeight(collectionViewHeight)
        goodsWrap.setHeight(collectionViewHeight + 40 + 15)
        goodsTable.isScrollEnabled = false
    }
    
    private func createShop(_ image: String) -> UIButton {
        let shop = UIButton()
        shop.backgroundColor = .clear
        shop.layer.contents = UIImage(named: image)?.cgImage
        shop.layer.masksToBounds = true
        shop.layer.cornerRadius = 30
        
        return shop
    }
    
    private func calculateCollectionViewHeight() -> CGFloat {
        guard let layout = goodsTable.collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        let itemHeight = layout.itemSize.height
        let itemSpacing = layout.minimumLineSpacing
        let numberOfItems = 20
        let itemsPerRow = floor((UIScreen.main.bounds.width - 30) / layout.itemSize.width)
        let numberOfRows = ceil(CGFloat(numberOfItems) / itemsPerRow)
        
        return numberOfRows * itemHeight + (numberOfRows - 1) * itemSpacing
    }
}
