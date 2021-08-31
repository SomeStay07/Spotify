//
//  ViewDecorator+UIStackView.swift
//  Spotify
//
//  Created by Тимур Чеберда on 31.08.2021.
//

import UIKit

extension ViewDecorator where View: UIStackView {
    
    static func vertical(_ spacing: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.axis         = .vertical
            $0.distribution = .fill
            $0.spacing      = spacing
        }
    }
    
    static func horizontal(_ spacing: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.axis         = .horizontal
            $0.distribution = .fill
            $0.spacing      = spacing
        }
    }
    
    static func alignment(_ alignment: UIStackView.Alignment) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.alignment = alignment
        }
    }
    
    static func distribution(_ distribution: UIStackView.Distribution) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.distribution = distribution
        }
    }
}
