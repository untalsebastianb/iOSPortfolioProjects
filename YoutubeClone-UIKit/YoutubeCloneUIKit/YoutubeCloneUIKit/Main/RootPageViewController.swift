//
//  RootPageViewController.swift
//  YoutubeCloneUIKit
//
//  Created by Sebastian on 5/11/22.
//

import UIKit

protocol RootPageProtocol: AnyObject {
    func currentPage(_ index: Int)
}

class RootPageViewController: UIPageViewController {
    
    private var subviewControllers = [UIViewController]()
    private var currentIndex: Int = 0
    weak var rootPageDelegate: RootPageProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setupViewController()
    }
    
    private func setupViewController() {
        subviewControllers = [
        HomeViewController(),
        VideosViewController(),
        PlaylistsViewController(),
        ChannelsViewController(),
        AboutViewController()
        ]
        _ = subviewControllers.enumerated().map { $0.element.view.tag = $0.offset}
        setViewControllerFromIndex(index: 0, direction: .forward)
    }
    
    func setViewControllerFromIndex(index: Int, direction: NavigationDirection, animated: Bool = true) {
        setViewControllers([subviewControllers[index]], direction: direction, animated: animated)
    }
}

extension RootPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        subviewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index: Int = subviewControllers.firstIndex(of: viewController) ?? 0
        if index <= 0 {
            return nil
        }
        return subviewControllers[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("Finished:", finished)
        if let index = pageViewController.viewControllers?.first?.view.tag {
            currentIndex = index
            rootPageDelegate?.currentPage(currentIndex)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index: Int = subviewControllers.firstIndex(of: viewController) ?? 0
        if index >= (subviewControllers.count - 1) {
            return nil
        }
        return subviewControllers[index+1]
    }
    
    
}
