//
//  HomeViewModel.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import Foundation
import Combine

class HomeViewModel: HomeViewModelProtocol {
    let coredata = CoreDataManager.shared
    var products: [Product] = []
    
    func getTotalPrice() -> Int64 {
        guard products.count > 0 else { return 0 }
        var sum: Int64 = 0
        for i in products {
            if i.quantity ?? 0 > 0 {
                let qua = Int(i.quantity ?? 0)
                let price = i.retailPrice
                sum += Int64( qua * price)
                print("Sum product: \(i.name) = \(sum) ")
            } else {
                sum = sum + Int64(i.retailPrice)
            }
        }
        return sum
    }
    
    func getSavedProducts() {
        products = coredata.fetchProducts()
    }
    
    func getProductsCount() -> Int {
        return products.count
    }
    
    func getProduct(index: Int) -> Product {
        return products[index]
    }
    
    func productName(index: Int) -> String {
        guard products.count > 0, products.count > index else { return "" }
        return products[index].name
    }
    
    func productPrice(index: Int) -> Int {
        guard products.count > 0, products.count > index else { return 0 }
        return Int(products[index].retailPrice)
    }
    
    func productImage(index: Int) -> String {
        guard products.count > 0, products.count > index else { return "" }
        return products[index].imageURL
    }
    
    func productQuantity(index: Int) -> Int {
        guard products.count > 0, products.count > index else { return 0 }
        return Int(products[index].quantity ?? 0)
    }
    
    func clearProducts() {
        coredata.clearProducts()
        products = []
    }
}
