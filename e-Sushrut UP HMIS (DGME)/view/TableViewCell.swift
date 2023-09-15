//
//  TableViewCell.swift
//  swiftyjson
//
//  Created by Yogesh Patel on 16/04/18.
//  Copyright © 2018 Yogesh Patel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelTariffCharge: UILabel!
    @IBOutlet weak var labelTariffName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
