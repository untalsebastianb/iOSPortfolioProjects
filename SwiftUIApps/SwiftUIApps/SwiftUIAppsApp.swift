//
//  SwiftUIAppsApp.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 7/31/24.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUIAppsApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
