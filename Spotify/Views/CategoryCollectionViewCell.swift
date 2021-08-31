//
//  CategoryCollectionViewCell.swift
//  Spotify
//
//  Created by Тимур Чеберда on 09.05.2021.
//

import UIKit
import SDWebImage

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        )
        
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemGreen,
        .systemGray,
        .systemPurple,
        .systemIndigo,
        .systemBlue,
        .systemYellow,
        .systemOrange,
        .systemTeal
    ]
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius  = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor     = colors.randomElement()
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: 10,
            y: contentView.height / 2,
            width: contentView.width - 20,
            height: contentView.height / 2
        )
        
        imageView.frame = CGRect(
            x: contentView.width / 2,
            y: 10,
            width: contentView.width / 2,
            height: contentView.height / 2
        )
    }
    
    func set(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(
            with: viewModel.artworkURL,
            completed: nil
        )
    }
}
