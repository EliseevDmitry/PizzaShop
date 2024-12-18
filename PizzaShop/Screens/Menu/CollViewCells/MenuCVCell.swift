//
//  MenuCVCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.12.2024.
//

import UIKit

class MenuCVCell: UICollectionViewCell {
    static let reuseId = "MenuCell"
    
    private var containerView: UIView = {
        $0.backgroundColor = .gray
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())
    
    private lazy var captionLabel: UILabel = {
        $0.text = "Пиццы"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.textAlignment = .center
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = self.isSelected ? .cyan : .gray
            captionLabel.textColor = self.isSelected ? .red : .white
        }
    }
    
    //уточнить про - required init?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabel(nameItem: String){
        captionLabel.text = nameItem
    }
}

extension MenuCVCell {
    
    private func setupViews(){
        [containerView, captionLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
//            make.left.right.equalTo(contentView).offset(20)
//            make.top.bottom.equalTo(contentView).inset(5)
            make.left.top.right.bottom.equalTo(contentView)
        }
        captionLabel.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(containerView)
        }
        
    }

}
