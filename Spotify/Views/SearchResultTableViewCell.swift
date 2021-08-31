//
//  SearchResultTableViewCell.swift
//  Spotify
//
//  Created by Тимур Чеберда on 04.07.2021.
//

import UIKit
import SDWebImage

final class SearchResultTableViewCell: UITableViewCell {

    // MARK: - Views
    private let label = UILabel()
        .decorated(with: .numberOfLines(1))
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Utils
    static let identifier = "SearchResultTableViewCell"
    
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
            height: imageSize
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        label.text          = nil
    }
}

private extension SearchResultTableViewCell {
    
    // MARK: - Embed views
    func embedViews() {
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
    }
    
    // MARK: - Setup appearance
    func setupAppearance() {
        contentView.clipsToBounds = true
        
        accessoryType = .disclosureIndicator
    }
}

// MARK: - ViewModel
extension SearchResultTableViewCell {
    struct ViewModel {
        let title   : String
        let imageURL: URL?
    }
    
    func set(viewModel: ViewModel) {
        label.text = viewModel.title
        iconImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
}
