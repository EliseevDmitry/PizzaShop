//
//  Moc.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.03.2025.
//

import Foundation

struct Moc {
        static let product: [Product] = [
            Product(
                name: "Ципленок табака",
                detail: "Помидоры, шпинат, сыр",
                price: 234,
                image: "chicken",
                isPromo: false),
            Product(
                name: "Дьявольская",
                detail: "Помидоры, шпинат, сыр, ветчина",
                price: 234,
                image: "diablo",
                isPromo: false),
            Product(
                name: "Ципленок табака",
                detail: "Помидоры, шпинат, сыр",
                price: 576,
                image: "chicken",
                isPromo: false),
            Product(
                name: "Пеперони",
                detail: "Помидоры, шпинат, сыр, колбаски",
                price: 100,
                image: "grilled",
                isPromo: false),
        ]
    
    static let addProduct: [Product] = [
        Product(
            name: "Добрый Кола",
            detail: "",
            price: 135,
            image: "cola",
            isPromo: false),
        Product(
            name: "Кофе Американо",
            detail: "Горячий кофе для ценителей чистого вкуса",
            price: 135,
            image: "americano",
            isPromo: false),
        Product(
            name: "Чизкейк Банановый с шоколадным печеньем",
            detail: "Солнечная версия классического рецепта: нежный чизкейк с бананом и шоколадным печеньем",
            price: 199,
            image: "banoffee_cheese",
            isPromo: false),
        Product(
            name: "Добрый Апельсин",
            detail: "",
            price: 135,
            image: "orange",
            isPromo: false),
        Product(
            name: "Молочный коктейль со Сникерсом",
            detail: "Тот самый батончик «Сникерс» в удобном формате ледяного милкшейка",
            price: 269,
            image: "snickers",
            isPromo: false),
        Product(
            name: "Картофель из печи",
            detail: "Запеченная в печи картошечка — привычный вкус и мало масла. В составе пряные специи",
            price: 159,
            image: "french_fries",
            isPromo: false),
        Product(
            name: "Омлет сырный",
            detail: "Горячий завтрак из омлета с поджаристой корочкой, моцарелла, кубики брынзы, сыры чеддер и пармезан",
            price: 209,
            image: "with_cheese",
            isPromo: false)
    ]
}

