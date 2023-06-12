//
//  DetailView.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 12.06.2023.
//

import UIKit
import SnapKit

enum Gender {
    case male
    case female
}

final class DetailView: UIView {
    
//    MARK: Properties
    
    var userInfo: UsersModel? {
        didSet {
            personNameTextField.text = userInfo?.name
            calendarDataTextField.text = userInfo?.birthdayDate
            genderTextField.text = userInfo?.gender
        }
    }
    weak var delegate: PresenterInput?
    private var isChangeUserFields = false
    
    private lazy var userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
    private lazy var mainStack: UIStackView = {
       let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var personStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var personNameTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.placeholder = "Name"
        return textField
    }()
    
    private lazy var calendarStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var calendarDataTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.placeholder = "Date of Birth"
        textField.delegate = self
        return textField
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var genderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.2.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.placeholder = "Gender"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var editSaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
//    MARK: objc methods
    
    @objc
    func addTapped() {
        if isChangeUserFields {
            personNameTextField.isEnabled = false
            calendarDataTextField.isEnabled = false
            genderTextField.isEnabled = false
            editSaveButton.setTitle("Edit", for: .normal)
            userInfo?.name = personNameTextField.text
            userInfo?.birthdayDate = calendarDataTextField.text
            userInfo?.gender = genderTextField.text
            delegate?.updateUser()
        } else {
            personNameTextField.isEnabled = true
            calendarDataTextField.isEnabled = true
            genderTextField.isEnabled = true
            editSaveButton.setTitle("Save", for: .normal)
        }
        isChangeUserFields.toggle()
    }
    
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
        addSubview(userAvatar)
        addSubview(mainStack)
        addSubview(editSaveButton)
        mainStack.addArrangedSubview(personStackView)
        mainStack.addArrangedSubview(calendarStackView)
        mainStack.addArrangedSubview(genderStackView)
        personStackView.addArrangedSubview(personImageView)
        personStackView.addArrangedSubview(personNameTextField)
        calendarStackView.addArrangedSubview(calendarImageView)
        calendarStackView.addArrangedSubview(calendarDataTextField)
        genderStackView.addArrangedSubview(genderImageView)
        genderStackView.addArrangedSubview(genderTextField)
    }
    
    private func setupLayout() {
        
        userAvatar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(150)
        }

        mainStack.snp.makeConstraints {
            $0.top.equalTo(userAvatar.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-300)
        }

        personImageView.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }

        calendarImageView.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }

        genderImageView.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }

        editSaveButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-18)
            $0.width.equalTo(100)
            $0.height.equalTo(35)
        }
    }
}

extension DetailView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (calendarDataTextField.text?.count == 2) || (calendarDataTextField.text?.count == 5) {
            if !(string == "") {
                calendarDataTextField.text = (calendarDataTextField.text)! + ""
            }
            guard let text = textField.text?.count else { return false }
            return !(text > 9 && (string.count) > range.length)
        }
        else {
            return true
        }
    }
}
