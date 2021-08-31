//
//  SearchResultsViewController.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

import UIKit

struct SearchSection {
    let title  : String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResults(_ result: SearchResult)
}

final class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Connections
    weak var delegate: SearchResultsViewControllerDelegate?
    
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(
            SearchResultTableViewCell.self,
            forCellReuseIdentifier: SearchResultTableViewCell.identifier
        )
        
        tableView.register(
            SearchResultSubtitleTableViewCell.self,
            forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier
        )
                
        tableView.isHidden = true
        return tableView
    }()
    
    // MARK: Data
    private var sections: [SearchSection] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.addSubview(tableView)
        
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    // MARK: - Connections
    func update(with results: [SearchResult]) {
        let artists = results.filter {
            switch $0 {
            case .artist: return true
            default: return false
            }
        }
        
        let albums = results.filter {
            switch $0 {
            case .album: return true
            default: return false
            }
        }
        
        let tracks = results.filter {
            switch $0 {
            case .track: return true
            default: return false
            }
        }
        
        let playlist = results.filter {
            switch $0 {
            case .playlist: return true
            default: return false
            }
        }
        
        sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Artists", results : artists),
            SearchSection(title: "Playlists", results: playlist),
            SearchSection(title: "Albums", results: albums)
        ]
        
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].results.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let results = sections[indexPath.section].results[indexPath.row]

        switch results {
        case .artist(let artist):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultTableViewCell.identifier,
                for: indexPath
            ) as? SearchResultTableViewCell else {
                return UITableViewCell()
            }
            
            cell.set(
                viewModel: SearchResultTableViewCell.ViewModel(
                    title: artist.name,
                    imageURL: URL(string: artist.images?.first?.url ?? "")
                )
            )
            
            return cell
        case .album(let album):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                for: indexPath
            ) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            
            cell.set(
                viewModel: SearchResultSubtitleTableViewCell.ViewModel(
                    title: album.name,
                    subtitle: album.artists.first?.name ?? "",
                    imageURL: URL(string: album.images.first?.url ?? "")
                )
            )
            
            return cell
        case .track(let track):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                for: indexPath
            ) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            
            cell.set(
                viewModel: SearchResultSubtitleTableViewCell.ViewModel(
                    title: track.name,
                    subtitle: track.artists.first?.name ?? "-",
                    imageURL: URL(string: track.album?.images.first?.url ?? "")
                )
            )
            
            return cell
        case .playlist(let playlist):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                for: indexPath
            ) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            
            cell.set(
                viewModel: SearchResultSubtitleTableViewCell.ViewModel(
                    title: playlist.name,
                    subtitle: playlist.owner.displayName,
                    imageURL: URL(string: playlist.images.first?.url ?? "")
                )
            )
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let results = sections[indexPath.section].results[indexPath.row]

        delegate?.didTapResults(results)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}
