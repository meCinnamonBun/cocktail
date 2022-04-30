//
//  UIView + extensions.swift
//  Cocktails
//
//  Created by Andrew on 30.04.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
}
