//
//  OtherViewController.swift
//  Closure_and_segues
//
//  Created by Sebastian on 9/10/22.
//

import UIKit

protocol dataDelegate {
    func getString(_ text: String?)
}

class OtherViewController: UIViewController {
    
//    passing data through completion handlers or closures
    var completionHandler: ((String?) -> Void)?
    
//    passing data through delegates
    var delegate: dataDelegate?

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func save(_ sender: Any) {
//        1️⃣ with closure or completion handler
        completionHandler?(textField.text)
//        2️⃣ with delegates
        delegate?.getString(textField.text)
        dismiss(animated: true)
        
//        3️⃣ using notification center
        NotificationCenter.default.post(name: Notification.Name("text"), object: textField.text)
    }
}
