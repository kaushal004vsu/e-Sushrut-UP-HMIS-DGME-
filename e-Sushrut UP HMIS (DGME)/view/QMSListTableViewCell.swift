//
//  QMSListTableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 12/06/22.
//

import UIKit

class QMSListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDeptName: UILabel!
    
    @IBOutlet weak var lblVisitDate: UILabel!
    
   
    @IBOutlet weak var lblVisitNo: UILabel!
    
    
    @IBOutlet weak var lblHospitalName: UILabel!

    @IBOutlet weak var lblCrno: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
