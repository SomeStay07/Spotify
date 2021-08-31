//
//  ViewDecorator+UIButton.swift
//  Spotify
//
//  Created by Тимур Чеберда on 31.08.2021.
//

import UIKit

extension ViewDecorator where View: UIButton {
    
    static func title(_ title: String) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.setTitle(title, for: .normal)
        }
    }
    
    static func titleColor(_ color: UIColor?, _ state: UIControl.State) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.setTitleColor(color, for: state)
        }
    }
    
    static func rounded(radius: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.clipsToBounds      = true
            $0.layer.cornerRadius = radius
        }
    }
    
    static func font(_ font: UIFont) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.titleLabel?.font = font
        }
    }
    
    static func multiline() -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.titleLabel?.numberOfLines = 0
        }
    }
    
    static func textAlignment(_ alignment: NSTextAlignment) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.titleLabel?.textAlignment = alignment
        }
    }
    
    static func backgroundColor(_ color: UIColor?) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.backgroundColor = color
        }
    }
}
