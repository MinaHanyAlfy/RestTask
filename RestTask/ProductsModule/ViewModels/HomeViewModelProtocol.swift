//
//  HomeViewModelProtocol.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {

    var products: [Product] {get}
    
    func getTotalPrice() -> Int64
    func clearProducts()
    func getSavedProducts()
    func getProductsCount() -> Int
    func getProduct(index: Int) -> Product
    func productName(index: Int) -> String
    func productPrice(index: Int) -> Int
    func productImage(index: Int) -> String
    func productQuantity(index: Int) -> Int
    
}

