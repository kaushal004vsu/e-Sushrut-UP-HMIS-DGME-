//
//  HelpQuickStepTableViewController.swift
//  Railways-HMIS
//
//  Created by HICDAC on 01/03/23.
//

import UIKit

class HelpQuickStepTableViewController: UITableViewController,UITextFieldDelegate, URLSessionDelegate {
    var progressBar : UIAlertController!;
    @IBOutlet weak var close: UIImageView!
    
    @IBOutlet weak var doctor_hindi_stk: UIStackView!
    @IBOutlet weak var doctor_eng_stk: UIStackView!
    @IBOutlet weak var patient_hindi_stk: UIStackView!
    @IBOutlet weak var patient_eng_stk: UIStackView!
    
    @IBOutlet weak var doctorEngVideo: UIStackView!
    @IBOutlet weak var doctorHindiVideo: UIStackView!
    @IBOutlet weak var patientEngVideo: UIStackView!
    @IBOutlet weak var linkForTelgramChannel: UIStackView!
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var featuresLbl: UILabel!
    @IBOutlet weak var userAdviceContentLbl: UILabel!
    
    @IBOutlet weak var mobileLbl1: UILabel!
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInternetAlert()
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        close.isUserInteractionEnabled = true
        close.addGestureRecognizer(tapGesture1)
        
        self.mobileLbl1.text = "040-27788200"
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapLabel1(tap:)))
        self.mobileLbl1.addGestureRecognizer(tap1)
        self.mobileLbl1.isUserInteractionEnabled = true
        
        let features:String = "Patient can Raise Tele/Video Consultation Request\n\nSelect User (among Family), Hospital & Department-Unit \n\nFill Basic Details & Health Issues\n\nSlot Selection \n\nConfirmation of Slot after Doctor’s Approval\n\nPatient can check the Status of Requests: Pending/Approved \n\nConsultation with the Doctor on built-in Video or Audio Conference when Doctor is available \n\nView and Download Prescription";
        featuresLbl.text = features
        
        let userAdvice:String="Users are also advised to subscribe to IR-HMIS Channel in Telegram App for all updates regarding HMIS from time to time and for full content of Training Videos."
        userAdviceContentLbl.text = userAdvice
        
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
        
        let doctorEngVideoTap = UITapGestureRecognizer(target: self, action: #selector(doctorEngVideo(tap:)))
        self.doctorEngVideo.addGestureRecognizer(doctorEngVideoTap)
        self.doctorEngVideo.isUserInteractionEnabled = true
        
        let doctorHindiVideoTap = UITapGestureRecognizer(target: self, action: #selector(doctorHindiVideo(tap:)))
        self.doctorHindiVideo.addGestureRecognizer(doctorHindiVideoTap)
        self.doctorHindiVideo.isUserInteractionEnabled = true
        
        let patientEngVideoTap = UITapGestureRecognizer(target: self, action: #selector(patientEngVideo(tap:)))
        self.patientEngVideo.addGestureRecognizer(patientEngVideoTap)
        self.patientEngVideo.isUserInteractionEnabled = true
        
        let linkForTelgramChannelTap = UITapGestureRecognizer(target: self, action: #selector(linkForTelgramChannel(tap:)))
        self.linkForTelgramChannel.addGestureRecognizer(linkForTelgramChannelTap)
        self.linkForTelgramChannel.isUserInteractionEnabled = true
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
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
                
            }
        }
    @objc func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    //User Manual tap
    var urlStr = ""
    @objc func doctorHindi(tap: UITapGestureRecognizer) {
        urlStr="https://drive.google.com/file/d/1MN92-7Elq28IJ1nYC0ewkUfHMuOnqIL0/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func doctorEng(tap: UITapGestureRecognizer) {
        urlStr="https://drive.google.com/file/d/1N22KS2qCANp4ToTmsLyiTC4nb4_yQHoF/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func patientHindi(tap: UITapGestureRecognizer) {
        urlStr="https://drive.google.com/file/d/1ACD4B4SLZHXR3TOxEA5pwNXAunI92bLI/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func patientEng(tap: UITapGestureRecognizer) {
        urlStr="https://drive.google.com/file/d/1GycWa_BiS4HV2l6iF_KQJ774Ih_dHJJC/view"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func doctorEngVideo(tap: UITapGestureRecognizer) {
        urlStr="https://youtu.be/AMauZNgIpOs"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func doctorHindiVideo(tap: UITapGestureRecognizer) {
        urlStr="https://youtu.be/Gid2BqgSmFk"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func patientEngVideo(tap: UITapGestureRecognizer) {
        urlStr="https://youtu.be/shLJunBDgsk"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    @objc func linkForTelgramChannel(tap: UITapGestureRecognizer) {
        urlStr="https://t.me/joinchat/UlUBld5S6OCVxoeY"

        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
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
}


    


