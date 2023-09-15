//
//  PrescriptionListTableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 08/06/22.
//

import Foundation

import UIKit

class PrescriptionListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDeptName: UILabel!
    
    @IBOutlet weak var lblVisitDate: UILabel!
    
    @IBOutlet weak var lblVisitNo: UILabel!
    
    @IBOutlet weak var lblHospName: UILabel!
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
