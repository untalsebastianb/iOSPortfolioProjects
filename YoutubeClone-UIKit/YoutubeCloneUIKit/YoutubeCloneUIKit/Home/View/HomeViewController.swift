//
//  HomeViewController.swift
//  YoutubeCloneUIKit
//
//  Created by Sebastian on 5/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter = HomePresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await presenter.getHomeData()
        }
    }

}

extension HomeViewController: HomeViewProtocol {
    func getData(list: [[Any]]) {
        print("List:", list)
    }
    
    
}
