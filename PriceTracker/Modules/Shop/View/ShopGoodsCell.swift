//
//  ShopGoodsCell.swift
//  PriceTracker
//
//  Created by dread on 16.01.2025.
//

import UIKit

final class ShopGoodsCell: UITableViewCell {
    static let reuseId = "ShopGoodsCell"
    
    var delegate: ShopGoodsCellDelegate?
    
    private let wrap = UIView()
    let image = UIImageView()
    let priceLabel = UILabel()
    let oldPriceLabel = UILabel()
    let descriptionLabel = UITextView()
    let saleWrap = UIView()
    let saleLabel = UILabel()
    let plusButton = UIButton()
    
    var discount: Int = 0
    private var currentURL: URL?
    var product: ProductModel?

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
        image.image = nil
        currentURL = nil
        priceLabel.text = nil
        descriptionLabel.text = nil
        oldPriceLabel.attributedText = nil
        oldPriceLabel.removeFromSuperview()
        saleWrap.removeFromSuperview()
        saleLabel.text = nil
    }
    
    func configureMagnit(_ product: MagnitProductViewModel) {
        self.product = ProductModel(image: product.image, name: product.name, price: product.price, oldPrice: product.oldPrice, shop: .magnit, category: product.category, id: product.id)
        priceLabel.text = product.price

        if let oldPrice = product.oldPrice {
            oldPriceLabel.attributedText = NSAttributedString(
                string: oldPrice,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else {
            oldPriceLabel.attributedText = nil
        }

        descriptionLabel.text = product.name

        currentURL = product.image
        image.image = nil
        ImageLoader.shared.loadImage(product.image) { [weak self] loadedImage in
            guard self?.currentURL == product.image else { return }
            self?.image.image = loadedImage
        }
    }
    
    func configurePaterochka(_ product: PaterochkaProductViewModel) {
        self.product = ProductModel(image: product.image, name: product.name, price: product.price, oldPrice: product.oldPrice, shop: .paterochka, category: product.category, id: product.id)
        priceLabel.text = product.price

        if let oldPrice = product.oldPrice {
            oldPriceLabel.attributedText = NSAttributedString(
                string: oldPrice,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else {
            oldPriceLabel.attributedText = nil
        }

        descriptionLabel.text = product.name

        currentURL = product.image
        image.image = nil
        ImageLoader.shared.loadImage(product.image) { [weak self] loadedImage in
            guard self?.currentURL == product.image else { return }
            self?.image.image = loadedImage
        }
    }
    
    func configureOkey(_ product: OkeyProductViewModel) {
        self.product = ProductModel(image: product.image, name: product.name, price: product.price, oldPrice: product.oldPrice, shop: .magnit, category: product.category, id: product.id)
        priceLabel.text = product.price

        if let oldPrice = product.oldPrice {
            oldPriceLabel.attributedText = NSAttributedString(
                string: oldPrice,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else {
            oldPriceLabel.attributedText = nil
        }

        descriptionLabel.text = product.name

        currentURL = product.image
        image.image = nil
        ImageLoader.shared.loadImage(product.image) { [weak self] loadedImage in
            guard self?.currentURL == product.image else { return }
            self?.image.image = loadedImage
        }
    }
    
    func configurePerekrestok(_ product: PerekrestokProductViewModel) {
        self.product = ProductModel(image: product.image, name: product.name, price: product.price, oldPrice: product.oldPrice, shop: .paterochka, category: product.category, id: product.id)
        priceLabel.text = product.price

        if let oldPrice = product.oldPrice {
            oldPriceLabel.attributedText = NSAttributedString(
                string: oldPrice,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else {
            oldPriceLabel.attributedText = nil
        }

        descriptionLabel.text = product.name

        currentURL = product.image
        image.image = nil
        ImageLoader.shared.loadImage(product.image) { [weak self] loadedImage in
            guard self?.currentURL == product.image else { return }
            self?.image.image = loadedImage
        }
    }

    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none

        configureWrap()
        configureImage()
        configureDescriptionLabel()
        configurePriceLabel()
        configureButton()

        if let oldPriceText = oldPriceLabel.attributedText?.string, !oldPriceText.isEmpty {
            configureOldPriceLabel()
            configureSaleWrap()
            configureSaleLabel()
        } else {
            oldPriceLabel.removeFromSuperview()
            saleWrap.removeFromSuperview()
        }
    }
    
    private func configureWrap() {
        addSubview(wrap)
        wrap.pinHorizontal(to: self)
        wrap.pinVertical(to: self, 5)
        wrap.backgroundColor = UIColor(named: "wrap_color")
        wrap.layer.cornerRadius = 15
    }
    
    private func configureImage() {
        wrap.addSubview(image)
        image.pinVertical(to: wrap, 10)
        image.pinLeft(to: wrap.leadingAnchor, 10)
        image.pinWidth(to: image.heightAnchor)
        image.layer.cornerRadius = 15
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
    }
    
    private func configureDescriptionLabel() {
        wrap.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: wrap.topAnchor, 15)
        descriptionLabel.pinLeft(to: image.trailingAnchor, 10)
        descriptionLabel.pinRight(to: wrap.trailingAnchor, 10)
        descriptionLabel.setHeight(40)
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        descriptionLabel.isEditable = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.isScrollEnabled = false
    }
    
    private func configurePriceLabel() {
        wrap.addSubview(priceLabel)
        priceLabel.pinTop(to: descriptionLabel.bottomAnchor)
        priceLabel.pinLeft(to: image.trailingAnchor, 15)
        priceLabel.setHeight(20)
        priceLabel.setWidth(80)
        priceLabel.font = .boldSystemFont(ofSize: 16)
    }
    
    private func configureOldPriceLabel() {
        wrap.addSubview(oldPriceLabel)
        oldPriceLabel.pinLeft(to: priceLabel.trailingAnchor)
        oldPriceLabel.pinTop(to: descriptionLabel.bottomAnchor)
        oldPriceLabel.setHeight(20)
        oldPriceLabel.setWidth(70)
        oldPriceLabel.font = .systemFont(ofSize: 14)
        oldPriceLabel.textColor = .gray
    }
    
    private func configureSaleWrap() {
        wrap.addSubview(saleWrap)
        saleWrap.pinCenterY(to: priceLabel)
        saleWrap.pinLeft(to: oldPriceLabel.trailingAnchor, 5)
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
    
    private func configureButton() {
        addSubview(plusButton)
        plusButton.pinRight(to: wrap.trailingAnchor, 5)
        plusButton.pinBottom(to: wrap.bottomAnchor, 5)
        plusButton.setWidth(45)
        plusButton.setHeight(45)
        plusButton.backgroundColor = .clear
        plusButton.layer.cornerRadius = 10
        plusButton.layer.masksToBounds = true
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.didTapAddButton(for: self.product)
    }
}
