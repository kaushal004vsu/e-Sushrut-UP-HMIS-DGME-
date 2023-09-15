//
//  DrugStandurdTableViewCell.swift
//  IGHCare
//
//  Created by HICDAC on 22/08/23.
//

import UIKit

class DrugStandurdTableViewCell: UITableViewCell {

    @IBOutlet weak var short_type_btn: UIButton!
    @IBOutlet weak var label_lbl: UILabel!
    @IBOutlet weak var qty_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
