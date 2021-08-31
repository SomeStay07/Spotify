//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Тимур Чеберда on 25.04.2021.
//

import UIKit

final class AlbumViewController: UIViewController {
    
    // MARK: - Views
    private let collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ -> NSCollectionLayoutSection? in
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(
                    top     : 1,
                    leading : 2,
                    bottom  : 1,
                    trailing: 2
                )
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(60)
                    ),
                    subitem: item,
                    count: 1
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [ NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.6)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                ]
                return section
            }
        )
    )
    
    // MARK: - Data
    private var viewModels = [AlbumCollectionViewCellViewModel]()
    private let album: Album
    
    // MARK: - Init
    init(album: Album) {
        self.album = album
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
        obtainAlbumDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

private extension AlbumViewController {
    
    // MARK: - Embed views
    func embedViews() {
        view.addSubview(collectionView)
    }
    
    // MARK: - Setup appearance
    func setupAppearance() {
        title = album.name
        view.backgroundColor = .systemBackground
        
        collectionView.backgroundColor = .systemBackground
    }
    
    // MARK: - Setup behaviour
    func setupBehaviour() {
        collectionView.register(
            AlbumTrackCollectionViewCell.self,
            forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier
        )
        
        collectionView.register(
            PlaylistHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier       : PlaylistHeaderCollectionReusableView.identifier
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Obtain data for album
    func obtainAlbumDetail() {
        APICaller.shared.getAlbumDetails(for: album) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.viewModels = model.tracks.items.compactMap {
                        .init(
                            name: $0.name,
                            artistName: $0.artists.first?.name ?? ""
                        )
                    }
                    
                    self?.collectionView.reloadData()
                case .failure(let error):
                    break
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AlbumViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumTrackCollectionViewCell.identifier,
            for: indexPath
        ) as? AlbumTrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.set(viewModel: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as? PlaylistHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let plmv  = PlaylistHeaderViewModel(
            name       : album.name,
            ownerName  : album.artists.first?.name,
            description: "Release Date: \(String.formattedDate(string: album.releaseDate))",
            artworkURL : URL(string: album.images.first?.url ?? "")
        )
        
        header.set(with: plmv)
        header.delegate = self
        
        return header
    }
}

extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension AlbumViewController: PlaylistHeaderCollectionReusableViewDelegate {
    
    func playlistHeaderCollectionReusableViewDidTapPlayAll(
        _ header: PlaylistHeaderCollectionReusableView
    ) {
        // FIXME: - Add behaviour
        print("playing all")
    }
}
