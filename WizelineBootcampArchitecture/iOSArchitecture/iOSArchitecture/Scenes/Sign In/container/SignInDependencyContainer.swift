//
//  SignInDependencyContainer.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 28/06/22.
//

import UIKit

final class SignInDependencyContainer {
    
    private func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel()
    }
    
    func makeSignInViewController(_ childViewController: UINavigationController) -> SignInViewController {
        let signInViewModel = makeSignInViewModel()
        return SignInViewController(viewModel: signInViewModel, childViewController: childViewController)
    }
}
