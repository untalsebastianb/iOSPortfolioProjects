//
//  Main.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 21/03/22.
//

import UIKit
import SnapKit
import MagazineLayout

class MainController: UIViewController, UICollectionViewDataSource {
    
    let networkClient = NetworkClient.shared
    
    var fetchedPost: [PostDetailResponseModel] = [PostDetailResponseModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let mockPost: [PostCollectionViewCell.ViewModel] = [
        PostCollectionViewCell.ViewModel(title: "Adopt", subtitle: "Beatiful Dog", postedBy: "Maria"),
        PostCollectionViewCell.ViewModel(title: "Adopt", subtitle: "Beatiful Cat", postedBy: "Pedro"),
        PostCollectionViewCell.ViewModel(title: "Sell", subtitle: "Beatiful Car", postedBy: "Jose"),
        PostCollectionViewCell.ViewModel(title: "Rent", subtitle: "Big Apartment", postedBy: "Antonio")
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = MagazineLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedPost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
        let viewModel = PostCollectionViewCell.ViewModel(title: fetchedPost[indexPath.item].name, subtitle: fetchedPost[indexPath.item].name, postedBy: fetchedPost[indexPath.item].name)
        cell.set(viewModel)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        setupCollectionView()
        networkClient.getPost { (post, error ) in
            if let _ = error {
                print(" there was an error ⚠️")
            }
            guard let post = post else { return }
            DispatchQueue.main.async {
                self.fetchedPost = post.results
            }
           
        }
    }
    
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainController: UICollectionViewDelegateMagazineLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 60, left: 0, bottom: 30, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        .hidden
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
        .hidden
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
        .hidden
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
        MagazineLayoutItemSizeMode(widthMode: .fullWidth(respectsHorizontalInsets: true), heightMode: .dynamic)
    }
}



