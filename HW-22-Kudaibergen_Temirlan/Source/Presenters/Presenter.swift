//
//  Presenter.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 12.06.2023.
//

import Foundation

protocol PresenterOutput: AnyObject {
    func showDataUser()
}

protocol PresenterInput: AnyObject {
    func addUser(nameUser: String)
    func getDataUsers()
    func getUsersCount() -> Int
    func getUser(_ index: Int) -> UsersModel?
    func deleteUser(_ index: Int)
    func updateUser()
}

final class Presenter: PresenterInput {
    
//    MARK: Properties
    
    weak var view: PresenterOutput?
    private var coreDataService: CoreDataService
    
//    MARK: Initilizer
    
    init(view: PresenterOutput, coreDataService: CoreDataService) {
        self.view = view
        self.coreDataService = coreDataService
    }
    
//    MARK: Function
    
    func addUser(nameUser: String) {
        coreDataService.addUsers(name: nameUser)
        view?.showDataUser()
    }
    
    func getDataUsers() {
        coreDataService.getUsers()
        view?.showDataUser()
    }
    
    func getUsersCount() -> Int {
        coreDataService.getUsersCount()
    }
    
    func getUser(_ index: Int) -> UsersModel? {
        coreDataService.getUser(index)
    }
    
    func deleteUser(_ index: Int) {
        coreDataService.delete(index)
        view?.showDataUser()
    }
    
    func updateUser() {
        coreDataService.update()
    }
}
