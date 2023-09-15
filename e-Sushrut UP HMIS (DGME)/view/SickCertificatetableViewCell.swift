//
//  SickCertificatetableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 05/08/22.
//

import UIKit

class SickCertificatetableViewCell: UITableViewCell {
        
    @IBOutlet weak var lblTestNAme: UILabel!
    @IBOutlet weak var category_lbl: UILabel!
    @IBOutlet weak var lblReqNumber: UILabel!
    @IBOutlet weak var lblReportDate: UILabel!
    @IBOutlet weak var department_lbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
}

  
