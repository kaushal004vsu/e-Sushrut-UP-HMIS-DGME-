//
//  CreateAbhaOtpViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 02/09/22.
//

import UIKit

class CreateAbhaOtpViewController: UIViewController,UITextFieldDelegate,URLSessionDelegate {
    
    var mobile_number:String = ""
    var txnId:String = ""
    var token :String = ""

    @IBOutlet weak var txtResend: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var linkAbha: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        txtMobile.text = mobile_number
        self.txtMobile.delegate = self
        self.txtOtp.delegate = self
        
            // create the gesture recognizer
            let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.doSomethingOnTap))
           txtResend.addGestureRecognizer(labelTapGesture)

    }
    
    @objc func doSomethingOnTap() {
        generateOtp(mobile: txtMobile.text!)
        //showAlert(message: "Not send.")
    }
    @IBAction func linkAbhaAction(_ sender: Any) {
        
    }
    
    @IBAction func submit_btn(_ sender: Any) {
       

            let mobile=txtMobile.text!
            let otp=txtOtp.text!
            if (mobile.count == 0) {
                         
                showAlert(message: "Mobile number can't be empty.")
                       } else if (mobile.count != 10) {
                          showAlert(message:"Mobile number should be of 10 digits!");
                       } else if ( Array(mobile)[0] == "0") {
                        showAlert(message:"Please remove 0 before mobile number and enter the 10 digit mobile number!");
                          
                       }
                       else if (!(Array(mobile)[0] == "9"||Array(mobile)[0] == "8"||Array(mobile)[0] == "7"||Array(mobile)[0] == "6" )) {
                        showAlert(message:"Mobile number should begin with 6, 7, 8 or 9!");
                          
                       }else if(otp.count == 0){
                           showAlert(message: "OTP can not be empty.")
                       }else if(otp.count != 6){
                           showAlert(message: "Invalid OTP.")
                       }else{
                               verifyOtp(txtOtp: otp)

                            }
                       }
    
    
    
    func verifyOtp(txtOtp:String){
        // prepare json data
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
    }
        let json: [String: String] = ["otp": txtOtp,"txnId": txnId]
        print("prin \(txtOtp)  \n\(txnId)")
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: ServiceUrl.ndhm+"hip/v1/registration/mobile/verifyOtp")! //PUT Your URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       // request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")//
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("fbdcf45645fgnG34534FvdfFvdfbNytHERgSdbsdvsdvs3", forHTTPHeaderField: "HIS-AUTH-KEY")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                self.token = responseJSON["token"] as? String ?? ""
                if(self.token.isEmpty ){
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    do {
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
                        let viewController:CreateNDHMIDViewController = self.storyboard!.instantiateViewController(withIdentifier: "CreateNDHMIDViewController") as! CreateNDHMIDViewController
                            viewController.token = self.token
                            viewController.txnId = self.txnId
                                self.navigationController!.show(viewController, sender: self)
                    }
                   
                    
                }
            }
        }

        task.resume()
        
    }
    
    
    func generateOtp(mobile:String){
        // prepare json data
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let json: [String: String] = ["patMobileNo": mobile]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: ServiceUrl.ndhm+"hip/v1/registration/mobile/generateOtp")! //PUT Your URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       // request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")//
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("fbdcf45645fgnG34534FvdfFvdfbNytHERgSdbsdvsdvs3", forHTTPHeaderField: "HIS-AUTH-KEY")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let txnNumber=responseJSON["txnId"] as? String ?? ""
                self.txnId = txnNumber
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
                         DispatchQueue.main.async {
                             self.view.activityStopAnimating()
                         }
                         self.showAlert(message: "Failed to load: \(error.localizedDescription)")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.showAlert(message: "Resend OTP successfully!")
                        self.txtOtp.text = ""
                        
                    }
                }
            }
        }

        task.resume()
        
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
        let maxLength = 6
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

  
}
