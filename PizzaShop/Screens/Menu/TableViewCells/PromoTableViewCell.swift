//
//  PromoCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 28.11.2024.
//

import UIKit
import SnapKit

final class PromoTableViewCell: UITableViewCell {
    
    static let reuseId = "PromoCell"
    private var hasShadow = false

//MARK: - UI ELEMENTS
    
    private lazy var roundedView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var nameLabel: UILabel = {
        $0.text = "Гавайская"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    private lazy var detailLabel: UILabel = {
        $0.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    private lazy var priceButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange.withAlphaComponent(0.1)
        configuration.baseForegroundColor = UIColor.brown
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .medium
        configuration.title = "от 469 руб"
        $0.configuration = configuration
        return $0
    }(UIButton())
    
    private lazy var productImageView: UIImageView = {
        $0.image = UIImage(named: "hawaii")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
//MARK: - LIFE CYCLE FUNCTIONS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //проверка отрисовки тени один раз
        if hasShadow == false {
            roundedView.addCustomShadow()
            hasShadow.toggle()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImageView.layer.cornerRadius = productImageView.frame.width / 2
    }
    
    
//MARK: - FUNCTIONS
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        detailLabel.text = product.detail
        priceButton.setTitle("\(product.price) р", for: .normal)
        productImageView.image = UIImage(named: product.image)
    }
}

//MARK: - EXTENSION

extension PromoTableViewCell {
    
    private func setupViews(){
        [roundedView].forEach {
            contentView.addSubview($0)
        }
        [verticalStackView].forEach {
            roundedView.addSubview($0)
        }
        
        //addArrangedSubview($0) - это добавление элемента в сам стэк, в данном случае по вертикали
        //addSubview(...) - это добавление поверх стека (ZStack)
        [productImageView, nameLabel, detailLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    //insert - right и bottom смещаются (-) знаком
    //offset - смещение с положительным знаком
    
    struct PromoLayout {
        static let offset: CGFloat = 8
        static let horisontal: CGFloat = 16
        static let vertical: CGFloat = 32
        static let inset: CGFloat = 20
    }
    
    private func setupConstraints() {
        
        roundedView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(PromoLayout.horisontal)
            make.top.bottom.equalTo(contentView).inset(PromoLayout.vertical)
        }

        verticalStackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(roundedView).inset(PromoLayout.offset)
        }
        
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(roundedView.snp.width).inset(PromoLayout.inset)
            make.height.equalTo(productImageView.snp.width)
        }
    }
  
}
