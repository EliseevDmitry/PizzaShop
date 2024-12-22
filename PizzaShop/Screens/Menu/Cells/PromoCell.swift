//
//  PromoCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 28.11.2024.
//

import UIKit
import SnapKit

final class PromoCell: UITableViewCell {
    
    static let reuseId = "PromoCell"
    
//MARK: - UI ELEMENTS
    private lazy var roundedView: UIView = {
        $0.backgroundColor = .red
        return $0
    }(UIView())
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
        //разобраться
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        //разобраться
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
        //self.layoutIfNeeded()
        //contentView.layoutIfNeeded()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //add custom layer in view
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(roundedView.frame.size)
        //roundedView.addCustomShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Применяем круглые углы к productImageView (требуется скруглить пиццу)
        //roundedView.addCustomShadow()
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

extension PromoCell {
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
    private func setupConstraints() {
        
        roundedView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            //ругается
            make.top.bottom.equalTo(contentView).inset(32)
        }
        

        verticalStackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(roundedView).inset(8)
        }
        productImageView.snp.makeConstraints { make in
           // make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
           // make.width.equalTo(roundedView.snp.width).multipliedBy(0.5)
            make.width.equalTo(roundedView.snp.width).inset(20)
            make.height.equalTo(productImageView.snp.width)
        }
    }
    
   
        
    
    
}
