//
//  TitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Тимур Чеберда on 08.05.2021.
//

import UIKit

final class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 15, y: 0, width: width - 30, height: height)
    }
    
    func set(with title: String) {
        label.text = title
    }
}
