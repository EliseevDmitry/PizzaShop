//
//  AddToProductCollectionViewCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 16.03.2025.
//


import UIKit
import SnapKit
import SwiftUI

class AddToProductCell: UICollectionViewCell {
    static let reuseId = "AddToProductCell"
    
    //MARK: - LAZY VAR
    
    private var containerView: UIView = {
        $0.backgroundColor = .darkGray
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())
    
    private lazy var addonsProductImageView: UIImageView = {
        $0.image = UIImage(named: "cheeses")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .leading
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var nameLabel: UILabel = {
        $0.text = "Молочный коктейль со Сникерсом"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .white
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 3
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var propertiesLabel: UILabel = {
        $0.text = "100 г"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .lightGray
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 1
        $0.numberOfLines = 1
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var priceButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .lightGray
        configuration.baseForegroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        let rubleSymbol = "\u{20BD}"
        configuration.title = "79 \(rubleSymbol)"
        $0.configuration = configuration
        $0.addTarget(nil, action: #selector(addButton), for: .touchUpInside)
        return $0
    }(UIButton())

    //MARK: - FUNCTIONS OF THE LIFE CYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(item: Product){
        addonsProductImageView.image = UIImage(named: item.image)
        nameLabel.text = item.name
        priceButton.setTitle("\(item.price.description) \(Constants.rubleSymbol)", for: .normal)
    }
    
}

//MARK: - EXTENSION

extension AddToProductCell {
    
    private func setupViews(){
        [containerView, addonsProductImageView, verticalStackView].forEach {
            contentView.addSubview($0)
        }
        [nameLabel, propertiesLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(containerView).inset(50)
        }
        
        addonsProductImageView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.centerY.equalTo(containerView.snp.top)
            make.top.equalTo(contentView)
            make.height.width.equalTo(containerView.snp.width).multipliedBy(1.0 / 1.5)
            
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(addonsProductImageView.snp.bottom)
            make.leading.bottom.trailing.equalTo(containerView)
        }
        
        propertiesLabel.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(0.1)
        }
        
        priceButton.snp.makeConstraints { make in
            make.left.right.equalTo(containerView).inset(10)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.15)
        }
    }
    
    @objc private func addButton() {
        print("Добавить в корзину")
    }
    
}

    //MARK: - PREVIEW

struct AddToProductCollectionViewCellPreviews: PreviewProvider {

    struct AddToProductCollectionViewCellContainer: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            return AddToProductCell()
        }
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
    
    static var previews: some View {
        AddToProductCollectionViewCellContainer()
            .previewLayout(.sizeThatFits)
            .frame(width: 200, height: 300)
            .padding()
    }
    
}



