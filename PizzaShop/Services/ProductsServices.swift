//
//  ProductsServices.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import Foundation

final class ProductsService {
    
    private let products: [Product] = [
        Product(name: "Гавайская", detail: "Тесто, Cыр, Буженина", price: 590, image: "hawaii", isPromo: true), 
        Product(name: "Маргарита", detail: "Тесто, Cыр, Колбаска", price: 650, image: "margarita",  isPromo: false),
        Product(name: "Пепперони", detail: "Тесто, Cыр, Перец, Томат, Лук", price: 710, image: "pepperoni",  isPromo: false)
    ]
    
    func fetchProducts() -> [Product] {
        return products
    }
    
}
