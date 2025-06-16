//
//  ScreenFactory.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 31.05.2025.
//

class ScreenFactory {
    weak var di: Di!
    
    func makeMenuScreen() -> MenuScreenVC {
        return MenuScreenVC(productsLoader: di.productsLoader, cartStorage: di.cartStorage)
    }
}
