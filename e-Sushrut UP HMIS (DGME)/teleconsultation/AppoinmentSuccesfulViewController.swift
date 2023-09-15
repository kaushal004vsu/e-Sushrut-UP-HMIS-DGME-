//
//  AppoinmentSuccesfulViewController.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 21/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class AppoinmentSuccesfulViewController: UIViewController {

    var patName:String = ""
    var crno:String = ""
    var gender:String = ""
    var age:String = ""
    
    var  departUnitName:String = ""
    var  slotSt:String = ""
    var  slotEt:String = ""
    var   appointmentNo:String = ""
    //var appointmentDate:String =  ""
    
    var screeningDetails = ScreeningDetails()
    var requestId:String = ""
    var apptDate:String = ""
    
    
    @IBOutlet weak var lblAppointmentDetails: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
//        let appointmentDetails=patName + " (" + gender + "/" + age + " Yr) \n"  + departUnitName+"\n"+appointmentDate+" ("+slotSt+" - "+slotEt+")\n Your appointment number is\n "+appointmentNo
//        lblAppointmentDetails.text=appointmentDetails
       
        
        
        let appointmentDetails = "<font size=\"4\" color=\"white\"> ( Your Appointment No. is "+requestId+" )<br><br>"+screeningDetails.patName + " ( CRNO. " + screeningDetails.crno+" ),<br><br>Your Appointment is Booked for <b>\""+screeningDetails.deptUnitName+"\" </b>dated <b>\""+apptDate+"\"</b>. Please reach hospital registration counter to complete the hospital formalities.";
        
        lblAppointmentDetails.attributedText=appointmentDetails.htmlToAttributedString
        
    }
    
    @IBAction func btnHome(_ sender: Any) {
        DispatchQueue.main.async {
           
//            var rootVC : UIViewController?
//            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientNavigationController") as! UINavigationController
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                  appDelegate.window?.rootViewController = rootVC
            let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientNavigationController") as! UINavigationController
            
        }
    }
    

}
