//
//  PharmacyQSlipTableViewCell.swift
//  Railways-HMIS
//
//  Created by HICDAC on 10/01/23.
//

import UIKit

class PharmacyQSlipTableViewCell: UITableViewCell {

    @IBOutlet weak var que_no_lbl: UILabel!
    @IBOutlet weak var que_no_title: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var lblDeptName: UILabel!
        @IBOutlet weak var lblHospitalName: UILabel!

    @IBOutlet weak var liveQueueStatusBtn: UIButton!
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }

    }

