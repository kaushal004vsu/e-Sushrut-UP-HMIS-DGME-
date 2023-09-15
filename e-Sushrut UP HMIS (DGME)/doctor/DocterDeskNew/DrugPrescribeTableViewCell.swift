//
//  DrugPrescribeTableViewCell.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 31/07/23.
//

import UIKit

class DrugPrescribeTableViewCell: UITableViewCell {

    @IBOutlet weak var drugNameLbl: UILabel!
    
    @IBOutlet weak var dayAfternoonEveningNightLbl: UILabel!
    
    @IBOutlet weak var totalQtyLbl: UILabel!
    
    @IBOutlet weak var special_instruction_btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
