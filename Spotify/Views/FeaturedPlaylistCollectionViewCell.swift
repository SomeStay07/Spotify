//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Тимур Чеберда on 25.04.2021.
//

import UIKit

final class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel = UILabel()
        .decorated(with: .font(.systemFont(ofSize: 18, weight: .regular)))
        .decorated(with: .alignment(.center))
        .decorated(with: .multiline())
    
    private let creatorNameLabel = UILabel()
        .decorated(with: .font(.systemFont(ofSize: 15, weight: .thin)))
        .decorated(with: .alignment(.center))
        .decorated(with: .multiline())

    // MARK: - Utils
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height - 70
        
        creatorNameLabel.frame = CGRect(
            x     : 3,
            y     : contentView.height - 30,
            width : contentView.width - 6,
            height: 44
        )
        
        playlistNameLabel.frame = CGRect(
            x     : 3,
            y     : contentView.height - 60,
            width : contentView.width - 6,
            height: 30
        )
        
        playlistCoverImageView.frame = CGRect(
            x: (contentView.width - imageSize) / 2,
            y: 3,
            width: imageSize,
            height: imageSize
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playlistNameLabel.text       = nil
        creatorNameLabel.text        = nil
        playlistCoverImageView.image = nil
    }
    
    // MARK: - Set data
    func set(viewModel: FeaturedPlaylistViewModel) {
        playlistNameLabel.text    = viewModel.name
        creatorNameLabel.text     = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}

private extension FeaturedPlaylistCollectionViewCell {
    
    // MARK: - Embed views
    func embedViews() {
        [ playlistCoverImageView,
          playlistNameLabel,
          creatorNameLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup appearance
    func setupAppearance() {
        contentView.clipsToBounds   = true
    }
}
