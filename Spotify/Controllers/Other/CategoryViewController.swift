//
//  CategoryViewController.swift
//  Spotify
//
//  Created by Тимур Чеберда on 20.06.2021.
//

import UIKit

final class CategoryViewController: UIViewController {
        
    // MARK: - Views
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ in
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(250)
            ),
            subitem: item,
            count: 2
        )
        
        return NSCollectionLayoutSection(group: group)
    }))
    
    // MARK: - Data
    private let category: Category
    private var playlists = [Playlist]()

    // MARK: - Init
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupAppearance()
        setupBehaviour()
        obtainCategoriyPlaylist()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
}

private extension CategoryViewController {
    
    // MARK: - Embed views
    func embedViews() {
        view.addSubview(collectionView)
    }
    
    // MARK: - Setup appearance
    func setupAppearance() {
        title = category.name
        view.backgroundColor = .systemBackground
        
        collectionView.backgroundColor = .systemBackground
    }
    
    // MARK: - Setup behaviour
    func setupBehaviour() {
        collectionView.register(
            FeaturedPlaylistCollectionViewCell.self,
            forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier
        )
        
        collectionView.delegate   = self
        collectionView.dataSource = self
    }
    
    // MARK: - Obtain data for album
    func obtainCategoriyPlaylist() {
        APICaller.shared.getCategoriyPlaylist(category: category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlist):
                    self?.playlists = playlist
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PlaylistViewController(playlist: playlists[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return playlists.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier,
            for: indexPath
        ) as? FeaturedPlaylistCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let playlist = playlists[indexPath.row]
        
        cell.set(
            viewModel: FeaturedPlaylistViewModel(
                name: playlist.name,
                artworkURL: URL(string: playlist.images.first?.url ?? ""),
                creatorName: playlist.owner.displayName
            )
        )
        
        return cell
    }
}
