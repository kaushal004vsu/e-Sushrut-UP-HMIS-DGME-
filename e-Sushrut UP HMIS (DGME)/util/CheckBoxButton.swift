//
//  CheckBoxButton.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 18/08/22.
//

import Foundation
import UIKit
class CheckBoxButton: UIButton {

override func awakeFromNib() {
    self.setImage(UIImage(named:"selected"), for: .selected)
    self.setImage(UIImage(named:"rectangle"), for: .normal)
    self.addTarget(self, action: #selector(CheckBoxButton.buttonClicked(_:)), for: .touchUpInside)
}

    @objc func buttonClicked(_ sender: UIButton) {
    self.isSelected = !self.isSelected
 }

}
