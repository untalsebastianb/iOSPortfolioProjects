//
//  SearchViewController.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import AVKit
import UIKit
import Combine

class SearchViewController: UIViewController {
    
    private var viewModel: SearchSongViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    private var playerViewController = AVPlayerViewController()
    
    private var tableFooterView: UIView {
        let tableFooterView = UIView()
        tableFooterView.backgroundColor = .black
        return tableFooterView
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.tableFooterView = tableFooterView
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search by song or artist"
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.tintColor = .white
        return searchController
    }()
    
    private lazy var logoutButton: UIBarButtonItem = {
        let logoutButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(closeSession))
        logoutButton.tintColor = .white
        return logoutButton
    }()
    
    convenience init(viewModel: SearchSongViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        view.addSubview(tableView)
        
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseIdentifier)
        tableView.register(AlbumCellTableViewCell.self, forCellReuseIdentifier: AlbumCellTableViewCell.reuseIdentifier)
        
        viewModel
            .$songResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
        
        viewModel
            . $albumResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel
            .$isSearchByArtist
            .sink { value in
                print(value)
            }
            .store(in: &subscriptions)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func closeSession() {
        dismiss(animated: true)
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Welcome!"
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func playDownload(_ song: Song) {
        present(playerViewController, animated: true) { [weak playerViewController] in
            if let url = URL(string: song.previewUrl) {
                playerViewController?.player = AVPlayer(url: url)
                playerViewController?.player?.play()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        searchController.dismiss(animated: true) { [weak viewModel] in
            viewModel?.songInput = searchTerm
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.songInput = ""
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.reuseIdentifier == SongCell.reuseIdentifier {
            guard let songCell = cell as? SongCell else { print("Error trying to display a custom cell"); return }
            let song = viewModel.songResults[indexPath.row]
            songCell.configureUI(with: song)
            
        } else if cell.reuseIdentifier == AlbumCellTableViewCell.reuseIdentifier && viewModel.isSearchByArtist == true {
            guard let albumCell = cell as? AlbumCellTableViewCell else { print("Error trying to display a custom cell"); return }
            let album = viewModel.albumResult[indexPath.row]
            albumCell.configureUI(with: album)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.songResults[indexPath.row]
        playDownload(song)
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        if section == 0 {
            if viewModel.isSearchByArtist {
                headerLabel.text = "Albums"
                headerLabel.backgroundColor =  #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
                headerLabel.tintColor = .black
            }
        } else {
            headerLabel.text = "Songs"
            headerLabel.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
            headerLabel.tintColor = .black
        }
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return viewModel.albumResult.count
        } else {
            return viewModel.songResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: AlbumCellTableViewCell.reuseIdentifier, for: indexPath) as! AlbumCellTableViewCell
        }
        return tableView.dequeueReusableCell(withIdentifier: SongCell.reuseIdentifier, for: indexPath)
    }
}
