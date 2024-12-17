//
//  PromoCell+applyShadow.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 16.12.2024.
//

import UIKit


extension UIView {
    func addCustomShadow() {
        //create custom path
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: self.bounds.width / 2, y: self.bounds.width / 2), radius: self.bounds.width / 2, startAngle: .pi * 1.5, endAngle: 0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: (self.bounds.width - 20), y: (self.bounds.height - 20)), radius: 20, startAngle: 0, endAngle: .pi/2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 20, y: (self.bounds.height - 20)), radius: 20, startAngle: .pi/2, endAngle: .pi, clockwise: true)
        path.addArc(withCenter: CGPoint(x: self.bounds.width / 2, y: self.bounds.width / 2), radius: self.bounds.width / 2, startAngle: .pi, endAngle: .pi * 1.5, clockwise: true)
        path.close()
        //add shapeLayer in view
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowRadius = 4.0
        shapeLayer.shadowOpacity = 0.3
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
}
