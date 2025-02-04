//
//  BasketView.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import UIKit

final class BasketView: UIView {
    let scrollView = UIScrollView()
    let screenTitle = UILabel()
    let clearButton = UIButton()
    
    let table1 = UITableView(frame: .zero)
    let table2 = UITableView(frame: .zero)
    let table3 = UITableView(frame: .zero)
    let table4 = UITableView(frame: .zero)
    
    let price1 = UILabel()
    let price2 = UILabel()
    let price3 = UILabel()
    let price4 = UILabel()
    
    lazy var button1 = createButton()
    lazy var button2 = createButton()
    lazy var button3 = createButton()
    lazy var button4 = createButton()
    
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
        configureClearButton()
        configureScrollView()
        configureShops()
    }
    
    private func configureScreenName() {
        addSubview(screenTitle)
        screenTitle.font = UIFont.boldSystemFont(ofSize: 22)
        screenTitle.text = "Корзина"
        screenTitle.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        screenTitle.pinLeft(to: self.safeAreaLayoutGuide.leadingAnchor, 30)
        screenTitle.setHeight(25)
        screenTitle.setWidth(100)
    }
    
    private func configureClearButton() {
        addSubview(clearButton)
        clearButton.setImage(UIImage(named: "trash"), for: .normal)
        clearButton.backgroundColor = .clear
        clearButton.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        clearButton.pinRight(to: self.safeAreaLayoutGuide.trailingAnchor, 30)
        clearButton.setHeight(30)
        clearButton.setWidth(30)
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
    
    private func configureShops() {
        let okey = createSection("О'КЕЙ", "okey", table1, button1, price1)
        okey.pinTop(to: scrollView.topAnchor)
        okey.pinLeft(to: scrollView.safeAreaLayoutGuide.leadingAnchor, 15)
        okey.pinRight(to: scrollView.safeAreaLayoutGuide.trailingAnchor, 15)
        
        let perekrestok = createSection("Перекресток", "perekrestok", table2, button2, price2)
        perekrestok.pinTop(to: okey.bottomAnchor, 15)
        perekrestok.pinLeft(to: scrollView.safeAreaLayoutGuide.leadingAnchor, 15)
        perekrestok.pinRight(to: scrollView.safeAreaLayoutGuide.trailingAnchor, 15)
        
        let paterochka = createSection("Пятерочка", "5ka", table3, button3, price3)
        paterochka.pinTop(to: perekrestok.bottomAnchor, 15)
        paterochka.pinLeft(to: scrollView.safeAreaLayoutGuide.leadingAnchor, 15)
        paterochka.pinRight(to: scrollView.safeAreaLayoutGuide.trailingAnchor, 15)
        
        let magnit = createSection("Магнит", "magnit", table4, button4, price4)
        magnit.pinTop(to: paterochka.bottomAnchor, 15)
        magnit.pinLeft(to: scrollView.safeAreaLayoutGuide.leadingAnchor, 15)
        magnit.pinRight(to: scrollView.safeAreaLayoutGuide.trailingAnchor, 15)
        magnit.pinBottom(to: scrollView.contentLayoutGuide.bottomAnchor, 60)
    }
    
    private func createSection(_ title: String, _ image: String, _ table: UITableView, _ button: UIButton, _ price: UILabel) -> UIView {
        let wrap = UIView()
        scrollView.addSubview(wrap)
        wrap.layer.cornerRadius = 30
        wrap.backgroundColor = UIColor(named: "wrap_color")
        
        let imageView = UIImageView(image: UIImage(named: image))
        wrap.addSubview(imageView)
        imageView.pinTop(to: wrap.topAnchor, 7)
        imageView.pinLeft(to: wrap.leadingAnchor, 18)
        imageView.setHeight(28)
        imageView.setWidth(28)
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        
        let label = UILabel()
        wrap.addSubview(label)
        label.pinTop(to: imageView.topAnchor, 5)
        label.pinLeft(to: imageView.trailingAnchor, 10)
        label.setHeight(20)
        label.setWidth(150)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = title
        
        let line = UIView()
        wrap.addSubview(line)
        line.pinHorizontal(to: wrap, 10)
        line.pinTop(to: label.bottomAnchor, 10)
        line.setHeight(1)
        line.backgroundColor = .systemGray4
        
        let result = UILabel()
        wrap.addSubview(result)
        result.pinBottom(to: wrap.bottomAnchor, 12)
        result.pinLeft(to: wrap.leadingAnchor, 20)
        result.setHeight(20)
        result.setWidth(100)
        result.font = UIFont.boldSystemFont(ofSize: 15)
        result.text = "Итого"
        
        wrap.addSubview(button)
        button.pinBottom(to: wrap.bottomAnchor, 10)
        button.pinRight(to: wrap.trailingAnchor, 15)
        button.setHeight(32)
        button.setWidth(60)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        
        wrap.addSubview(price)
        price.pinCenterY(to: button)
        price.pinRight(to: button.leadingAnchor, 15)
        price.setHeight(20)
        price.setWidth(80)
        price.textAlignment = .right
        price.font = UIFont.boldSystemFont(ofSize: 14)
        price.text = "549,99 ₽"
        
        wrap.addSubview(table)
        table.pinHorizontal(to: wrap, 15)
        table.pinTop(to: line, 15)
        table.pinBottom(to: result.topAnchor, 10)
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.setHeight(calculateTableHeight())
        
        return wrap
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1)
        button.setImage(UIImage(named: "mdi_cart_empty"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    private func calculateTableHeight() -> CGFloat {
        return 96 * 6 + 10
    }
}
