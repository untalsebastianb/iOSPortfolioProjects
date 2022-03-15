//
//  RegisterViewController.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 14/03/22.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class RegisterViewController: UIViewController {
    //   MARK: - Outlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //  MARK: - Action
    @IBAction func doneAction(_ sender: Any) {
        view.endEditing(true)
        performLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        doneButton.layer.cornerRadius = 25
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
        guard let names = nameTextField.text, !names.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Names can not be empty", style: .warning).show()
            return
        }
        
        let request = RegisterRequest(email: email, names: names, password: password)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.register, model: request) {( response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
             
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let user):
                self.performSegue(withIdentifier: "showHome", sender: nil)
                SimpleNetworking.setAuthenticationHeader(prefix: "", token: user.token)
            case .error(let error):
                NotificationBanner(title: "Error", subtitle: "An error has ocurred: \(error.localizedDescription)", style: .danger).show()
                return
            case .errorResult(let entity):
                NotificationBanner(title: "Error", subtitle: "Ups, something went wrong: \(entity.error)", style: .warning).show()
                return
            }
        }
        
        
    }
}
