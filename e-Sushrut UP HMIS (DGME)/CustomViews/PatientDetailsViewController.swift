//
//  PatientDetailsViewController.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 15/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class PatientDetailsViewController: UIViewController {
     var arrData = PatientRequestDetails()
    
    @IBOutlet weak var lblPatientDetails: UILabel!
    @IBOutlet weak var dialogBoxView: UIView!
    
    @IBOutlet weak var weightStack: UIStackView!
    
    @IBOutlet weak var lblWeight: UILabel!
    
   
    @IBOutlet weak var stackHeight: UIStackView!
    
    @IBOutlet weak var lblHeight: UILabel!
    
    @IBOutlet weak var stackMedications: UIStackView!
    
    @IBOutlet weak var lblMedications: UILabel!
    
    @IBOutlet weak var stackPastDiagnosis: UIStackView!
    
    @IBOutlet weak var lblDiagnosis: UILabel!
    
    @IBOutlet weak var stackAllergy: UIStackView!
    
    @IBOutlet weak var lblAllergy: UILabel!
    
    
    @IBOutlet weak var stackDescription: UIStackView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    
    @IBOutlet weak var stackScreening: UIStackView!
    
    
    @IBOutlet weak var lblScreening: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblPatientDetails.text=arrData.patName+" ("+arrData.patGender+"/"+arrData.patAge+")"
        
        
        lblHeight.text="Height: "+arrData.patHeight
        lblWeight.text="Weight: "+arrData.patWeight
        lblMedications.text="Medications: "+arrData.patMedication
        lblAllergy.text="Allergies: "+arrData.patAllergies
        lblDiagnosis.text="Past Diagnosis: "+arrData.patPastDiagnosis
//        lblScreening.text=arrData.scrResponse
        lblDescription.text="Problem Description: "+arrData.rmrks
        
        
//        let index = arrData.scrResponse.index(arrData.scrResponse.startIndex, offsetBy: 0)
        var fever = arrData.scrResponse[0]
        var cough = arrData.scrResponse[1]
        var soreThroat = arrData.scrResponse[2]
        var breathingDifficulty = arrData.scrResponse[3]
        var foreignTravel = arrData.scrResponse[4]

        if (fever=="N") {
            fever = "Fever : " + "No, ";
        } else if (fever=="Y") {
            fever = "Fever : " + "Yes, ";
        } else {
            fever = "";
        }

        if (cough=="N") {
            cough = "Cough : " + "No, ";
        } else if (cough=="Y") {
            cough = "Cough : " + "Yes, ";
        } else {
            cough = "";
        }

        if (soreThroat=="N") {
            soreThroat = "Sore Throat : " + "No, ";
        } else if (soreThroat=="Y") {
            soreThroat = "Sore Throat : " + "Yes, ";
        } else {
            soreThroat = "";
        }

        if (breathingDifficulty=="N") {
            breathingDifficulty = "Breathing Difficulty : " + "No, ";
        } else if (breathingDifficulty=="Y") {
            breathingDifficulty = "Breathing Difficulty : " + "Yes, ";
        } else {
            breathingDifficulty = "";
        }


        if (foreignTravel=="N") {
            foreignTravel = "Foreign Travel/Contact with foreigners in last 14 days : " + "No";
        } else if (foreignTravel=="Y") {
            foreignTravel = "Foreign Travel/Contact with foreigners in last 14 days : " + "Yes, ";
        } else {
            foreignTravel = "";
        }


        lblScreening.text=fever + cough + soreThroat + breathingDifficulty + foreignTravel
        if (fever + cough + soreThroat + breathingDifficulty + foreignTravel).trimmingCharacters(in: .whitespaces)==""
        {
            stackScreening.isHidden=true
        }
            else {
           stackScreening.isHidden=false
        }
        
        
        if arrData.patWeight==""
        {
            weightStack.isHidden=true
        }
        if arrData.patHeight=="" {
            stackHeight.isHidden=true
        }
        if arrData.patMedication==""
        {
            stackMedications.isHidden=true
        }
        if arrData.patPastDiagnosis==""
        {
            stackPastDiagnosis.isHidden=true
        }
        if arrData.patAllergies==""
        {
            stackAllergy.isHidden=true
        }
        if arrData.rmrks==""
        {
            stackDescription.isHidden=true
        }
            
        
        //adding an overlay to the view to give focus to the dialog box
               view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
               
               //customizing the dialog box view
               dialogBoxView.layer.cornerRadius = 6.0
               dialogBoxView.layer.borderWidth = 1.2
               dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
    }
    
    @IBAction func btnWeight(_ sender: Any) {
        // write to clipboard
        UIPasteboard.general.string = arrData.patWeight
        toast(message: "Copied to clipboard")
    }
    
    @IBAction func btnHeight(_ sender: Any) {
        UIPasteboard.general.string = arrData.patHeight
       toast(message: "Copied to clipboard")
    }
    
    
    @IBAction func btnMedications(_ sender: Any) {
        UIPasteboard.general.string = arrData.patMedication
         toast(message: "Copied to clipboard")
    }
    
    
    @IBAction func btnPastDiagnosis(_ sender: Any) {
        UIPasteboard.general.string = arrData.patPastDiagnosis
         toast(message: "Copied to clipboard")
    }
    
    
    @IBAction func btnAllergiy(_ sender: Any) {
        UIPasteboard.general.string = arrData.patAllergies
         toast(message: "Copied to clipboard")
    }
    
    
    
    @IBAction func btnDescription(_ sender: Any) {
        UIPasteboard.general.string = arrData.rmrks
         toast(message: "Copied to clipboard")
    }
    
    @IBAction func btnScreening(_ sender: Any) {
        UIPasteboard.general.string = lblScreening.text
         toast(message: "Copied to clipboard")
    }
    
    
    @IBAction func btnClose(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func toast(message:String)
{
    
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    self.present(alert, animated: true)

    // duration in seconds
    let duration: Double = 1
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
        alert.dismiss(animated: true)
    }
    }
}
