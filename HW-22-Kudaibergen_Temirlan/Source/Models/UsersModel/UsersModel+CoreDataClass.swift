//
//  UsersModel+CoreDataClass.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 12.06.2023.
//
//

import Foundation
import CoreData

@objc(UsersModel)
public class UsersModel: NSManagedObject {
    
    @NSManaged public var birthdayDate: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersModel> {
        return NSFetchRequest<UsersModel>(entityName: "UsersModel")
    }
}
