//
//  MainViewController.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 31.05.2023.
//

import UIKit
import SnapKit

protocol MainViewControllerDelegate: AnyObject {
    func addUsers(nameUser: String)
}

final class MainViewController: UIViewController, MainViewControllerDelegate, PresenterOutput {

//    MARK: Properties
    
    var presenter: PresenterInput?
    
    var mainView = MainView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifire)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
//    MARK: Initilizer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
//    MARK: Setup
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
//    MARK: Lifcyle and Protocol methods
    
    override func loadView() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        view = mainView
        mainView.delegate = self
        presenter?.getDataUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDataUser()
    }
    
    func addUsers(nameUser: String) {
        presenter?.addUser(nameUser: nameUser)
    }
    
    func showDataUser() {
        self.tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getUsersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifire,
                                                       for: indexPath) as? TableViewCell else {return UITableViewCell()}
        cell.users = presenter?.getUser(indexPath.row)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.detailView.userInfo = presenter?.getUser(indexPath.row)
        detailViewController.detailView.delegate = presenter
        self.navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteUser(indexPath.row)
        }
    }
}

