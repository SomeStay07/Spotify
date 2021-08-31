//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Тимур Чеберда on 25.04.2021.
//

import UIKit

final class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel = UILabel()
        .decorated(with: .font(.systemFont(ofSize: 18, weight: .regular)))
        .decorated(with: .multiline())
    
    private let artistNameLabel = UILabel()
        .decorated(with: .font(.systemFont(ofSize: 15, weight: .thin)))
        .decorated(with: .multiline())
    
    // MARK: - Utils
    static let identifier = "RecommendedTrackCollectionViewCell"
    
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
                
        albumCoverImageView.frame = CGRect(
            x     : 5,
            y     : 2,
            width : contentView.height - 4,
            height: contentView.height - 4
        )
        
        trackNameLabel.frame = CGRect(
            x     : albumCoverImageView.right + 10,
            y     : 0,
            width : contentView.width - albumCoverImageView.right - 15,
            height: contentView.height / 2
        )
        
        artistNameLabel.frame = CGRect(
            x     : albumCoverImageView.right + 10,
            y     : contentView.height / 2,
            width : contentView.width - albumCoverImageView.right - 15,
            height: contentView.height / 2
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackNameLabel.text       = nil
        artistNameLabel.text      = nil
        albumCoverImageView.image = nil
    }

    // MARK: - Set data
    func set(viewModel: RecommendedTrackViewModel) {
        trackNameLabel.text  = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}

private extension RecommendedTrackCollectionViewCell {
    func embedViews() {
        [ albumCoverImageView,
          trackNameLabel,
          artistNameLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupAppearance() {
        contentView.clipsToBounds   = true
        contentView.backgroundColor = .secondarySystemBackground
    }
}
