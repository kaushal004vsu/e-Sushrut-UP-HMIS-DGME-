//
//  UIApplication.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 09/11/22.
//

import Foundation
import UIKit
extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    static var version: String {
        return "\(release)"
    }
}
