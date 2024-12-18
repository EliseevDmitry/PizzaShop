//
//  Product.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import Foundation

struct AllProducts: Codable {
    let titleSection: String
    let products: [Product]
}

struct Product: Codable {
    let name: String
    let detail: String
    let price: Int
    let image: String
    let isPromo: Bool
}
