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
    var addressResponse: AddressResponse?
    private var coordinate: CLLocationCoordinate2D
    private let url = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address")
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
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

extension DaDataLoader {
    private func getAddress() async {
        guard let url = self.url else { return }
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
        } catch {
            print("Ошибка запроса: \(error)")
        }
    }
    
    func getAddress(coordinate: CLLocationCoordinate2D) -> String {
        var resultString = String()
        self.coordinate = coordinate
        //как работать
        Task {
            await getAddress()
        }
        guard let address = addressResponse?.suggestions else { return "" }
        if !address.isEmpty {
            if let firstAddress = address.first {
                resultString = firstAddress.value
            }
        }
        return resultString
    }
}
