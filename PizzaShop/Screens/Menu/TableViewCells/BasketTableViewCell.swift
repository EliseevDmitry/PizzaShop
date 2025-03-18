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
    private var price = Int()
    var product: Product?
    var onProductChanged: ((Product)->Void)?
    
    var totalPrice: Int = 0 {
        didSet {
            updatePriceLabel()
        }
    }

    private lazy var containerView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    

    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .leading
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    

    
    private lazy var productImageView: UIImageView = {
        $0.image = UIImage(named: "chicken")
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
        $0.backgroundColor = .clear
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
            guard let self = self else { return }
            self.totalPrice = value * (self.price) // Обновляем цену на основе количества
            self.product?.count = value
            if let prod = self.product {
                self.onProductChanged?(prod)
            }
        }
            return $0
    }(StepperView())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupViews()
        setupConstraints()
        updatePriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ product: Product) {
        self.product = product
        
        //переделать
        nameLabel.text = product.name
        detailLabel.text = product.detail
        price = product.price
        totalPrice = price
        productImageView.image = UIImage(named: product.image)
    }
    
    func getValue() -> Int {
        stepper.value
    }
    
}

extension BasketTableViewCell {
    
   
    
    private func setupViews(){
        [containerView].forEach {
            contentView.addSubview($0)
        }

        [productImageView, verticalStackView, priceHorizontalStackView].forEach {
            containerView.addSubview($0)
        }
       
        [nameLabel, detailLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        [priceLabel, titleLabel, stepper].forEach {
            priceHorizontalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Screen.width / 3.5)
            make.leading.top.equalTo(containerView).offset(10)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.top.trailing.equalTo(containerView).inset(10)
        }

        priceHorizontalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView.layoutMargins)
            make.bottom.equalTo(containerView.snp.bottom).inset(10) // Выравнивание по нижнему краю
            make.top.equalTo(productImageView.snp.bottom).offset(10) // Отступ 10pt от картинки
           // make.height.equalTo(contentView).multipliedBy(0.2)
        }
        
        stepper.snp.makeConstraints { make in
            make.centerY.equalTo(priceHorizontalStackView)
            make.width.equalTo(contentView).multipliedBy(0.25)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.2)
        }

    }
    
    private func updatePriceLabel() {
        guard let price = product?.price,
              let count = product?.count else { return }
        priceLabel.text = "\(price * count) \(Constants.rubleSymbol)"
    }

}


//MARK: - PREVIEW

struct BasketTableViewCellPreviews: PreviewProvider {

    struct BasketTableViewCellContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> UIView {
            let cell = BasketTableViewCell()
            // Создаём фиктивный продукт для обновления
            let product = Product(name: "Гавайская", detail: "Тесто, Цыпленок, моцарелла, томатный соус", price: 469, image: "chicken", isPromo: false, count: 1)
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

