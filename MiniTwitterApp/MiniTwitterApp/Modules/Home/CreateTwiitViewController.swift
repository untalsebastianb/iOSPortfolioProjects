//
//  CreateTwiitViewController.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 15/03/22.
//

import UIKit

class CreateTwiitViewController: UIViewController {
    
//  MARK: - Outlets
    @IBOutlet weak var postTextView: UITextView!
    
//  MARK: - Actions
    @IBAction func postButtonAction(_ sender: Any) {
    }

    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
