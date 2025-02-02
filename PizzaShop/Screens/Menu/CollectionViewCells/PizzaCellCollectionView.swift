//
//  PizzaCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 03.12.2024.
//

import UIKit
import SnapKit

final class PizzaCellCollectionView: UICollectionViewCell {
    static let reuseId = "PizzaCell"
    
    private var containerView: UIView = {
        $0.backgroundColor = .red
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Нет дополнительных UI-элементов, настройка не требуется
        
        setupViews()
        setupConstraints() //в каком методе жизненного цикла контроллера вызывать настройку констрейнов
    }
    
    //уточнить про - required init?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PizzaCellCollectionView {
    
    private func setupViews(){
        [containerView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(contentView)
        }
    }

}
