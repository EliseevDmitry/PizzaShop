//
//  PizzaCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 03.12.2024.
//

import UIKit
import SnapKit

final class PizzaCell: UICollectionViewCell {
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


extension PizzaCell {
    
    //почему структура а не enum - общепринятая практика?
//    struct Layout {
//        static let offset: CGFloat = 10
//        static let horisontal: CGFloat = 16
//        static let vertical: CGFloat = 8
//    }
    
    private func setupViews(){
        [containerView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
//            make.left.right.equalTo(contentView).offset(20)
//            make.top.bottom.equalTo(contentView).inset(5)
            make.left.top.right.bottom.equalTo(contentView)
        }
    }

}
