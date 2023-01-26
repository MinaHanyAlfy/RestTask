//
//  ProductsViewModel.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import Foundation
import Combine

class ProductsViewModel: ProductsViewModelProtocol{
    @Published private var error: ErorrMessage? = nil
    var errorPublisher: Published<ErorrMessage?>.Publisher {$error}
    
    @Published private var productsSuccess: Bool? = nil
    var productsSuccessPublisher: Published<Bool?>.Publisher {$productsSuccess}
    
    
    private var repo: ProductsRepositoryProtocol!
    private var cancellabels = Set<AnyCancellable>()
    
    var products: [Product] = []
    let coredata = CoreDataManager.shared
   
    
    var productObjects: Products = [:]{
        didSet {
            DispatchQueue.main.async { [self] in
                if productObjects.count > 0 {
                    for (_, value) in productObjects {
                        products.append(value)
                    }
                }
            }
        }
    }
    
    init(repo: ProductsRepository = ProductsRepository()) {
        self.repo = repo
    }
    
    
    func getProducts() {
        repo.getProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] product in
                self?.productObjects = product
                self?.productsSuccess = true
            })
            .store(in: &cancellabels)
    }

    
    func saveProduct(index: Int) {
        guard products.count > 0, products.count > index else {
            return
        }
        
        coredata.addProduct(product: products[index])
    }
    
    func productName(index: Int) -> String {
        guard products.count > 0, products.count > index else {
            return ""
        }
        return products[index].name
    }
    
    func productPrice(index: Int) -> Int {
        guard products.count > 0, products.count > index else {
            return 0
        }
        return products[index].retailPrice
    }
    
    func getProductsCount() -> Int {
        return products.count
    }
    
    func getProduct(index: Int) -> Product {
        return products[index]
    }
    
    func productImage(index: Int) -> String {
        guard products.count > 0, products.count > index else {
            return ""
        }
        return products[index].imageURL
    }
}
