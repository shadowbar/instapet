//
//  UIColor+Extensions.swift
//  instapet
//
//  Created by Bar Molot on 08/02/2019.
//  Copyright © 2019 colman. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(hex: UInt) {
        self.init(
            r: CGFloat((hex & 0xFF0000) >> 16),
            g: CGFloat((hex & 0x00FF00) >> 8),
            b: CGFloat(hex & 0x0000FF)
        )
    }
}
