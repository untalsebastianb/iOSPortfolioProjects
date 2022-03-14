//
//  WelcomeViewController.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 14/03/22.
//

import UIKit

class WelcomeViewController: UIViewController {
//    MARK: - Outlets
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI(){
        signInButton.layer.cornerRadius = 25
    }
}
