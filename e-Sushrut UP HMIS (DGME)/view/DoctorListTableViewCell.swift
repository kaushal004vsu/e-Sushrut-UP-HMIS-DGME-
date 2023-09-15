//
//  DoctorListTableViewCell.swift
//  AIIMS Bhubaneswar Swasthya
//
//  Created by sudeep rai on 06/08/20.
//  Copyright © 2020 sudeep rai. All rights reserved.
//

import UIKit

class DoctorListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgDocuments: UIButton!
    
    @IBOutlet weak var lblPatientName: UILabel!
  
    @IBOutlet weak var lblCrno: UILabel!
    
    @IBOutlet weak var lblRaisedOn: UILabel!
    
    @IBOutlet weak var lblSlotDate: UILabel!
    
    @IBOutlet weak var lblRaisedBy: UILabel!
    
  
    @IBOutlet weak var lblConsName: UILabel!
    
    @IBOutlet weak var lblDeptUnitName: UILabel!
    
    
    @IBOutlet weak var lblViewMessages: UIButton!
    
    @IBOutlet weak var lblApprove: UIButton!
    
    @IBOutlet weak var lblRequestStatus: UIButton!
    
    @IBAction func btnViewMessages(_ sender: Any) {
    }
 
    
    
    @IBAction func btnDocuments(_ sender: Any) {
        
        
    }
    
    
    
    
    
    
    @IBAction func btnApprove(_ sender: Any) {
    }
    @IBAction func btnRequestStatus(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
