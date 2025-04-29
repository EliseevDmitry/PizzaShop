//
//  Untitled.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 29.04.2025.
//

import Foundation

struct Header {
    let value: String
    let field: String
}

struct Сoordinates: Codable {
    let lat: Double
    let lon: Double
}

struct AddressResponse: Codable {
    let suggestions: [AddressData]
}


//переделать
//struct AddressData: Codable {
//    let value: String
//    let data: DataFields
//
//    struct DataFields: Codable {
//        let city_with_type: String?
//        let street_with_type: String?
//        let house_type_full: String?
//        let house: String?
//    }
//}

struct AddressData: Codable {
    let value: String
    let data: DataFields

    struct DataFields: Codable {
        let cityWithType: String?
        let streetWithType: String?
        let houseTypeFull: String?
        let house: String?

        enum CodingKeys: String, CodingKey {
            case cityWithType = "city_with_type"
            case streetWithType = "street_with_type"
            case houseTypeFull = "house_type_full"
            case house
        }
    }
}
