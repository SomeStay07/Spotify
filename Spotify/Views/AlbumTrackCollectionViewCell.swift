//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Тимур Чеберда on 09.05.2021.
//

import UIKit

final class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
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
        
        trackNameLabel.frame = CGRect(
            x     : 10,
            y     : 0,
            width : contentView.width - 15,
            height: contentView.height / 2
        )
        
        artistNameLabel.frame = CGRect(
            x     : 10,
            y     : contentView.height / 2,
            width : contentView.width - 15,
            height: contentView.height / 2
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackNameLabel.text       = nil
        artistNameLabel.text      = nil
    }
    
    func embedViews() {
        [ trackNameLabel,
          artistNameLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupAppearance() {
        contentView.clipsToBounds   = true
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    func set(viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text  = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
}

