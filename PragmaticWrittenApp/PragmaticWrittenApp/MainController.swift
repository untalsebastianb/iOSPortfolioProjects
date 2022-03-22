//
//  Main.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 21/03/22.
//

import UIKit
import SnapKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPostView()
    }
    
    private func setupPostView(){
        let postView = PostView()
        view.addSubview(postView)
        
        postView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalToSuperview().inset(8)
            make.center.equalToSuperview()
        }
        
    }


}

