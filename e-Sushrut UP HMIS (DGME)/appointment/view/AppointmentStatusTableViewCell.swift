//
//  AppointmentStatusTableViewCell.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 16/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class AppointmentStatusTableViewCell: UITableViewCell {

    
    @IBOutlet weak var txtAppointmentNumber: UILabel!
    
    @IBOutlet weak var txtAppointmentDate: UILabel!
    
    @IBOutlet weak var txtDeptUnit: UILabel!
    
    @IBOutlet weak var txtStatus: UILabel!
    
    @IBOutlet weak var btnView: UIStackView!
    
    
    @IBOutlet weak var btnCancel: UIButton!
    
    
    @IBOutlet weak var btnReschedule: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func btnCancelAppointment(_ sender: Any) {
    }
    
    
    @IBAction func btnRescheduleAppointment(_ sender: Any) {
    }
    
}
