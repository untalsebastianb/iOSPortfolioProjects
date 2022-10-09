//
//  ViewController.swift
//  Closure_and_segues
//
//  Created by Sebastian on 9/10/22.
//

import UIKit

class ViewController: UIViewController, dataDelegate {
    
    func getString(_ text: String?) {
        label.text = text
    }
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showOtherVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! OtherViewController
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
//        Receving data back one to one controller through completion handler
//        vc.completionHandler = { [weak self] text in
//            guard let self = self else { return }
//            self.label.text = text
//        }
        present(vc, animated: true)
    }
    
}

