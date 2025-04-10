//
//  ProductView.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import UIKit

final class ProductView: UIView {
    private let screenTitle = UILabel()
    let backButton = UIButton(type: .system)
    let wrap = UIView()
    let priceLabel = UILabel()
    let oldPriceLabel = UILabel()
    let descriptionLabel = UITextView()
    let plusButton = UIButton()
    
    let categoryLabel = UILabel()
    let ratingLabel = UILabel()
    let rating = UILabel()
    let countLabel = UILabel()
    let count = UILabel()
    
    var imageView = UIImageView()
    var shopView = UIImageView()
    var currentURL: URL?
    
    let category = UILabel()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: PaterochkaProduct) {
        shopView.image = UIImage(named: "5ka")
        print("PaterochkaProduct")
        descriptionLabel.text = product.name
        
        let price = product.price ?? product.oldPrice
        let oldPrice = product.price == nil ? nil : product.oldPrice
        
        print("price = \(price ?? "nil") oldPrice = \(oldPrice ?? "nil")")
        
//        if let oldPrice = product.oldPrice {
            priceLabel.text = formatPrice(price)
            oldPriceLabel.attributedText = NSAttributedString(string: formatPrice(oldPrice), attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
//        } else {
//            priceLabel.text = formatPrice(product.price)
//        }
        
        currentURL = URL(string: product.images?.first ?? "")
        imageView.image = nil
        ImageLoader.shared.loadImage(URL(string: product.images?.first ?? "")) { [weak self] loadedImage in
            guard self?.currentURL == URL(string: product.images?.first ?? "") else { return }
            self?.imageView.image = loadedImage
        }
        
        category.text = product.category
        rating.text = String(product.rating ?? 4.2)
        count.text = String(product.scoresCount ?? 545)
    }
    
    func configure(with product: MagnitProduct) {
        shopView.image = UIImage(named: "magnit")
        print("MagnitProduct")
        descriptionLabel.text = product.name
        
        if let oldPrice = product.oldPrice {
            priceLabel.text = formatPrice(product.price)
            oldPriceLabel.attributedText = NSAttributedString(string: formatPrice(oldPrice), attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            print("price = \(formatPrice(product.price)) oldPrice = \(formatPrice(oldPrice))")
        } else {
            priceLabel.text = formatPrice(product.price)
            print("price = \(formatPrice(product.price)) oldPrice = nil")
        }
        
        currentURL = URL(string: product.images?.first ?? "")
        imageView.image = nil
        ImageLoader.shared.loadImage(URL(string: product.images?.first ?? "")) { [weak self] loadedImage in
            guard self?.currentURL == URL(string: product.images?.first ?? "") else { return }
            self?.imageView.image = loadedImage
        }
        
        rating.text = String(product.rating ?? 4.2)
        count.text = String(product.scoresCount ?? 545)
        category.text = product.category
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
        configureBackButton()
        configureWrap()
        configureImageView()
        configureShopView()
        configureDescriptionLabel()
        configurePriceLabel()
        configureButton()
        configureAdditionallyInfo()
        configureOldPriceLabel()
        configureRatingLabel()
        configureCountLabel()
    }
    
    private func configureBackButton() {
        addSubview(backButton)
        backButton.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        backButton.pinLeft(to: self.leadingAnchor, 8)
        backButton.setHeight(32)
        backButton.setWidth(20)
        backButton.backgroundColor = .clear
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.tintColor = UIColor(named: "icon_color")
    }
    
    private func configureWrap() {
        addSubview(wrap)
        wrap.pinTop(to: backButton.bottomAnchor, 10)
        wrap.pinHorizontal(to: self, 15)
        wrap.pinBottom(to: self.safeAreaLayoutGuide.bottomAnchor, 5)
        wrap.layer.cornerRadius = 30
        wrap.backgroundColor = UIColor(named: "wrap_color")
    }
    
    private func configureImageView() {
        wrap.addSubview(imageView)
        imageView.pinTop(to: wrap.topAnchor, 15)
        imageView.pinHorizontal(to: wrap, 15)
        imageView.setHeight(290)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
    }
    
    private func configureShopView() {
        imageView.addSubview(shopView)
        shopView.pinTop(to: imageView.topAnchor, 5)
        shopView.pinLeft(to: imageView.leadingAnchor, 5)
        shopView.setHeight(54)
        shopView.setWidth(54)
        shopView.layer.cornerRadius = 27
        shopView.clipsToBounds = true
        shopView.backgroundColor = .systemGray4
    }
    
    private func configureDescriptionLabel() {
        wrap.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: imageView.bottomAnchor, 15)
        descriptionLabel.pinHorizontal(to: wrap, 15)
        descriptionLabel.setHeight(50)
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        descriptionLabel.isEditable = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.isScrollEnabled = false
        descriptionLabel.backgroundColor = .clear
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        priceLabel.pinTop(to: descriptionLabel.bottomAnchor)
        priceLabel.pinLeft(to: wrap, 20)
        priceLabel.setHeight(40)
        priceLabel.setWidth(125)
        priceLabel.font = .boldSystemFont(ofSize: 26)
        priceLabel.backgroundColor = .clear
    }
    
    private func configureOldPriceLabel() {
        addSubview(oldPriceLabel)
        oldPriceLabel.pinBottom(to: priceLabel.bottomAnchor, 12)
        oldPriceLabel.pinLeft(to: priceLabel.trailingAnchor, 5)
        oldPriceLabel.setHeight(15)
        oldPriceLabel.setWidth(100)
        oldPriceLabel.font = .systemFont(ofSize: 20)
        oldPriceLabel.textColor = .gray
    }
    
    private func configureButton() {
        addSubview(plusButton)
        plusButton.pinTop(to: priceLabel.bottomAnchor, 10)
        plusButton.pinHorizontal(to: wrap, 15)
        plusButton.setHeight(45)
        plusButton.backgroundColor = UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1)
        plusButton.layer.cornerRadius = 15
        plusButton.layer.masksToBounds = true
        plusButton.setTitle("В корзину", for: .normal)
        plusButton.setTitleColor(.white, for: .normal)
    }
    
    private func configureAdditionallyInfo() {
        let label = UILabel()
        wrap.addSubview(label)
        label.pinTop(to: plusButton.bottomAnchor, 15)
        label.pinHorizontal(to: wrap, 20)
        label.setHeight(20)
        label.text = "Дополнительная информация"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        
        let line = UIView()
        wrap.addSubview(line)
        line.setHeight(1)
        line.pinTop(to: label.bottomAnchor, 8)
        line.pinHorizontal(to: wrap, 10)
        line.backgroundColor = .systemGray4
        
        wrap.addSubview(categoryLabel)
        categoryLabel.pinTop(to: line, 15)
        categoryLabel.pinLeft(to: wrap.leadingAnchor, 20)
        categoryLabel.setWidth(80)
        categoryLabel.setHeight(20)
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        categoryLabel.text = "Категория"
        
        wrap.addSubview(category)
        category.pinTop(to: line, 15)
        category.pinRight(to: wrap.trailingAnchor, 20)
        category.setWidth(200)
        category.setHeight(20)
        category.backgroundColor = .clear
        category.font = UIFont.systemFont(ofSize: 14)
        category.textAlignment = .right
    }
    
    private func configureRatingLabel() {
        wrap.addSubview(ratingLabel)
        ratingLabel.pinTop(to: categoryLabel.bottomAnchor, 15)
        ratingLabel.pinLeft(to: wrap.leadingAnchor, 20)
        ratingLabel.setWidth(80)
        ratingLabel.setHeight(20)
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        ratingLabel.text = "Рейтинг"
        
        wrap.addSubview(rating)
        rating.pinTop(to: category.bottomAnchor, 15)
        rating.pinRight(to: wrap.trailingAnchor, 20)
        rating.setWidth(200)
        rating.setHeight(20)
        rating.backgroundColor = .clear
        rating.font = UIFont.systemFont(ofSize: 14)
        rating.textAlignment = .right
    }
    
    private func configureCountLabel() {
        wrap.addSubview(countLabel)
        countLabel.pinTop(to: ratingLabel.bottomAnchor, 15)
        countLabel.pinLeft(to: wrap.leadingAnchor, 20)
        countLabel.setWidth(150)
        countLabel.setHeight(20)
        countLabel.font = UIFont.systemFont(ofSize: 14)
        countLabel.text = "Количество отзывов"
        
        wrap.addSubview(count)
        count.pinTop(to: rating.bottomAnchor, 15)
        count.pinRight(to: wrap.trailingAnchor, 20)
        count.setWidth(200)
        count.setHeight(20)
        count.backgroundColor = .clear
        count.font = UIFont.systemFont(ofSize: 14)
        count.textAlignment = .right
    }
    
    private func formatPrice(_ price: Int?) -> String {
        if let priceUnwrap = price {
            let priceInRubles = Double(priceUnwrap) / 100.0
            return String(format: "%.2f ₽", priceInRubles).replacingOccurrences(of: ".", with: ",")
        } else {
            return ""
        }
    }
    
    func formatPrice(_ price: String?) -> String {
        guard let price = price else { return "" }
        if let doubleValue = Double(price) {
            let formattedPrice = String(format: "%.2f", doubleValue).replacingOccurrences(of: ".", with: ",")
            return "\(formattedPrice) ₽"
        }
        return price
    }
}
