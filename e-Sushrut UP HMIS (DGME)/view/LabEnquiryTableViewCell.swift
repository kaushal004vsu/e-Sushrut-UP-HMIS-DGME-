//
//  LabEnquiryTableViewCell.swift
//  swiftyjson
//
//  Created by sudeep rai on 13/03/19.
//  Copyright © 2019 Yogesh Patel. All rights reserved.
//

import UIKit

class LabEnquiryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTestName: UILabel!
    
    @IBOutlet weak var lblLabName: UILabel!
    
    @IBOutlet weak var lblTestPrice: UILabel!
    
    
   
    @IBOutlet weak var isApptMandatory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
