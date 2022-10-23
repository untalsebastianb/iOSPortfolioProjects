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
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveNewBook() {
        guard let title = titleTextField.text,
              let author = authorTextField.text,
              !title.isEmpty,
              !author.isEmpty else { return }
        
        Library.addNew(book: Book(title: title, author: author, readMe: true))
        navigationController?.popViewController(animated: true)
    }
    
    
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
