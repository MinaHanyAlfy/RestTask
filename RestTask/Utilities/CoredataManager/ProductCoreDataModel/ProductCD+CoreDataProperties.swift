//
//  ProductCD+CoreDataProperties.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//
//

import Foundation
import CoreData


extension ProductCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCD> {
        return NSFetchRequest<ProductCD>(entityName: "ProductCD")
    }

    @NSManaged public var barcode: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var retailPrice: Int64
    @NSManaged public var costPrice: Int64
    @NSManaged public var quantity: Int64

}

extension ProductCD : Identifiable {

}
