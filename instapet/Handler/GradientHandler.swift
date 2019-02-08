//
//  GradientHandler.swift
//  instapet
//
//  Created by Bar Molot on 08/02/2019.
//  Copyright © 2019 colman. All rights reserved.
//

import Foundation
import UIKit

class GradientHandler {
    static let shared = GradientHandler()
    fileprivate var gl: CAGradientLayer!
    
    func get(top: UInt, bottom: UInt) -> CAGradientLayer {
        gl = CAGradientLayer()
        gl.colors = [UIColor(hex: top).cgColor, UIColor(hex: bottom).cgColor]
        gl.locations = [0.0, 1.0]
        return gl
    }
}
