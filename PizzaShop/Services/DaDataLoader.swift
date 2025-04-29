//
//  DaDataLoader.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 29.04.2025.
//

import Foundation
import CoreLocation

protocol IDaDataLoader {
    init(coordinate: CLLocationCoordinate2D)
}

final class DaDataLoader: IDaDataLoader {
    var coordinate: CLLocationCoordinate2D
    var addressResponse: AddressResponse?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    private let url = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address")!
    private let dataHeaders: [Header] = [
        Header(
            value: "application/json",
            field: "Content-Type"
        ),
        Header(
            value: "application/json",
            field: "Accept"
        ),
        Header(
            value: "Token ec821447b0173071fa38919df5b963e87efcb3d7",
            field: "Authorization"
        )
    ]
    private let typeRequest = "POST"
    private var bodyRaw: Сoordinates {
        Сoordinates(lat: coordinate.latitude, lon: coordinate.longitude)
    }
    
}

extension DaDataLoader {
    func getAddress() async {
        var request = URLRequest(url: url)
        request.httpMethod = typeRequest
        for header in dataHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.field)
        }
        do {
            let jsonData = try JSONEncoder().encode(bodyRaw)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Ошибка сервера")
                return
            }
            self.addressResponse = try JSONDecoder().decode(AddressResponse.self, from: data)
            print(addressResponse as Any)
        } catch {
            print("Ошибка запроса: \(error)")
        }
    }
}
