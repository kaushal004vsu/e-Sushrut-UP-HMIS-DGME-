//
//  QMSBarCodeViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 12/06/22.
//

import UIKit

class QMSBarCodeViewController: UIViewController {

    @IBOutlet weak var lblHospName: UILabel!
    
    @IBOutlet weak var lblCrno: UILabel!
    
    @IBOutlet weak var lblDeptName: UILabel!
    
    
    @IBOutlet weak var lblPatName: UILabel!
    
    @IBOutlet weak var lblVisitDate: UILabel!
    
    
    @IBOutlet weak var lblQueueNo: UILabel!
    
    @IBOutlet weak var lblPrintedOn: UILabel!
    
    @IBOutlet weak var imgBarCode: UIImageView!
    var arrData=QMSListModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lblDeptName.text=arrData.deptunitname
        lblCrno.text=arrData.patcrno
        lblQueueNo.text=arrData.queueno
        lblPrintedOn.text=arrData.printedon
        lblHospName.text=arrData.hospname
        lblVisitDate.text=arrData.episodestartdate
        lblPatName.text=arrData.patname
        
        
        
        let barcode = UIImage(barcode: arrData.patcrno)
        imgBarCode.image=barcode
    }
    


}
