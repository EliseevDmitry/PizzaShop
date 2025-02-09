//
//  AddonsProductCollectionViewCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 09.02.2025.
//

import UIKit
import SnapKit
import SwiftUI

class AddonsProductCollectionViewCell: UICollectionViewCell {
    static let reuseId = "addonsCell"
    
    private var containerView: UIView = {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
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
        $0.textColor = .black
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
        $0.textColor = .black
        $0.textAlignment = .center
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(item: Addons){
        addonsProductImageView.image = UIImage(named: item.image)
        nameLabel.text = item.name
        let rubleSymbol = "\u{20BD}"
        priceLabel.text = "\(item.price.description) \(rubleSymbol)"
    }
}

extension AddonsProductCollectionViewCell {
    
    private func setupViews(){
        [containerView, addonsProductImageView, nameLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(contentView)
        }
        addonsProductImageView.snp.makeConstraints { make in
            make.left.top.right.equalTo(containerView).inset(10)
            make.height.equalTo(addonsProductImageView.snp.width)
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

    //MARK: - Preview

struct AddonsProductCollectionViewCellPreviews: PreviewProvider {

    struct AddonsProductCollectionViewCellContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> UIView {
            let cell = AddonsProductCollectionViewCell()
            cell.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
            let rubleSymbol = "\u{20BD}"
            //cell.updateLabel(nameItem: "40 \(rubleSymbol)")
            return cell
        }
        
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
    
    static var previews: some View {
        AddonsProductCollectionViewCellContainer()
            .previewLayout(.sizeThatFits)
            .frame(width: 200, height: 300)
            .padding()
    }
}


