//
//  NDHMIdSummaryViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 09/09/22.
//

import UIKit

class NDHMIdSummaryViewController: UIViewController {

    var ndhmID = ""
    var ndhmPatHealthId = ""
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAbhaAddress: UILabel!
    @IBOutlet weak var lblAbhaNumber: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        
        lblAbhaAddress.text = ndhmID
        lblAbhaNumber.text = ndhmPatHealthId
        
        lblName.text = obj!.firstName
        lblDob.text = obj!.dob
        lblGender.text = obj!.gender
        lblMobile.text = obj!.mobileNo
        
    }

    @IBAction func homeBtnAction(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    }
}
