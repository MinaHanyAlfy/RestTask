//
//  Product.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import Foundation

// MARK: - Product
struct Product: Codable, Equatable {
    let barcode, description, id: String
    let imageURL: String
    let name: String
    let retailPrice: Int
    let costPrice: Int?
    var quantity: Int? = 0
    enum CodingKeys: String, CodingKey {
        case barcode, description, id
        case imageURL = "image_url"
        case name
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
        case quantity = "quantity"
    }
}

typealias Products = [String: Product]
