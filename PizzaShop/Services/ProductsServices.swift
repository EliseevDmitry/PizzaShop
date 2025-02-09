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
    
    func fetchAddonsProduct() -> [Addons] {
        return addons
    }
    
    private let addons: [Addons] = [
        Addons(name: "Сырный бортик", price: 179, image: "cheesecrust"),
        Addons(name: "Пряная говядина", price: 119, image: "spicybeef"),
        Addons(name: "Моцарелла", price: 79, image: "mozzarella"),
        Addons(name: "Сыры чеддер и пармезан", price: 79, image: "cheeses"),
        Addons(name: "Острый парец халапеньо", price: 59, image: "spicypepper"),
        Addons(name: "Нежный цыпленок", price: 79, image: "tenderchicken"),
        Addons(name: "Шампиньоны", price: 59, image: "mushrooms"),
        Addons(name: "Бекон", price: 79, image: "bacon"),
        Addons(name: "Ветчина", price: 79, image: "ham"),
        Addons(name: "Пикантная пепперони", price: 79, image: "spicypepperoni"),
        Addons(name: "Острая чорризо", price: 79, image: "spicychorizo"),
        Addons(name: "Маринованные огурчики", price: 59, image: "pickledcucumbers"),
        Addons(name: "Свежие томаты", price: 59, image: "tomatoes"),
        Addons(name: "Красный лук", price: 59, image: "redonion"),
        Addons(name: "Сочные ананасы", price: 59, image: "pineapple"),
        Addons(name: "Итальянские травы", price: 79, image: "italianherbs"),
        Addons(name: "Сладкий перец", price: 79, image: "sweetpepper"),
        Addons(name: "Маслины", price: 59, image: "olives"),
        Addons(name: "Кубики брынзы", price: 79, image: "fetacheese"),
        Addons(name: "Митболы", price: 79, image: "meatballs"),
        Addons(name: "Баварские колбаски", price: 129, image: "bavariansausages"),
        Addons(name: "Криветки", price: 199, image: "shrimps")
    ]
}
