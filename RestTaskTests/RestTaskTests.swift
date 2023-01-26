//
//  RestTaskTests.swift
//  RestTaskTests
//
//  Created by John Doe on 2023-01-23.
//

import XCTest
@testable import RestTask

final class RestTaskTests: XCTestCase {
    let manager = CoreDataManager.shared

    var products: Products = [:] {
        didSet{
            print("Products: ",products)
        }
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
//MARK: - CoreData
//        self.coreDataManagerTest()
//        self.coreDataManagerProductsTest()
//        self.coreDataManagerClearProductsTest()
//        self.coreDataManagerExistTest()
        
//MARK: - Test Calling API
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}

//MARK: - CoreDataManager Tests -
extension RestTaskTests {
    func coreDataManagerAddingAndExistingTest() {
        let product = Product(barcode: "1000", description: "User Exp", id: "1200", imageURL: "https://goole.com/image", name: "Product1", retailPrice: 100, costPrice: 12)
        
        manager.addProduct(product: product)
        let productSaved = manager.getProduct(id: "1200")
        XCTAssertEqual(product.id, productSaved?.id)
    }
    
    func coreDataManagerProductsTest() {
        
        //        manager.fetchProducts()
        //        print(manager.fetchProducts().count)
        
        XCTAssertEqual(4, manager.fetchProducts().count)
    }
    func coreDataManagerClearProductsTest() {
        manager.clearProducts()
        XCTAssertEqual(0, manager.fetchProducts().count)
    }
    
    func coreDataManagerExistTest() {
        let product = Product(barcode: "1000", description: "User Exp", id: "1300", imageURL: "https://goole.com/image", name: "Product1", retailPrice: 100, costPrice: 12)
        manager.addProduct(product: product)
        print("Products ",manager.fetchProducts() ," Count: ", manager.fetchProducts().count)
        XCTAssertTrue(manager.isExist(id: "1300"))
    }
}

//MARK: - Network Manager Tests -
extension RestTaskTests {
    func fetchData() {
        let networkManager = NetworkManager.shared
        networkManager.getResults(APICase: .fetchProducts, decodingModel: Products.self) { data in
            switch data {
            case .success(let products):
                self.products = products
                
            case .failure(let error):
                print("ERROR: ",error.localizedDescription)
            }
        }
        
    }
}
