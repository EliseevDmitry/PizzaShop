//
//  BasketTableViewCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 16.03.2025.
//

import UIKit
import SwiftUI

final class BasketTableViewCell: UITableViewCell {
    
    static let reuseId = "BasketCell"
    
    var totalPrice: Int = 469 {
        didSet {
            updatePriceLabel()
        }
    }

    private lazy var containerView: UIView = {
        $0.backgroundColor = .gray
        return $0
    }(UIView())
    
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 10)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var horizontalStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var productImageView: UIImageView = {
        $0.image = UIImage(named: "hawaii")
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private lazy var verticalDescriptionStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 10)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var nameLabel: UILabel = {
        $0.text = "Гавайская"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var detailLabel: UILabel = {
        $0.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var priceHorizontalStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .fill
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var priceLabel: UILabel = {
        let rubleSymbol = "\u{20BD}"
        $0.text = "\(totalPrice) \(rubleSymbol)"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var titleLabel: UILabel = {
        $0.text = "Изменить"
        $0.textAlignment = .right
        $0.textColor = .orange
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    private lazy var stepper: StepperView = {
        $0.onValueChanged = { [weak self] value in
                self?.totalPrice = value * 469 // Обновляем цену на основе количества
            }
            return $0
    }(StepperView())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ product: Product) {
        nameLabel.text = product.name
        detailLabel.text = product.detail
        //priceButton.setTitle("\(product.price) р", for: .normal)
        productImageView.image = UIImage(named: product.image)
    }
    
}

extension BasketTableViewCell {
    
   
    
    private func setupViews(){
        [containerView].forEach {
            contentView.addSubview($0)
        }
        [verticalStackView].forEach {
            containerView.addSubview($0)
        }
        [horizontalStackView, priceHorizontalStackView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        [productImageView, verticalDescriptionStackView].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        [nameLabel, detailLabel].forEach {
            verticalDescriptionStackView.addArrangedSubview($0)
        }
        [priceLabel, titleLabel, stepper].forEach {
            priceHorizontalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView)
        }
        verticalStackView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(containerView)
            
        }
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Screen.width/3)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
        }
        
        priceHorizontalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(verticalStackView.layoutMargins)
        }
        
        stepper.snp.makeConstraints { make in
            make.centerY.equalTo(priceHorizontalStackView)
            make.height.equalTo(contentView).multipliedBy(0.13)
            make.width.equalTo(contentView).multipliedBy(0.25)
        }

    }
    
    private func updatePriceLabel() {
        let rubleSymbol = "\u{20BD}"
        priceLabel.text = "\(totalPrice) \(rubleSymbol)"
    }

}


//MARK: - PREVIEW

struct BasketTableViewCellPreviews: PreviewProvider {

    struct BasketTableViewCellContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> UIView {
            let cell = BasketTableViewCell()
            // Создаём фиктивный продукт для обновления
            let product = Product(name: "Гавайская", detail: "Тесто, Цыпленок, моцарелла, томатный соус", price: 469, image: "chicken", isPromo: false)
            cell.update(product) // Вызываем метод для обновления данных ячейки
            return cell
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            // Можно обновить UI, если требуется
        }
    }

    static var previews: some View {
        BasketTableViewCellContainer()
            .previewLayout(.sizeThatFits)
            .frame(width: Screen.width, height: 300)
            .padding()
    }
}

