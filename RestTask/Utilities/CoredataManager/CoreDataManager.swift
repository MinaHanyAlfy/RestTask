//
//  CoreDataManager.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    func context() ->  NSManagedObjectContext {
        let context = appDelegate().persistentContainer.viewContext
        return context
    }
    
    func save() {
        appDelegate().saveContext()
    }
    
    
}

//MARK: Product Handler
extension CoreDataManager {
    /////////// Manage All Products
    func fetchProducts() -> [Product]{
        let context = context()
        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        guard let objects = try?  context.fetch(fetchRequest) else { return [] }
        var products: [Product] = []
        for objc in objects {
            
            var product = Product(barcode: objc.barcode ?? "", description: objc.desc ?? "", id: objc.id ?? "", imageURL: objc.imageURL ?? "", name: objc.name ?? "", retailPrice: Int(objc.retailPrice), costPrice: Int(objc.costPrice),quantity: Int(objc.quantity))
            
            products.append(product)
        }
        return products
    }
    
    func saveProducts(products: Products){
        for (_, product) in products {
            let prd = ProductCD(context: context())
            prd.id = product.id
            prd.imageURL = product.imageURL
            prd.costPrice = Int64(product.costPrice ?? 0)
            prd.retailPrice = Int64(product.retailPrice)
            prd.name = product.name
            prd.barcode = product.barcode
            prd.desc = product.description
            prd.quantity = Int64(product.quantity ?? 1)
            do {
                try context().save()
                print("✅ Success")
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func updateProduct(product: Product) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCD")

        fetchRequest.predicate = NSPredicate(format: "id = %@ ",product.id)

        do {
            let results = try context().fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                let productQuan = results?[0].value(forKey: "quantity") as! Int
                let sum = productQuan + 1
                
                results?[0].setValue(sum, forKey: "quantity")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try context().save()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    func clearProducts() {
            let context = context()
            let fetchRequestProduct: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
            let objects = try! context.fetch(fetchRequestProduct)
            
            for obj in objects {
                context.delete(obj)
            }
            
            do {
                try context.save()
            } catch {
                print("❌ Error Delete Object")
            }
    }
    /////////// Manage One Product
    func addProduct(product: Product){
        let entity = NSEntityDescription.entity(forEntityName: "ProductCD", in: context())
        if isExist(id: product.id) {
            updateProduct(product: product)
        } else {
            let productManagedObject = NSManagedObject(entity: entity!, insertInto: context())
            productManagedObject.setValue(product.id, forKey: "id")
            productManagedObject.setValue(product.imageURL, forKey: "imageURL")
            productManagedObject.setValue(product.barcode, forKey: "barcode")
            productManagedObject.setValue(product.retailPrice, forKey: "retailPrice")
            productManagedObject.setValue(product.costPrice, forKey: "costPrice")
            productManagedObject.setValue(product.description, forKey: "desc")
            productManagedObject.setValue(product.name, forKey: "name")
            productManagedObject.setValue(product.quantity ?? 1, forKey: "quantity")
            do {
                try context().save()
                print("✅ Success")
                print(productManagedObject)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func getProduct(id: String) -> Product? {
        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        guard let objects = try?  context().fetch(fetchRequest) else{ return nil }
        for objc in objects {
            if id == objc.id {
                let product = Product(barcode: objc.barcode ?? "", description: objc.desc ?? "", id: objc.id ?? "", imageURL: objc.imageURL ?? "", name: objc.name ?? "", retailPrice: Int(objc.retailPrice), costPrice: Int(objc.costPrice),quantity: Int(objc.quantity))
                return product
            }
        }
        return nil
    }
            
            
    ///////Finding Product Duplicate
    func isExist(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCD")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,id)
        
        do {
            let count = try context().count(for: fetchRequest)
            if count > 0 {
                return true
            } else {
                return false
            }
        }catch let error as NSError {
            print("❌ Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }

}
