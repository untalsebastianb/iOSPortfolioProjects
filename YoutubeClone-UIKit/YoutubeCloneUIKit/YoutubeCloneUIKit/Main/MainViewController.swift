//
//  MainViewController.swift
//  YoutubeCloneUIKit
//
//  Created by Sebastian on 5/11/22.
//

import UIKit

class MainViewController: UIViewController {
    
    var rootPageViewContorller: RootPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController {
            destination.rootPageDelegate = self
            rootPageViewContorller = destination
        }
    }
}

extension MainViewController: RootPageProtocol {
    func currentPage(_ index: Int) {
        print("Current page", index)
    }
    
}
