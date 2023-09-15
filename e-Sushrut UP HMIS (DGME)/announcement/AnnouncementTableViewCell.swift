//
//  AnnouncementTableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 09/05/23.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {
   
    var index: IndexPath?
    
    
    @IBOutlet weak var iv_new: UIImageView!
    @IBOutlet weak var tv_s_no: UILabel!
    @IBOutlet weak var tv_date: UILabel!
    
    @IBOutlet weak var tv_topic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
