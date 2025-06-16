//
//  UIView+applyShadow.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 28.11.2024.
//

import UIKit


//MARK: Question - какая хорошая практика убирать magicNumbers?
//enum

extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}
