//
//  API.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import Foundation

enum API{
    case fetchProducts
}

extension API: EndPoint {
    
    var baseURL: String {
        return "https://run.mocky.io"
    }
    var urlSubFolder: String {
        return "/v3"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
            
        default:
            return [URLQueryItem(name: "", value: nil)]
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        default :
            return  .get
        }
    }
    
    
    var path: String {
        return "4e23865c-b464-4259-83a3-061aaee400ba"
    }
    
    var body: [String: Any]? {
        switch self{
        default:
            return nil
        }
    }
}
