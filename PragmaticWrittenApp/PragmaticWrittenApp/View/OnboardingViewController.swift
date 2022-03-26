//
//  OnboardingViewController.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 26/03/22.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleAndSubtitle()
        setupButtons()
    }
    
    private func setupTitleAndSubtitle() {
        
        view.backgroundColor = Colors.secondaryBackgroundColor
        let titleLabel: PrimaryHeader = {
            let label = PrimaryHeader()
            label.text = "Mi App"
            label.textAlignment = .center
            return label
        }()
        
        let subtitleLabel: SecondaryLabel = {
            let label = SecondaryLabel()
            label.text = "You should register to continue"
            label.textAlignment = .center
            return label
        }()
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 8
            return stack
        }()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.snp.makeConstraints { make in
            // this center the item horizontally and vertically
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
        }
    }
    
    private func setupButtons() {
        let registerButton: UIButton = {
           let button = UIButton(type: .system)
            button.backgroundColor = .lightGray
            button.setTitle("Sign Up", for: .normal)
            button.tintColor = .black
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(showRegisterVC), for: .touchUpInside)
            return button
        }()
        
        let loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("LogIn", for: .normal)
            button.backgroundColor = .lightGray
            button.tintColor = .black
            button.layer.cornerRadius = 10
            return button
        }()
    
        
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 8
            return stack
        }()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(registerButton)
        stackView.addArrangedSubview(loginButton)
        stackView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview().inset(16)
        }
    }
    
    @objc private func showRegisterVC() {
        print("123")
    }
}
