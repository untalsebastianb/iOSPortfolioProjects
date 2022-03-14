//
//  LoginViewController.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 14/03/22.
//

import UIKit
import NotificationBannerSwift

class LoginViewController: UIViewController {
//  MARK: - Outlets
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
//  MARK: - Actions
    @IBAction func signInButtonAction(_ sender: Any) {
        view.endEditing(true)
        performLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        signInButton.layer.cornerRadius = 25
    }
    
    private func performLogin(){
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Email can not be empty", style: .warning).show()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Password can not be empty", style: .warning).show()
            return
        }
    }
    
  

}
