//
//  ViewDecorator+UIView.swift
//  Spotify
//
//  Created by Тимур Чеберда on 31.08.2021.
//

import UIKit

extension ViewDecorator where View: UIView {
    
    static func rounded(radius: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.clipsToBounds      = true
            $0.layer.cornerRadius = radius
        }
    }
    
    static func borderColor(_ color: UIColor) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layer.borderColor = color.cgColor
        }
    }
    
    static func borderWidth(_ width: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layer.borderWidth = width
        }
    }
    
    static func filled(_ color: UIColor) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.backgroundColor = color
        }
    }
}
