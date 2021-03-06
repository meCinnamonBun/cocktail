//
//  BadgedBarButtonItem.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import UIKit

class BadgedBarButtonItem: UIBarButtonItem {
    private var badgeLayer: CAShapeLayer?
}

extension BadgedBarButtonItem {
    func addBadge(withOffset offset: CGPoint = CGPoint.zero,
                  andColor color: UIColor = .orange) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        badgeLayer?.removeFromSuperlayer()
        
        let badge: CAShapeLayer = .init()
        let diameter: CGFloat = .badgeDiameter
        
        badge.path = UIBezierPath(roundedRect: .init(x: view.frame.width - (diameter + offset.x) - diameter / 2,
                                                     y: (diameter + offset.y),
                                                     width: diameter,
                                                     height: diameter), cornerRadius: diameter / 2).cgPath
        badge.fillColor = color.cgColor
        view.layer.addSublayer(badge)
        
        badgeLayer = badge
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}

// MARK: - Constants

private extension CGFloat {
    static let badgeDiameter: CGFloat = 8
}
