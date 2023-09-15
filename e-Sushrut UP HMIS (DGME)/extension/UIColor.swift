//
//  File.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 05/06/22.
//

import Foundation
import UIKit
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
