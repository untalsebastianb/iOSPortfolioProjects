//
//  ViewController.swift
//  Closure_and_segues
//
//  Created by Sebastian on 9/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showOtherVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! OtherViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

