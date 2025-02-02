//
//  ProductsServices.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

//фотки взяты с - https://sushi-max.ru/magazin/folder/pitstsa

import Foundation

final class ProductsService {
    
    private let categories: [String] = ["Пиццы", "Комбо", "Закуски", "Коктейли", "Кофе", "Напитки", "Десерты", "Соусы", "Другие товары"]

    func fetchMenuItems() -> [String] {
        return categories
    }
}
