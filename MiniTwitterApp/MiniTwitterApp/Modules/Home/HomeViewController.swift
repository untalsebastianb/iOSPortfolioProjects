//
//  HomeViewController.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 14/03/22.
//

import UIKit
import Simple_Networking
import NotificationBannerSwift
import SVProgressHUD

class HomeViewController: UIViewController {
//    MARK: - Outlets
    @IBOutlet weak var twitsTable: UITableView!
    
//   MARK: - Properties
    private let cellId = "TwitTableViewCell"
    private var dataSource = [TwiitResponse]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getTwiits()
    }
    
    private func setupUI(){
        twitsTable.dataSource = self
        twitsTable.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func getTwiits(){
        
        SVProgressHUD.show()
        
        SN.get(endpoint: Endpoints.gettwiits) { (response: SNResultWithEntity<[TwiitResponse], ErrorResponse>) in
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let twiits):
                self.dataSource = twiits
                self.twitsTable.reloadData()
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? TwitTableViewCell {
            cell.setupCellWith(twiitResponse: dataSource[indexPath.row])
            
        }
        return cell
    }
    
    
}
