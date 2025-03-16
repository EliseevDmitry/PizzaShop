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
    
    private lazy var nameLabel: UILabel = {
        $0.text = "Сыры чеддер и пармезан"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .white
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var priceLabel: UILabel = {
        let rubleSymbol = "\u{20BD}"
        $0.text = "79 \(rubleSymbol)"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.textAlignment = .center
        return $0
    }(UILabel())

    //MARK: - FUNCTIONS OF THE LIFE CYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //нет проверок и надо "let rubleSymbol = "\u{20BD}"" - сделать глобально
    func updateData(item: Addons){
        addonsProductImageView.image = UIImage(named: item.image)
        nameLabel.text = item.name
        let rubleSymbol = "\u{20BD}"
        priceLabel.text = "\(item.price.description) \(rubleSymbol)"
    }
    
}

//MARK: - EXTENSION

extension AddToProductCell {
    
    private func setupViews(){
        [containerView, addonsProductImageView, nameLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(containerView).inset(50)
        }
        addonsProductImageView.snp.makeConstraints { make in
            make.left.right.equalTo(containerView).inset(10)
            make.height.equalTo(addonsProductImageView.snp.width)
            make.centerY.equalTo(containerView.snp.top)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(addonsProductImageView.snp.bottom).offset(5).priority(.low)
            make.centerX.equalTo(containerView.snp.centerX)
            make.left.right.equalTo(containerView).inset(5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalTo(containerView.snp.centerX)
            make.left.right.equalTo(containerView).inset(10)
            make.bottom.equalTo(containerView.snp.bottom).inset(10).priority(.high)
        }
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



