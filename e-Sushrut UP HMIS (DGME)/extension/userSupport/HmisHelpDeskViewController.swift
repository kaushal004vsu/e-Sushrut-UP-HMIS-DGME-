//
//  HmisHelpDeskViewController.swift
//  Railways-HMIS
//
//  Created by HICDAC on 12/01/23.
//

import UIKit

class HmisHelpDeskViewController: UIViewController {

    @IBOutlet weak var heading_stk: UILabel!
    @IBOutlet weak var hmis_help_desk_stk: UIStackView!
    @IBOutlet weak var user_manual: UIStackView!
    
    @IBOutlet weak var doctor_hindi_stk: UIStackView!
    @IBOutlet weak var doctor_eng_stk: UIStackView!
    @IBOutlet weak var patient_hindi_stk: UIStackView!
    @IBOutlet weak var patient_eng_stk: UIStackView!
    
    @IBOutlet weak var close: UIImageView!
    
    @IBOutlet weak var mobileLbl1: UILabel!
    @IBOutlet weak var mobileLbl2: UILabel!
    @IBOutlet weak var mobileLbl3: UILabel!
    @IBOutlet weak var mobileLbl4: UILabel!
    @IBOutlet weak var mobileLbl5: UILabel!
    @IBOutlet weak var mobileLbl6: UILabel!
    
    @IBOutlet weak var dismissBtn: UIButton!
    
    var from: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showInternetAlert()
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        close.isUserInteractionEnabled = true
        close.addGestureRecognizer(tapGesture1)
        if(from == 1){
            heading_stk.text = "HMIS Help Desk"
            //by kk hmis_help_desk_stk.isHidden = false
            hmis_help_desk_stk.isHidden = true
            user_manual.isHidden = true
            hmisHelpDeskDetails()
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapLabel1(tap:)))
            self.mobileLbl1.addGestureRecognizer(tap1)
            self.mobileLbl1.isUserInteractionEnabled = true
            
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapLabel2(tap:)))
            self.mobileLbl2.addGestureRecognizer(tap2)
            self.mobileLbl2.isUserInteractionEnabled = true
            
            let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapLabel3(tap:)))
            self.mobileLbl3.addGestureRecognizer(tap3)
            self.mobileLbl3.isUserInteractionEnabled = true
            
            let tap4 = UITapGestureRecognizer(target: self, action: #selector(tapLabel4(tap:)))
            self.mobileLbl4.addGestureRecognizer(tap4)
            self.mobileLbl4.isUserInteractionEnabled = true
            
            let tap5 = UITapGestureRecognizer(target: self, action: #selector(tapLabel5(tap:)))
            self.mobileLbl5.addGestureRecognizer(tap5)
            self.mobileLbl5.isUserInteractionEnabled = true
            
            let tap6 = UITapGestureRecognizer(target: self, action: #selector(tapLabel6(tap:)))
            self.mobileLbl6.addGestureRecognizer(tap6)
            self.mobileLbl6.isUserInteractionEnabled = true
        }else if(from == 2){
            heading_stk.text = "Help Documents"
            hmis_help_desk_stk.isHidden = true
            user_manual.isHidden = false
            //User Manual tap
            let docHindiTap = UITapGestureRecognizer(target: self, action: #selector(doctorHindi(tap:)))
            self.doctor_hindi_stk.addGestureRecognizer(docHindiTap)
            self.doctor_hindi_stk.isUserInteractionEnabled = true
            
            let docEngTap = UITapGestureRecognizer(target: self, action: #selector(doctorEng(tap:)))
            self.doctor_eng_stk.addGestureRecognizer(docEngTap)
            self.doctor_eng_stk.isUserInteractionEnabled = true
            
            let patientHindiTap = UITapGestureRecognizer(target: self, action: #selector(patientHindi(tap:)))
            self.patient_hindi_stk.addGestureRecognizer(patientHindiTap)
            self.patient_hindi_stk.isUserInteractionEnabled = true
            
            let patientEngTap = UITapGestureRecognizer(target: self, action: #selector(patientEng(tap:)))
            self.patient_eng_stk.addGestureRecognizer(patientEngTap)
            self.patient_eng_stk.isUserInteractionEnabled = true
        }
       
        
       
    }
    //HMIS Help Desk tap
    @objc func tapLabel1(tap: UITapGestureRecognizer) {
        guard let url = URL(string: "telprompt://\(mobileLbl1.text!)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @objc func tapLabel2(tap: UITapGestureRecognizer) {
        guard let url = URL(string: "telprompt://\(mobileLbl2.text!)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @objc func tapLabel3(tap: UITapGestureRecognizer) {
        guard let url = URL(string: "telprompt://\(mobileLbl3.text!)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @objc func tapLabel4(tap: UITapGestureRecognizer) {
        guard let url = URL(string: "telprompt://\(mobileLbl4.text!)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @objc func tapLabel5(tap: UITapGestureRecognizer) {
        guard let url = URL(string: "telprompt://\(mobileLbl5.text!)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @objc func tapLabel6(tap: UITapGestureRecognizer) {
        guard let url = URL(string: "telprompt://\(mobileLbl6.text!)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    var urlStr = ""
    //User Manual tap
    @objc func doctorHindi(tap: UITapGestureRecognizer) {
       // urlStr="https://drive.google.com/file/d/1MN92-7Elq28IJ1nYC0ewkUfHMuOnqIL0/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func doctorEng(tap: UITapGestureRecognizer) {
        //urlStr="https://drive.google.com/file/d/1N22KS2qCANp4ToTmsLyiTC4nb4_yQHoF/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func patientHindi(tap: UITapGestureRecognizer) {
      //  urlStr="https://drive.google.com/file/d/1ACD4B4SLZHXR3TOxEA5pwNXAunI92bLI/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func patientEng(tap: UITapGestureRecognizer) {
       // urlStr="https://drive.google.com/file/d/1GycWa_BiS4HV2l6iF_KQJ774Ih_dHJJC/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
   
   
    @IBAction func dismiss(_ sender: Any) {
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func hmisHelpDeskDetails() {
        self.mobileLbl1.text = "040-27788200"
        self.mobileLbl2.text = "070-88200"
        self.mobileLbl3.text = "07989347336"
        self.mobileLbl4.text = "07989349125"
        self.mobileLbl5.text = "07989298838"
        self.mobileLbl6.text = "07989342031"
        
    }
    
    @objc func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }

    func showInternetAlert() {
           if !AppUtilityFunctions.isInternetAvailable() {
               self.inernetAlert(title: "Warning",message: "The Internet is not available")
           }
       }

   func inernetAlert(title:String,message:String)
       {
           DispatchQueue.main.async {
              
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
               self.navigationController?.popToRootViewController(animated: true)
           })
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
               
           }
       }
}
