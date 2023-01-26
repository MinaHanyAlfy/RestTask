//
//  ProductsRepository.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import Foundation
import Combine

protocol ProductsRepositoryProtocol {
    func getProducts() -> AnyPublisher<Products, ErorrMessage>
}

class ProductsRepository: ProductsRepositoryProtocol {
    private var cancellabels = Set<AnyCancellable>()
    
    func getProducts() -> AnyPublisher<Products, ErorrMessage> {
        let subject = PassthroughSubject<Products, ErorrMessage>()
        let configurationRequest = API.fetchProducts
        
        CombineRequestManager.beginRequest(request: configurationRequest, model: Products.self)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    subject.send(completion: .failure(error))
                }
            },receiveValue: { products in
                subject.send(products)
            })
            .store(in: &cancellabels)
        return subject.eraseToAnyPublisher()
    }
}
