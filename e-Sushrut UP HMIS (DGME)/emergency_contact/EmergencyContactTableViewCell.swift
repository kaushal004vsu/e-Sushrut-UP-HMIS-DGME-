//
//  EmergencyContactTableViewCell.swift
//  Railways-HMIS
//
//  Created by HICDAC on 21/12/22.
//

import Foundation
import UIKit
protocol EmeregencyContactClick{
    func onClickCell(index: Int,clickIndex: Int)
}
class EmeregencyContactTableViewCell: UITableViewCell {
var cellDelegate: EmeregencyContactClick?
var index: IndexPath?

    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var hospital_name: UILabel!
    
    @IBOutlet weak var phone_iv: UIImageView!
    @IBOutlet weak var phone_no: UIButton!
    

    @IBOutlet weak var email: UIButton!
    
    @IBOutlet weak var email_iv: UIImageView!


override func awakeFromNib() {
    super.awakeFromNib()
}

override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
}

@IBAction func down_load_ref(_ sender: Any) {
    cellDelegate?.onClickCell(index: (index?.row)!,clickIndex: 0)

}

}
