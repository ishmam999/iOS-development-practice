//
//  Student+CoreDataProperties.swift
//  dbworks
//
//  Created by Ishmam Islam on 21/7/18.
//  Copyright © 2018 Ishmam Islam. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetch() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: self.entityName)
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var phone: String?

}
