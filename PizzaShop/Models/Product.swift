//
//  Product.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import Foundation

struct Product: Codable {
    var name: String
    var detail: String
    var price: Int
    var image: String
    var isPromo: Bool
}
