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

    private var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10 
        $0.alignment = .center
        
        //разобраться
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        //разобраться
       
        return $0
    }(UIStackView())
    
    private var nameLabel: UILabel = {
        $0.text = "Гавайская"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    private var detailLabel: UILabel = {
        $0.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    private var priceButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange.withAlphaComponent(0.1)
        configuration.baseForegroundColor = UIColor.brown
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .medium
        configuration.title = "от 469 руб"
        $0.configuration = configuration
        return $0
    }(UIButton())

    private var productImageView: UIImageView = {
        $0.image = UIImage(named: "hawaii")
        $0.contentMode = .scaleAspectFill
        //через Extension устанавливаем размер view относительно используемого экрана мобильного устройства
        $0.widthAnchor.constraint(equalToConstant: Screen.width * 0.9).isActive = true
        $0.heightAnchor.constraint(equalToConstant: Screen.width * 0.9).isActive = true
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

extension PromoCell {

    private func setupViews(){
        [verticalStackView].forEach {
            contentView.addSubview($0)
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
        verticalStackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(contentView).inset(8)
        }
    }
    
}
