//
//  FixedTextField.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 30.04.2025.
//

import Foundation


import UIKit

class FixedHeightTextField: UITextField {

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width, height: 50)
    }
}
