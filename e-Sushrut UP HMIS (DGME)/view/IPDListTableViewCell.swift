//
//  LPDListTableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 07/07/22.
//

import UIKit

protocol TableViewNew{
    func onClickCell(index: Int,clickIndex: Int)
}

class IPDListTableViewCell: UITableViewCell {
    
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    @IBOutlet weak var MyImage: UIImageView!
    
    @IBOutlet weak var tv_dept_name: UILabel!
    @IBOutlet weak var tv_unit_name: UILabel!
    
    @IBOutlet weak var tv_room_name: UILabel!
    
    @IBOutlet weak var tv_admission_no: UILabel!
    @IBOutlet weak var tv_hospital_name: UILabel!
    @IBOutlet weak var tv_download_adm_slip: UIButton!
    
    @IBOutlet weak var tv_download_discharge_slip: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnDownloadAdmlip(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!,clickIndex: 0)
    }
    
    
   
    @IBAction func btnDownloadDischSummary(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!,clickIndex: 1)
    }
}
