//
//  UIButton.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 09/05/23.
//

import Foundation
import UIKit
extension UIButton {
  func underlineText() {
    guard let title = title(for: .normal) else { return }

    let titleString = NSMutableAttributedString(string: title)
    titleString.addAttribute(
      .underlineStyle,
      value: NSUnderlineStyle.single.rawValue,
      range: NSRange(location: 0, length: title.count)
    )
    setAttributedTitle(titleString, for: .normal)
  }
}
