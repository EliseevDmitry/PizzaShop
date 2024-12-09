//
//  UIView+applyShadow.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 28.11.2024.
//

import UIKit

extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func dropShadow() {
           // Убираем обрезку слоя
           layer.masksToBounds = false
   
           // Настройка цвета и прозрачности тени
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.5
           layer.shadowOffset = CGSize(width: 10, height: 10) // Смещение тени
           layer.shadowRadius = 10 // Радиус размытия тени
   
           // Устанавливаем правильный путь для тени с учетом округленных углов
           let path = UIBezierPath(
               roundedRect: bounds.insetBy(dx: -layer.shadowRadius, dy: -layer.shadowRadius), // Увеличиваем область для тени
               byRoundingCorners: [.topLeft, .topRight],
               cornerRadii: CGSize(width: Screen.width / 2, height: Screen.width / 2)
           )
           layer.shadowPath = path.cgPath
   
           // Растрируем тень для оптимизации производительности
           layer.shouldRasterize = true
       }
    
}
