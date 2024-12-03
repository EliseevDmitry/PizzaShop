//
//  ProductCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    static let reuseId = "ProductCell"

    private lazy var containerView: UIView = {
        $0.backgroundColor = .white
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15 // как бороться с magicNumber и нужно ли делать это тут?
        $0.alignment = .leading
        
        $0.distribution = .equalSpacing //уточнить компоновку
        //разобраться
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        //разобраться
        return $0
    }(UIStackView())
    
    private lazy var nameLabel: UILabel = {
        $0.text = "Гавайская" //Хардкод
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
    
    private var priceButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange.withAlphaComponent(0.1) // сделать более прозрачно
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
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Почему нам при создании ячейки нужно вызывать designated init который будет вызывать init у родительского класса

    func update(_ product: Product) {
        nameLabel.text = product.name
        detailLabel.text = product.detail
        priceButton.setTitle("\(product.price) р", for: .normal)
        productImageView.image = UIImage(named: product.image)
    }
    
}

extension ProductCell {
    
    //почему структура а не enum - общепринятая практика?
    struct Layout {
        static let offset: CGFloat = 10
        static let horisontal: CGFloat = 16
        static let vertical: CGFloat = 8
    }
    
    private func setupViews(){
        [containerView].forEach {
            contentView.addSubview($0)
        }
        [productImageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        [nameLabel, detailLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(Layout.horisontal)
            make.top.bottom.equalTo(contentView).inset(Layout.vertical)
            
        }
        
        productImageView.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(Layout.offset)
            make.top.bottom.equalTo(containerView).inset(0)
            make.width.equalTo(0.40 * Screen.width)
            make.height.equalTo(productImageView.snp.width)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerView)
            make.right.equalTo(containerView).inset(Layout.offset)
            make.left.equalTo(productImageView.snp.right).offset(Layout.offset)
        }
    }
    
//приоритет одного constraint над другим
//let constraint = verticalStackView.leftAnchor.constraint(equalTo: self.productImageView.rightAnchor, constant: Layout.offset)
//constraint.priority = .defaultHigh
//constraint.isActive = true

}
