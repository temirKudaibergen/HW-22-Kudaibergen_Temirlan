//
//  MainView.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 12.06.2023.
//

import UIKit
import SnapKit

class MainView: UIView {
    
//    MARK: Properties
    
    weak var delegate: MainViewControllerDelegate?
    
    lazy var textField: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "Print your name here"
        textfield.textColor = .black
        return textfield
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Press", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
//    MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Setup
    
    private func setupHierarchy() {
        addSubview(textField)
        addSubview(button)
    }
    
    private func setupLayout() {
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }

        button.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(50)
        }
    }
    
//    MARK: objc methods
    
    @objc
    func tapButton() {
        guard let name = textField.text else { return }
        delegate?.addUsers(nameUser: name)
        textField.text = ""
    }
}
