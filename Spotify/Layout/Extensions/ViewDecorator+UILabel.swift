//
//  ViewDecorator+UILabel.swift
//  Spotify
//
//  Created by Тимур Чеберда on 31.08.2021.
//

import UIKit

extension ViewDecorator where View: UILabel {
    
    static func textColor(_ color: UIColor?) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.textColor = color
        }
    }
    
    static func alignment(_ textAlignment: NSTextAlignment) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.textAlignment = textAlignment
        }
    }
    
    static func font(_ font: UIFont!) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.font = font
        }
    }
    
    static func numberOfLines(_ numberOfLines: Int) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.numberOfLines = numberOfLines
        }
    }
    
    static func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.lineBreakMode = lineBreakMode
        }
    }
    
    static func multiline() -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.numberOfLines = 0
        }
    }
    
    static func filled(_ backgroundColor: UIColor?) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.backgroundColor = backgroundColor
        }
    }
    
    static func text(_ text: String?) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.text = text
        }
    }
    
    static func sizeToFit() -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.sizeToFit()
        }
    }
    
    static func isHidden(_ isHidden: Bool) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.isHidden = isHidden
        }
    }
}
