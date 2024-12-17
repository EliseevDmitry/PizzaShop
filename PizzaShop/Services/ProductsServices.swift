//
//  ProductsServices.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import Foundation

final class ProductsService {
    
    //фотки взяты с - https://sushi-max.ru/magazin/folder/pitstsa
    private let products: [Product] = [
        Product(name: "Цыпленок с сыром", detail: "Цыпленок, Сыр моцарелла, Томаты, Сарный соус", price: 700, image: "chicken", isPromo: true),
        Product(name: "Пицца \"Дьябло\"", detail: "Бекон, Куриное филе, Болгарский перец, Пепперони, Холапеньо, Соус \"Шрирача\", Сыр", price: 700, image: "diablo",  isPromo: false),
        Product(name: "Пицца фри", detail: "Томатный соус, Курица, Моцарелла, Лук красный, Огурец маринованный, Помидор, Картофель фри, Соус чесночный", price: 700, image: "fries",  isPromo: false),
        Product(name: "Пицца \"колбаски барбекю\"", detail: "Колбаски чоризо, Томаты, Красный лук, Сыр, Соус \"Барбекю\"", price: 700, image: "grilled", isPromo: true),
        Product(name: "Мексиканская пицца", detail: "Томатный соус, Курица, Моцарелла, Лук красный, Перец болгарский, Помидоры, Перец холапеньо, Соус сальса", price: 700, image: "mexican",  isPromo: false),
        Product(name: "С ростбифом и рукколой", detail: "Ростбиф, Руккола, Вяленые томаты", price: 900, image: "roastbeef",  isPromo: false),
        Product(name: "Пицца \"Тыр-Тыр\"", detail: "Белый соус, Курица, Бекон, Помидор, Корнишоны, Моцарелла", price: 700, image: "shh-shh", isPromo: true),
        Product(name: "Пицца \"ранчо дяди Вани\"", detail: "Цыпленок гриль, Ветчина, Моцарелла, Томаты, Соус чесночный", price: 700, image: "uncleranch",  isPromo: false),
        Product(name: "Пицца \"с беконом\"", detail: "Бекон, Сыр пармезан, Сыр моцарелла", price: 650, image: "withbacon",  isPromo: false)
    ]
    
    func fetchProducts() -> [Product] {
        return products
    }
    
}
