//
//  CreateTwiitViewController.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 15/03/22.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class CreateTwiitViewController: UIViewController {
    
    //  MARK: - Outlets
    @IBOutlet weak var postTextView: UITextView!
    
    //  MARK: - Actions
    @IBAction func postButtonAction(_ sender: Any) {
        savePost()
    }

    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func savePost(){
        
        let request = TwiitRequest(imageUrl: nil, text: postTextView.text, videoUrl: nil, location: nil)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.postTwiits, model: request) { (response: SNResultWithEntity<TwiitResponse ,ErrorResponse>) in
            SVProgressHUD.dismiss()
            
            switch response {
            case .success:
                self.dismiss(animated: true, completion: nil)
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
