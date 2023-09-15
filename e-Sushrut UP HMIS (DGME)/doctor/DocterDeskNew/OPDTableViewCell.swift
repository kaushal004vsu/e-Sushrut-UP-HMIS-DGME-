//
//  DDTableViewCell.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 09/07/23.
//

import UIKit

class OPDTableViewCell: UITableViewCell {

    @IBOutlet weak var que_no_lbl: UILabel!
    @IBOutlet weak var que_no_title: UILabel!
    
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var age_gender_mob_lbl: UILabel!
      
    @IBOutlet weak var cr_lbl: UILabel!
    
    @IBOutlet weak var status_lbl: UILabel!
    
    @IBOutlet weak var re_print_btn: UIButton!
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }

    }

