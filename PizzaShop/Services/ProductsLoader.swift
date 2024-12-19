//
//  ProductsLoader.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 11.12.2024.
//

import Foundation

// I - интерфейс "логика найминга"
protocol IProductsLoader {
    init(urlSession: URLSession, decoder: JSONDecoder)
}

struct ProductsLoader: IProductsLoader {
    
    let urlSession: URLSession
    let decoder: JSONDecoder
    
    init(urlSession: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func loadProducts(completion: @escaping ([AllProducts])->()) {
        guard let url = URL(string: "http://localhost:3001/products") else { return }
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data")
                return
            }
            do {
                let products = try decoder.decode([AllProducts].self, from: data)
                DispatchQueue.main.async {
                    print(products)
                    completion(products)
                }
            } catch let error {
                print("Error decoding data - \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
