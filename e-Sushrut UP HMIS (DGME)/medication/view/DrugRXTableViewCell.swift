//
//  DrugRXTableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 01/05/23.
//

import UIKit


class DrugRXTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_drug: UILabel!
    @IBOutlet weak var lbl_adviced_date: UILabel!
    @IBOutlet weak var lbl_adviced_qty: UILabel!
    @IBOutlet weak var lbl_issued_qty: UILabel!
    
    //@IBOutlet weak var drug_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

