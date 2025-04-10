//
//  MainGoodsCell.swift
//  PriceTracker
//
//  Created by dread on 24.12.2024.
//

import UIKit

final class MainGoodsCell: UICollectionViewCell {
    static let reuseId: String = "MainGoodsCell"
    
    var delegate: MainGoodsCellDelegate?
    
    let priceLabel = UILabel()
    let oldPriceLabel = UILabel()
    let descriptionLabel = UITextView()
    let saleWrap = UIView()
    let saleLabel = UILabel()
    let plusButton = UIButton()
    
    var imageView = UIImageView()
    var shopView = UIImageView()
    var discount: Int = 0
    var currentURL: URL?
    var shopType: ShopType = .magnit
    var product: ProductModel?
    
    var topConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        currentURL = nil
        priceLabel.text = nil
        descriptionLabel.text = nil
        oldPriceLabel.attributedText = nil
        oldPriceLabel.removeFromSuperview()
        saleWrap.removeFromSuperview()
        saleLabel.text = nil
        
        if let heightConstraint = plusButton.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.isActive = false
        }
        
        if let topConstraint = descriptionLabel.constraints.first(where: { $0.firstAttribute == .top }) {
            topConstraint.isActive = false
        }
    }
    
    func configure(_ product: ProductModel) {
        self.product = product
        priceLabel.text = product.price
        
        if let oldPrice = product.oldPrice, !oldPrice.isEmpty {
            oldPriceLabel.attributedText = NSAttributedString(
                string: oldPrice,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            
            if let constraint = plusButton.constraints.first(where: { $0.firstAttribute == .height }) {
                constraint.isActive = false
            }
            plusButton.setHeight(40)
            
            configureOldPriceLabel()
            configureSaleWrap()
            configureSaleLabel()
            
            for constraint in topConstraints {
                constraint.constant = 22
            }
//            if let oldConstraint = descriptionLabel.constraints.first(where: { $0.firstAttribute == .top }) {
//                oldConstraint.isActive = false
//                descriptionLabel.pinTop(to: priceLabel.bottomAnchor, 30)
//            }
//            descriptionLabel.pinTop(to: plusButton.bottomAnchor, 5)
//            descriptionLabel.pinBottom(to: self.bottomAnchor)
            
        } else {
            oldPriceLabel.removeFromSuperview()
            saleWrap.removeFromSuperview()
        }
        
        descriptionLabel.text = product.name
        
        currentURL = product.image
        imageView.image = nil
        ImageLoader.shared.loadImage(product.image) { [weak self] loadedImage in
            guard self?.currentURL == product.image else { return }
            self?.imageView.image = loadedImage
        }
        
        shopType = product.shop
        switch product.shop {
        case .okey:
            shopView.image = UIImage(named: "okey")
        case .perekrestok:
            shopView.image = UIImage(named: "perekrestok")
        case .paterochka:
            shopView.image = UIImage(named: "5ka")
        case .magnit:
            shopView.image = UIImage(named: "magnit")
        }
    }
    
    private func configureUI() {
        configureImageView()
        configureShopView()
        configurePriceLabel()
        configureButton()
        configureDescriptionLabel()
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.pinTop(to: self)
        imageView.pinHorizontal(to: self)
        imageView.pinHeight(to: self.widthAnchor)
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
    }
    
    private func configureShopView() {
        imageView.addSubview(shopView)
        shopView.pinTop(to: imageView.topAnchor, 9)
        shopView.pinLeft(to: imageView.leadingAnchor, 9)
        shopView.setHeight(30)
        shopView.setWidth(30)
        shopView.layer.cornerRadius = 15
        shopView.clipsToBounds = true
        shopView.backgroundColor = .systemGray4
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        priceLabel.pinTop(to: imageView.bottomAnchor, 5)
        priceLabel.pinLeft(to: self.leadingAnchor, 10)
        priceLabel.setHeight(20)
        priceLabel.setWidth(90)
        priceLabel.font = .boldSystemFont(ofSize: 18)
    }
    
    private func configureOldPriceLabel() {
        addSubview(oldPriceLabel)
        oldPriceLabel.pinTop(to: priceLabel.bottomAnchor)
        oldPriceLabel.pinLeft(to: priceLabel.leadingAnchor)
        oldPriceLabel.setHeight(15)
        oldPriceLabel.setWidth(90)
        oldPriceLabel.font = .systemFont(ofSize: 14)
        oldPriceLabel.textColor = .gray
    }
    
    private func configureSaleWrap() {
        addSubview(saleWrap)
        saleWrap.pinTop(to: topAnchor, 10)
        saleWrap.pinRight(to: trailingAnchor, 10)
        saleWrap.setHeight(22)
        saleWrap.setWidth(45)
        saleWrap.backgroundColor = UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1)
        saleWrap.layer.cornerRadius = 11
    }
    
    private func configureSaleLabel() {
        saleWrap.addSubview(saleLabel)
        saleLabel.pinCenter(to: saleWrap)
        saleLabel.font = .boldSystemFont(ofSize: 11)
        if let priceText = priceLabel.text?.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "₽", with: "").trimmingCharacters(in: .whitespaces),
           let oldPriceText = oldPriceLabel.text?.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "₽", with: "").trimmingCharacters(in: .whitespaces),
           let priceValue = Double(priceText),
           let oldPriceValue = Double(oldPriceText) {
            
            discount = Int(100 - (100 * priceValue / oldPriceValue))
            saleLabel.text = "-\(discount)%"
        } else {
            print("Ошибка: Неверный формат текста или значение равно nil")
            saleLabel.text = "N/A"
        }
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        let topConstraint = descriptionLabel.pinTop(to: priceLabel.bottomAnchor, 7)
        topConstraints.append(topConstraint)
//        descriptionLabel.pinTop(to: priceLabel.bottomAnchor, 7)
        descriptionLabel.pinBottom(to: self.bottomAnchor)
        descriptionLabel.pinLeft(to: self.leadingAnchor, 10)
        descriptionLabel.pinRight(to: self.trailingAnchor, 10)
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        descriptionLabel.isEditable = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.isScrollEnabled = false
    }
    
    private func configureButton() {
        addSubview(plusButton)
        plusButton.pinLeft(to: priceLabel.trailingAnchor)
        plusButton.pinTop(to: imageView.bottomAnchor, 3)
        plusButton.setWidth(50)
        plusButton.setHeight(25)
        plusButton.backgroundColor = UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1)
        plusButton.layer.cornerRadius = 10
        plusButton.layer.masksToBounds = true
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.tintColor = UIColor(named: "icon_color")
        plusButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.didTapAddButton(for: self.product)
    }
}
