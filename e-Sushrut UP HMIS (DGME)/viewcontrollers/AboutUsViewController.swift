//
//  AboutUsViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 22/07/22.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var content_tv: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.text = AppConstant.support_email
        
        content_tv.text = "The Hospital Management Information System (HMIS) in \(Bundle.main.displayName!) has been developed by CDAC NOIDA The objective of the HMIS is to provide a single window of clearance of hospital administration activity such as clinical, diagnostics, pharmacy, examinations, industrial health etc. The primary objectives of envisaged solution are:\n\n1. Effectively manage all the health facilities & its resources\n\n2. Monitor performance of hospitals across the administrative channel\n\n3. Impart quality health care services to its beneficiaries\n\n4. Improve the patient turn-around time\n\n5. Generate and maintain EMR (electronic medical records) of all patients\n\nThis mobile app provides various facilities for patientstopatientsTo access their health data across various hospitals.Patients can login using their registered mobile number to access services. \n\nThis app aims at providing timely and effective medical treatment to Patients.This mobile app is a pilot effort in this direction to streamline healthcare services delivery to its users.\n\nThis app aims at providing timely and effective medical treatment to Patients.This mobile app is a pilot effort in this direction to streamline healthcare services delivery to its users."
    }
    
    
}
