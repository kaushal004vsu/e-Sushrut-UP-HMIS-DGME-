//
//  ProfileTableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 20/07/22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
