//
//  CoreDataManager.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 12.06.2023.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataService {
    func addUsers(name: String)
    func getUser(_ index: Int) -> UsersModel?
    func getUsers()
    func getUsersCount() -> Int
    func delete(_ index: Int)
    func update()
}

final class CoreDataManager: CoreDataService {
    
//    MARK: Properties
    
    static let shared = CoreDataManager()
    
    private var users: [UsersModel]?
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HW-22-Kudaibergen_Temirlan")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
//    MARK: Function
    
    func addUsers(name: String) {
        do {
            let user = UsersModel(context: context)
            user.name = name
            try context.save()
            getUsers()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getUser(_ index: Int) -> UsersModel? {
        users?[index]
    }
    
    func getUsers() {
        let fetchRequest: NSFetchRequest<UsersModel> = UsersModel.fetchRequest()
        do {
            users = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            users = []
        }
    }
    
    func getUsersCount() -> Int {
        users?.count ?? 0
    }
    
    func delete(_ index: Int) {
        guard let user = users?[index] else { return }
        context.delete(user)
        do {
            try context.save()
            getUsers()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
