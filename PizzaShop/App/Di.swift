//
//  Di.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 31.05.2025.
//

//Dependency Injection Container
class Di {
    
    let productsLoader: IProductsLoader
    let cartStorage: IStorageService
    
    let screenFactory: ScreenFactory
    
    init() {
        
        productsLoader = ProductsLoader()
        cartStorage = StorageService()
        
        screenFactory = ScreenFactory()
        
        screenFactory.di = self
    }
}






