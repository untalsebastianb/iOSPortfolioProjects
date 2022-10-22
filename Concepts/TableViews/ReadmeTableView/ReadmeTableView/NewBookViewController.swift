//
//  NewBookViewController.swift
//  ReadmeTableView
//
//  Created by Sebastian on 21/10/22.
//

import Foundation
import UIKit

class NewBookViewController: UITableViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var bookImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.layer.cornerRadius = 16
    }
    
}


// Code to handle the return key when the keyboard is shown
extension NewBookViewController: UITextFieldDelegate {
    
//    Delete placeholder when start editing the texfields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            return authorTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}
