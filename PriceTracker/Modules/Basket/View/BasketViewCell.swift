//
//  BasketViewCell.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import UIKit

final class BasketViewCell: UITableViewCell {
    static let reuseId = "BasketViewCell"
    
    private let image = UIImageView()
    private let descriptionLabel = UITextView()
    private let priceLabel = UILabel()
    private let oldPriceLabel = UILabel()
    private let saleWrap = UIView()
    private let saleLabel = UILabel()
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    let countLabel = UILabel()
    
    weak var delegate: BasketViewCellDelegate?
    
    var discount: Int = 0
    var currentURL: URL?

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
    
    func configure(_ product: ProductModel, _ count: Int, _ newPrice: String, _ newOldPrice: String?) {
        priceLabel.text = newPrice

        if let oldPrice = newOldPrice {
            oldPriceLabel.attributedText = NSAttributedString(
                string: oldPrice,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else {
            oldPriceLabel.attributedText = nil
        }

        descriptionLabel.text = product.name
        countLabel.text = String(count)

        currentURL = product.image
        image.image = nil
        ImageLoader.shared.loadImage(product.image) { [weak self] loadedImage in
            guard self?.currentURL == product.image else { return }
            self?.image.image = loadedImage
        }
    }

    private func configureUI() {
        self.selectionStyle = .none
        configureImage()
        configureDescriptionLabel()
        configurePriceLabel()
        configureCountWrap()
        
        if let oldPriceText = oldPriceLabel.attributedText?.string, !oldPriceText.isEmpty {
            configureOldPriceLabel()
            configureSaleWrap()
            configureSaleLabel()
        } else {
            oldPriceLabel.removeFromSuperview()
            saleWrap.removeFromSuperview()
        }
    }
    
    private func configureImage() {
        addSubview(image)
        image.backgroundColor = .systemGray5
        image.pinTop(to: self.topAnchor, 8)
        image.pinLeft(to: self.leadingAnchor)
        image.pinBottom(to: self.bottomAnchor, 8)
        image.pinWidth(to: image.heightAnchor)
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: image.topAnchor)
        descriptionLabel.pinLeft(to: image.trailingAnchor, 5)
        descriptionLabel.pinRight(to: self.trailingAnchor, 5)
        descriptionLabel.setHeight(35)
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.backgroundColor = .clear
        
        descriptionLabel.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        descriptionLabel.isEditable = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.isScrollEnabled = false
        descriptionLabel.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        priceLabel.pinBottom(to: self.bottomAnchor, 8)
        priceLabel.pinRight(to: self.trailingAnchor, 5)
        priceLabel.setHeight(20)
        priceLabel.setWidth(75)
        priceLabel.font = .boldSystemFont(ofSize: 14)
        priceLabel.backgroundColor = .clear
        priceLabel.textAlignment = .right
    }
    
    private func configureOldPriceLabel() {
        addSubview(oldPriceLabel)
        oldPriceLabel.pinBottom(to: priceLabel.topAnchor)
        oldPriceLabel.pinRight(to: self.trailingAnchor, 5)
        oldPriceLabel.setHeight(15)
        oldPriceLabel.setWidth(60)
        oldPriceLabel.font = .systemFont(ofSize: 12)
        oldPriceLabel.textColor = .gray
        oldPriceLabel.textAlignment = .right
    }
    
    private func configureSaleWrap() {
        addSubview(saleWrap)
        saleWrap.pinBottom(to: priceLabel.bottomAnchor, 4)
        saleWrap.pinRight(to: priceLabel.leadingAnchor, 5)
        saleWrap.setHeight(20)
        saleWrap.setWidth(40)
        saleWrap.backgroundColor = UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1)
        saleWrap.layer.cornerRadius = 11
    }
    
    private func configureSaleLabel() {
        saleWrap.addSubview(saleLabel)
        saleLabel.pinCenter(to: saleWrap)
        saleLabel.font = .boldSystemFont(ofSize: 10)
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
    
    private func configureCountWrap() {
        let countWrap = UIView()
        addSubview(countWrap)
        countWrap.pinLeft(to: image.trailingAnchor, 5)
        countWrap.pinBottom(to: self.bottomAnchor, 8)
        countWrap.setHeight(45)
        countWrap.setWidth(125)
        countWrap.backgroundColor = .systemGray5
        countWrap.layer.cornerRadius = 15
        
        countWrap.addSubview(countLabel)
        countLabel.pinVertical(to: countWrap)
        countLabel.pinCenterX(to: countWrap)
        countLabel.setWidth(20)
        countLabel.backgroundColor = .clear
        countLabel.textAlignment = .center
        countLabel.font = .boldSystemFont(ofSize: 14)
        
        countWrap.addSubview(minusButton)
        minusButton.pinVertical(to: countWrap)
        minusButton.pinLeft(to: countWrap.leadingAnchor)
        minusButton.pinRight(to: countLabel.leadingAnchor)
        let minus = UIImage(named: "minus")?.resized(by: 0.7)
        minusButton.setImage(minus, for: .normal)
        minusButton.backgroundColor = .clear
        minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        
        countWrap.addSubview(plusButton)
        plusButton.pinVertical(to: countWrap)
        plusButton.pinRight(to: countWrap.trailingAnchor)
        plusButton.pinLeft(to: countLabel.trailingAnchor)
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.tintColor = UIColor(named: "icon_color")
        plusButton.backgroundColor = .clear
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
    }
    
    @objc private func didTapPlus() {
        delegate?.didTapPlusButton(descriptionLabel.text)
    }
    
    @objc private func didTapMinus() {
        delegate?.didTapMinusButton(descriptionLabel.text)
    }
}
