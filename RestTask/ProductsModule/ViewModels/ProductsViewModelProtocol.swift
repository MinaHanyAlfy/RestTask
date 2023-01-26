//
//  ProductsViewModelProtocol.swift
//  RestTask
//
//  Created by John Doe on 2023-01-26.
//

import Foundation
protocol ProductsViewModelProtocol {
    var errorPublisher: Published<ErorrMessage?>.Publisher {get}
    var productsSuccessPublisher: Published<Bool?>.Publisher {get}
    
    var products: [Product] {set get}
    func getProducts()
    
    func saveProduct(index: Int)
    func getProductsCount() -> Int
    func getProduct(index: Int) -> Product
    func productName(index: Int) -> String
    func productPrice(index: Int) -> Int
    func productImage(index: Int) -> String
}
