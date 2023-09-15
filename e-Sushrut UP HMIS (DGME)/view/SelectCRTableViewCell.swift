//
//  TSelectCRableViewCell.swift
//  AIIMS Gorakhpur Swasthya
//
//  Created by sudeep rai on 18/11/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class SelectCRTableViewCell: UITableViewCell {
    @IBOutlet weak var lblPatientName: UILabel!
    
    @IBOutlet weak var lblPatientCrno: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
