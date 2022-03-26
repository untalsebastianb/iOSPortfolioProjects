//
//  RegisterViewController.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 26/03/22.
//

import UIKit

class RegisterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputFields()
        setupButton()
    }
    
    private func setupInputFields() {
        
        view.backgroundColor = Colors.secondaryBackgroundColor
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 10
            return stack
        }()
        
        let nameLabel: SecondaryLabel = {
            let label = SecondaryLabel()
            label.text = "Name"
            return label
        }()
        
        let nameTextField: UITextField = {
            let field = UITextField()
            field.autocorrectionType = .no
            field.autocapitalizationType = .none
            field.placeholder = "Name"
            field.borderStyle = .roundedRect
            field.backgroundColor = .init(white: 0, alpha: 0.03)
            return field
        }()
        
        let emailLabel: SecondaryLabel = {
            let label = SecondaryLabel()
            label.text = "Email"
            return label
        }()
        
        let emailTextField: UITextField = {
            let field = UITextField()
            field.autocorrectionType = .no
            field.autocapitalizationType = .none
            field.placeholder = "Email"
            field.borderStyle = .roundedRect
            field.backgroundColor = .init(white: 0, alpha: 0.03)
            return field
        }()

        
        let passwordLabel: SecondaryLabel = {
            let label = SecondaryLabel()
            label.text = "Password"
            return label
        }()
        
        let passwordTextField: UITextField = {
            let field = UITextField()
            field.placeholder = "Password"
            field.borderStyle = .roundedRect
            field.backgroundColor = .init(white: 0, alpha: 0.03)
            return field
        }()

        
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
        }
    }
    
    private func setupButton() {
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Done", for: .normal)
        registerButton.backgroundColor = .lightGray
        registerButton.tintColor = .black
        registerButton.layer.cornerRadius = 10
        
        view.addSubview(registerButton)
        
        registerButton.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview().inset(16)
        }
    }
}
