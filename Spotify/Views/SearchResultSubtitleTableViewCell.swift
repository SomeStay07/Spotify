//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Тимур Чеберда on 04.07.2021.
//

import UIKit
import SDWebImage

final class SearchResultSubtitleTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private let label = UILabel()
        .decorated(with: .numberOfLines(1))
    
    private let subtitleLabel = UILabel()
        .decorated(with: .textColor(.secondaryLabel))
        .decorated(with: .numberOfLines(1))
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Utils
    static let identifier = "SearchResultSubtitleTableViewCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        embedViews()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height
        let labelHeight = imageSize / 2
        
        iconImageView.layer.cornerRadius = imageSize / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.frame = CGRect(
            x: 10,
            y: 5,
            width: imageSize,
            height: imageSize
        )
        
        label.frame = CGRect(
            x: iconImageView.right + 10,
            y: 0,
            width: contentView.width - iconImageView.right - 15,
            height: labelHeight
        )
        
        subtitleLabel.frame = CGRect(
            x: iconImageView.right + 10,
            y: label.bottom,
            width: contentView.width - iconImageView.right - 15,
            height: labelHeight
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        subtitleLabel.text  = nil
        label.text          = nil
    }
}

private extension SearchResultSubtitleTableViewCell {
    
    // MARK: - Embed views
    func embedViews() {
        [ label,
          subtitleLabel,
          iconImageView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupAppearance() {
        contentView.clipsToBounds = true
        
        accessoryType = .disclosureIndicator
    }
}

extension SearchResultSubtitleTableViewCell {
    struct ViewModel {
        let title   : String
        let subtitle: String
        let imageURL: URL?
    }
    
    func set(viewModel: ViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
}

