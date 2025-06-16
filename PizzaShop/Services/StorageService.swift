//
//  StorageService.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.03.2025.
//

import Foundation
import CoreData

protocol IStorageService {
    func addProduct(product: Product) -> Bool
    func deleteProduct(indexSet: IndexSet) -> Bool
    func updateProduct(entity: ProductEntities, product: Product) -> Bool
    func removeAllEntities() -> Bool
    func getProductsToEntities() -> [Product]
    func getEntitiByProductName(name: String) -> ProductEntities?
    func addToBasket(product: Product) -> Bool
}


final class StorageService: IStorageService {
    private var savedProducts: [ProductEntities] = []
    private let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Product")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error.localizedDescription)")
            } else {
                print("Successfully loaded core data!")
            }
            self.fechProducts()
        }
    }
}

extension StorageService {
    
    @discardableResult
    func addProduct(product: Product) -> Bool {
        let newProduct = ProductEntities(context: container.viewContext)
        newProduct.name = product.name
        newProduct.detail = product.detail
        newProduct.price = Int64(product.price)
        newProduct.image = product.image
        newProduct.ispromo = product.isPromo
        return saveData()
    }
    
    func deleteProduct(indexSet: IndexSet) -> Bool {
        guard let index = indexSet.first else { return false }
        let entiti = savedProducts[index]
        container.viewContext.delete(entiti)
        return saveData()
    }
    
    func updateProduct(entity: ProductEntities, product: Product) -> Bool {
        entity.name = product.name
        entity.detail = product.detail
        entity.price = Int64(product.price)
        entity.image = product.image
        entity.ispromo = product.isPromo
        return saveData()
    }
    
    func removeAllEntities() -> Bool {
        savedProducts.forEach { container.viewContext.delete($0)}
        return saveData()
    }
    
    func getProductsToEntities() -> [Product] {
        if savedProducts.isEmpty {
            return []
        }
        var products: [Product] = []
        for item in savedProducts {
            let product = Product(
                name: item.name ?? "",
                detail: item.detail ?? "",
                price: Int(item.price),
                image: item.image ?? "",
                isPromo: false,
                count: 1
            )
            products.append(product)
        }
        return products
    }
    
    private func fechProducts(){
        let request = NSFetchRequest<ProductEntities>(entityName: "ProductEntities")
        do{
            savedProducts = try container.viewContext.fetch(request)
        } catch let error {
            print("Error request Core Data \(error.localizedDescription)")
        }
    }
    
    private func saveData() -> Bool {
        do{
            try container.viewContext.save()
            fechProducts()
            return true
        } catch let error {
            print("Error saving  data to Core Data. \(error.localizedDescription)")
        }
        return false
    }
    
    func getEntitiByProductName(name: String) -> ProductEntities? {
        for item in savedProducts {
            if item.name == name {
                return item
            }
        }
        return nil
    }
    
    func addToBasket(product: Product) -> Bool {
        guard let entity = getEntitiByProductName(name: product.name) else {
            if addProduct(product: product) {
                return true
            }
            return false
        }
        return updateProduct(entity: entity, product: product)
    }
    
}


extension ProductEntities {
    func toProduct() -> Product {
        return Product(
            name: self.name ?? "",
            detail: self.detail ?? "",
            price: Int(self.price),
            image: self.image ?? "",
            isPromo: self.ispromo,
            count: 1
        )
    }
}

extension Product {
    func toProductEntity(context: NSManagedObjectContext) -> ProductEntities {
        let entity = ProductEntities(context: context)
        entity.name = self.name
        entity.detail = self.detail
        entity.price = Int64(self.price)
        entity.image = self.image
        entity.ispromo = self.isPromo
        return entity
    }
}
