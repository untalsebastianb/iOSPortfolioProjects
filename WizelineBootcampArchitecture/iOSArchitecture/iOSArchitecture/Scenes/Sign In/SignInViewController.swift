//
//  SignInViewController.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 28/06/22.
//

import UIKit
import Combine

class SignInViewController: NiblessViewController {

    private var subscriptions = Set<AnyCancellable>()
    
    private var viewModel: SignInViewModel
    
    private let childViewController: UINavigationController
    
    init(viewModel: SignInViewModel, childViewController: UINavigationController) {
        self.viewModel = viewModel
        self.childViewController = childViewController
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = SignInRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        (view as! SignInRootView).wireControllerToViewModel(viewModel)
    }
    
    private func subscribe() {
        viewModel
            .$isAuthorized
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                if result { self?.presentSearchScene() }
            }.store(in: &subscriptions)
    }
    
    private func presentSearchScene() {
        present(childViewController, animated: true)
    }
}
