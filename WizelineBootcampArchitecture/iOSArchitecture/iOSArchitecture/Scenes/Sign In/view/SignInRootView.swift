//
//  SignInRootView.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 28/06/22.
//

import UIKit
import Combine

class SignInRootView: NiblessView {
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let contentView: UIView = UIView()
    
    private let message: String = "This small application is made with the mvvm architecture, with the intention of showing how to implement it in an iOS application."
    
    private var textFieldAttributes: [NSAttributedString.Key : Any] {
        return [.font : UIFont.systemFont(ofSize: 15, weight: .regular)]
    }
    
    private var textFieldLeadingPading: UIView {
        return UIView(frame: .init(x: 0, y: 0, width: 16, height: 45))
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wizeline Music"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35, weight: .medium)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        let attributeplaceHolder =  NSMutableAttributedString(
            string: "Username",
            attributes: textFieldAttributes
        )
        textField.leftView = textFieldLeadingPading
        textField.leftViewMode = .always
        textField.attributedPlaceholder = attributeplaceHolder
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.heightAnchor
            .constraint(equalToConstant: 45)
            .isActive = true
        textField.layer.cornerRadius = 22
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let attributeplaceHolder =  NSMutableAttributedString(
            string: "Password",
            attributes: textFieldAttributes
        )
        textField.leftView = textFieldLeadingPading
        textField.leftViewMode = .always
        textField.attributedPlaceholder = attributeplaceHolder
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.heightAnchor
            .constraint(equalToConstant: 45)
            .isActive = true
        textField.layer.cornerRadius = 22
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [usernameTextField, passwordTextField]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 22
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = .black
        constructHierarchy()
        activateConstraints()
    }
    
    private func constructHierarchy() {
        [titleLabel, messageLabel, inputStackView, loginButton]
            .forEach { contentView.addSubview($0) }
        addSubview(contentView)
    }
    
    private func activateConstraints() {
        activateConstraintsContentView()
        activateConstraintsTitleLabel()
        activateConstraintsMessageLabel()
        activateConstraintsInputStackView()
        activateConstraintsLoginButton()
    }
}

extension SignInRootView {
    func wireControllerToViewModel(_ viewModel: SignInViewModel) {
        loginButton.addTarget(
            viewModel,
            action: #selector(viewModel.signIn),
            for: .touchUpInside
        )
        bindTextFieldsToViewModel(viewModel)
    }
    
    private func bindTextFieldsToViewModel(_ viewModel: SignInViewModel) {
        usernameTextField
            .publisher(for: \.text)
            .map { $0 ?? "" }
            .assign(to: \.username, on: viewModel)
            .store(in: &subscriptions)
        
        passwordTextField
            .publisher(for: \.text)
            .map { $0 ?? "" }
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
}

extension SignInRootView {
    private func activateConstraintsContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let width = contentView.widthAnchor
            .constraint(equalTo: layoutMarginsGuide.widthAnchor)
        let leading = contentView.leadingAnchor
            .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        let top = contentView.topAnchor
            .constraint(equalTo: layoutMarginsGuide.topAnchor)
        let bottom = contentView.bottomAnchor
            .constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        NSLayoutConstraint.activate(
            [width, leading, trailing, top, bottom]
        )
    }
    
    private func activateConstraintsTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = titleLabel.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 4)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: titleLabel.trailingAnchor, constant: 4)
        let top = titleLabel.topAnchor
            .constraint(equalTo: contentView.topAnchor, constant: 60)
        let centerX = titleLabel.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, centerX]
        )
    }
    
    private func activateConstraintsMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = messageLabel.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 38)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: messageLabel.trailingAnchor, constant: 38)
        let top = messageLabel.topAnchor
            .constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        let centerX = messageLabel.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, centerX]
        )
    }
    
    private func activateConstraintsInputStackView() {
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        let leading = inputStackView.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 36)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: inputStackView.trailingAnchor, constant: 36)
        let top = inputStackView.topAnchor
            .constraint(equalTo: messageLabel.bottomAnchor, constant: 80)
        NSLayoutConstraint.activate(
            [leading, trailing, top]
        )
    }
    
    private func activateConstraintsLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let height = loginButton.heightAnchor
            .constraint(equalToConstant: 45)
        let leading = loginButton.leadingAnchor
            .constraint(equalTo: inputStackView.leadingAnchor)
        let trailing = loginButton.trailingAnchor
            .constraint(equalTo: inputStackView.trailingAnchor)
        let top = loginButton.topAnchor
            .constraint(equalTo: inputStackView.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate(
            [height, leading, trailing, top]
        )
    }
}
