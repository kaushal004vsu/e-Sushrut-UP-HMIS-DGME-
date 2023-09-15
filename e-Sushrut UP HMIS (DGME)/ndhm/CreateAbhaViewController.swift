//
//  CreateAbhaViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import iOSDropDown

class CreateAbhaViewController: UIViewController ,UITextFieldDelegate,URLSessionDelegate{

    var otp="";
    @IBOutlet weak var consent_tv: UITextView!
    @IBOutlet weak var agree: UIButton!
    // declare bool
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    var unchecked = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       hideKeyboardWhenTappedAround()
        self.txtMobileNumber.delegate = self
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        txtMobileNumber.text = obj!.mobileNo
        
        txtMobileNumber.isEnabled = false
}

    @IBAction func agree(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
   
    @IBAction func submitBtnAction(_ sender: Any) {

        let mobile=txtMobileNumber.text!
        if (mobile.count == 0) {
                     
            showAlert(message: "Mobile number can't be empty.")
                   } else if (mobile.count != 10) {
                      showAlert(message:"Mobile number should be of 10 digits!");
                   } else if ( Array(mobile)[0] == "0") {
                    showAlert(message:"Please remove 0 before mobile number and enter the 10 digit mobile number!");
                      

                   }
                   else if (!(Array(mobile)[0] == "9"||Array(mobile)[0] == "8"||Array(mobile)[0] == "7"||Array(mobile)[0] == "6" )) {
                    showAlert(message:"Mobile number should begin with 6, 7, 8 or 9!");
                      

                   }else if let button = sender as? UIButton {
                       if agree.isSelected {
                           agree.isSelected = true
                           generateOtp(mobile: mobile)
                          
                       } else {
                           // set deselected
                           agree.isSelected = false
                           showAlert(message:"Please check I agree.");
                       }
                   }
                   
        
    }
    
    func generateOtp(mobile:String){
        // prepare json data
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let json: [String: String] = ["patMobileNo": mobile]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: ServiceUrl.ndhm + "hip/v1/registration/mobile/generateOtp")! //PUT Your URL
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       // request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")//
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("fbdcf45645fgnG34534FvdfFvdfbNytHERgSdbsdvsdvs3", forHTTPHeaderField: "HIS-AUTH-KEY")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let txnNumber=responseJSON["txnId"] as? String ?? ""
                if(txnNumber.isEmpty ){
                    do {
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                            }
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                    // try to read out a dictionary
                                    if let data = responseJSON["Error"] as? [String:Any] {
                                        if let details = data["details"] as? [[String:Any]] {
                                            let dict = details[0]
                                            if let message = dict["message"] as? String{
                                                print(message)
                                                self.showAlert(message: "\(message)")
                                            }
                                        }
                                    }
                                }
                     } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        let viewController:CreateAbhaOtpViewController = self.storyboard!.instantiateViewController(withIdentifier: "CreateAbhaOtpViewController") as! CreateAbhaOtpViewController
                            viewController.mobile_number = self.txtMobileNumber.text!
                            viewController.txnId = txnNumber
                            self.navigationController!.show(viewController, sender: self)
                        
                    }
                }
            }
        }

        task.resume()
        
    }
    
 
    func showAlert(title:String,message:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
    
    private func showAlert(message:String)  {
        DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Info!", message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
