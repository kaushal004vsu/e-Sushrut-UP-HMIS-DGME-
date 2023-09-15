//
//  ReferralTableViewCell.swift
//  Railways-HMIS
//
//  Created by HICDAC on 21/12/22.
//

import Foundation
import UIKit
protocol ReferralClick{
    func onClickCell(index: Int,clickIndex: Int)
}

class ReferralTableViewCell: UITableViewCell {
    
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    @IBOutlet weak var MyImage: UIImageView!
    
    @IBOutlet weak var hosp_name_lbl: UILabel!
    @IBOutlet weak var from_dept_lbl: UILabel!
    @IBOutlet weak var to_dept_lbl: UILabel!
    @IBOutlet weak var status_lbl: UILabel!
    @IBOutlet weak var refer_date_lbl: UILabel!
    
    @IBOutlet weak var dowload_referal_btn: UIButton!
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func down_load_ref(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!,clickIndex: 0)

    }
 
}
