//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Тимур Чеберда on 25.04.2021.
//

import UIKit
import SDWebImage

final class NewReleaseCollectionViewCell: UICollectionViewCell {

    // MARK: - Views
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel = UILabel()
        .decorated(with: .font(.systemFont(ofSize: 20, weight: .semibold)))
        .decorated(with: .multiline())

    private let numbersOfTracksLabel = UILabel()
        .decorated(with: .font(.systemFont(ofSize: 18, weight: .light)))
        .decorated(with: .multiline())
    
    
    private let artistNameLabel = UILabel()
        .decorated(with: .font(.systemFont(ofSize: 18, weight: .thin)))
        .decorated(with: .multiline())
    
    // MARK: - Utils
    static let identifier = "NewReleaseCollectionViewCell"
    
    // MARK: - Init
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
        
        let imageSize = contentView.height - 10

        let albumNameSize = albumNameLabel.sizeThatFits(
            CGSize(
                width: contentView.width - imageSize - 10,
                height: contentView.height - 10
            )
        )
        
        artistNameLabel.sizeToFit()
        numbersOfTracksLabel.sizeToFit()
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        let albumLabelHeight = min(60, albumNameSize.height)
        
        albumNameLabel.frame = CGRect(
            x     : albumCoverImageView.right + 10,
            y     : 5,
            width : albumNameSize.width,
            height: albumLabelHeight
        )
        
        artistNameLabel.frame = CGRect(
            x     : albumCoverImageView.right + 10,
            y     : albumNameLabel.bottom,
            width : contentView.width - albumCoverImageView.right - 10,
            height: 44
        )
        
        numbersOfTracksLabel.frame = CGRect(
            x     : albumCoverImageView.right + 10,
            y     : contentView.bottom - 44,
            width : numbersOfTracksLabel.width,
            height: 44
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        albumNameLabel.text       = nil
        artistNameLabel.text      = nil
        numbersOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    // MARK: - Set data
    func set(viewModel: NewReleasesViewModel) {
        albumNameLabel.text       = viewModel.name
        artistNameLabel.text      = viewModel.artistName
        numbersOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}

private extension NewReleaseCollectionViewCell {
    
    // MARK: - Embed views
    func embedViews() {
        [ albumCoverImageView,
          albumNameLabel,
          artistNameLabel,
          numbersOfTracksLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup appearance
    func setupAppearance() {
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.clipsToBounds = true
    }
}
