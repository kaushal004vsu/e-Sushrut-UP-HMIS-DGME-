//
//  ReportListableViewCell.swift
//  PdfExample
//
//  Created by sudeep rai on 25/04/19.
//  Copyright © 2019 sudeep rai. All rights reserved.
//

import UIKit

class ReportListableViewCell: UITableViewCell {

    @IBOutlet weak var lblTestNAme: UILabel!
    
    @IBOutlet weak var lblReqNumber: UILabel!
    
    @IBOutlet weak var lblReportDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
