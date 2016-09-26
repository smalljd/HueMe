//
//  HueButton.swift
//  HueMe
//
//  Created by Jeff on 9/19/16.
//  Copyright © 2016 Jeff Small. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class HueButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
