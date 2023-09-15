//
//  OPDLiteTableViewCell.swift
//  SAIL Rourkela
//
//  Created by HICDAC on 24/05/23.
//

import UIKit

class OPDLiteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var billNo_lbl: UILabel!
    @IBOutlet weak var transaction_date_lbl: UILabel!
    @IBOutlet weak var amount_lbl: UILabel!

    @IBOutlet weak var hosp_name_lbl: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
