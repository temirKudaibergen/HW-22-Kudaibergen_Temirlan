//
//  TableViewCell.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 12.06.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
//    MARK: Properties
    
    static let identifire = "TableViewCell"
    
    lazy var nameUser: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.font = .systemFont(ofSize: 15, weight: .regular)
        return lable
    }()
    
    weak var users: UsersModel? {
        didSet {
            nameUser.text = users?.name
        }
    }
    
//    MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Setup
    
    private func setupHierarchy() {
        addSubview(nameUser)
    }
    
    private func setupLayout() {
        nameUser.snp.makeConstraints {
        $0.leading.equalToSuperview().offset(10)
        $0.centerY.equalToSuperview()
    }

    }
}
