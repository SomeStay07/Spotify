//
//  ViewDecorator.swift
//  Spotify
//
//  Created by Тимур Чеберда on 31.08.2021.
//

import UIKit

public struct ViewDecorator<View: UIView> {
    
    let decoration: (View) -> Void
    
    func decorate(_ view: View) {
        decoration(view)
    }
}
