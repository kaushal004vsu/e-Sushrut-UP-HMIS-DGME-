//
//  LoginMainScreenViewController.swift
//
//  Created by sudeep rai on 18/11/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class LoginMainScreenViewController: UIViewController,UITextFieldDelegate,URLSessionDelegate {

    @IBOutlet weak var EnterMobileNumberView: UIView!
    
    @IBOutlet weak var entertOTPView: UIView!
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    
    @IBOutlet weak var txtOTP: UITextField!
   // @IBOutlet weak var mobileLoginBtn: UIButton!
    @IBOutlet weak var otpLoginBtn: UIButton!
    @IBOutlet weak var doctorLoginBtn: UIButton!
    
    @IBOutlet weak var mobileLoginBtn: UIButton!
    var loginType=5;
    var otp="";
    var arRegisteredPatients=[PatientDetails]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        mobileLoginBtn.layer.cornerRadius = 10
        otpLoginBtn.layer.cornerRadius = 10
        doctorLoginBtn.layer.cornerRadius = 10
        
        hideKeyboardWhenTappedAround()
           
        DispatchQueue.main.async {
          
       if (UserDefaults.standard.string(forKey: "udWhichModuleToLogin")=="doctor")
        {

           let sceneDelegate = UIApplication.shared.connectedScenes
               .first!.delegate as! SceneDelegate
           sceneDelegate.window!.rootViewController = UIStoryboard(name: "Doctor", bundle: nil).instantiateViewController(withIdentifier: "DoctorNavigationController") as! UINavigationController
        }else if(UserDefaults.standard.string(forKey: "udWhichModuleToLogin")=="patient"){

            let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientNavigationController") as! UINavigationController
        }
            
            
        }
        self.txtOTP.delegate = self
        self.txtMobileNumber.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btnGetOTP(_ sender: Any) {
        let mobile=txtMobileNumber.text!
        if !AppUtilityFunctions.isInternetAvailable() {
            self.showToast(message: "The Internet is not available.", font: .systemFont(ofSize: 12.0))
        }else if (mobile.count == 0) {
            showAlert(message: "Mobile number can't be empty.")
                   } else if (mobile.count != 10) {
                      showAlert(message:"Mobile number should be of 10 digits!");
                   } else if ( Array(mobile)[0] == "0") {
                    showAlert(message:"Please remove 0 before mobile number and enter the 10 digit mobile number!");
                   }
                   else if (!(Array(mobile)[0] == "9"||Array(mobile)[0] == "8"||Array(mobile)[0] == "7"||Array(mobile)[0] == "6" )) {
                    showAlert(message:"Mobile number should begin with 6, 7, 8 or 9!");
                   }
                   else {
                       login(mobileNo: txtMobileNumber.text!)
                   }
        }
    
    
   
    @IBAction func btnLogin(_ sender: Any) {
        
//        if (txtOTP.text! == self.otp){
        if !AppUtilityFunctions.isInternetAvailable() {
            self.showToast(message: "Internet is not available.", font: .systemFont(ofSize: 12.0))
        }else if (txtOTP.text! == otp){

            UserDefaults.standard.set(txtMobileNumber.text!, forKey: "udMobileNo")
       
                     
            if (loginType == 0) {
                
                    showAlert(message: " Patient not registered.Please register from registration counter at hospital!")
              
            } else if (loginType == 1) {
                if #available(iOS 13.0, *) {
                    UserDefaults.standard.set("patient", forKey: "udWhichModuleToLogin")
                    
                    
                    let sceneDelegate = UIApplication.shared.connectedScenes
                        .first!.delegate as! SceneDelegate
                    sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientNavigationController") as! UINavigationController

            }
            } else if (loginType == 2) {
                if #available(iOS 13.0, *) {
                    let sceneDelegate = UIApplication.shared.connectedScenes
                        .first!.delegate as! SceneDelegate
                    sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectCRViewController") as! SelectCRViewController

            }
              
            }
        }else if(txtOTP.text?.count != 6){
            showAlert(message: "Invalid OTP.")
        }
        else{
            showAlert(message: "Invalid OTP.")
            }
    
    
    }
    
    
    private func showAlert(message:String)  {
        DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Info!", message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    private func getMobileView(){
        EnterMobileNumberView.isHidden=false
        entertOTPView.isHidden=true
    }
    private func getOTPView()
    {
        EnterMobileNumberView.isHidden=true
        entertOTPView.isHidden=false
    }
    
    
    
    func login(mobileNo:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        arRegisteredPatients.removeAll();
                    let url = URL(string: ServiceUrl.getPatDtlsFromcrno+mobileNo+"&smsFlag=1" )
        
//print("url \(url)")
            
            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                   

        urlSession.dataTask(with: url!) { [self] (data, response, error) in
                guard let data = data else {
                    return }
                do{
                    let json = try JSON(data:data)
                    
                    
//                                    print(data)
                    let otp=json["OTP"].stringValue;
                    print("otp:::: "+otp);
                   self.otp=otp;
                    DispatchQueue.main.async {
//                        if(ServiceUrl.mobileNo == mobileNo){
                            self.txtOTP.text=otp;
//                        }
                    }
                    
                    let jsonArray=json["data"].array;
                  
                    if jsonArray?.count == 0
                    {
                        print("nil json array");
                        showAlert(message: " Patient not registered.Please register from registration counter at hospital!")
                    }else
                    {
                       
                        let jsonn =   JSON(jsonArray!)
                    
                  
                     for arr in jsonn.arrayValue{
                        self.arRegisteredPatients.append(PatientDetails(json: arr))
                  
                    }
                        DispatchQueue.main.async {
                            self.getOTPView()
                        }
                       
                       
                        if jsonArray?.count==0 {
                            print("count=0")
                            self.loginType=0
                        }
                        if jsonArray?.count==1 {
                            print("count=1")
                            self.loginType=1
                            
                            let updateProfile = self.arRegisteredPatients[0]
                            //To save the object
                            UserDefaults.standard.save(customObject: updateProfile, inKey: "patientDetails")
                    
                        }
                        if jsonArray!.count >= 2 {
                            print("count=2")
                            self.loginType=2
                                                        
                        }
                        
                    }
                
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        
                    }
                    
                }
            
            catch{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                    print("error")
                    print(error.localizedDescription)
                }
                }.resume()
        
        
        
        }
    
    @IBAction func btnEnterAgain(_ sender: Any) {
        getMobileView()
    }
    
    
    @IBAction func btnDoctorLogin(_ sender: Any) {
//        let sceneDelegate = UIApplication.shared.connectedScenes
//            .first!.delegate as! SceneDelegate
//        sceneDelegate.window!.rootViewController = UIStoryboard(name: "Doctor", bundle: nil).instantiateViewController(withIdentifier: "DoctorLoginViewController") as! UINavigationController

        
        let loginVC = UIStoryboard(name: "Doctor", bundle: nil).instantiateViewController(withIdentifier: "DoctorLoginViewController") as! DoctorLoginViewController
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        if(textField == txtMobileNumber){
            let maxLength = 10
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            let maxLength = 6
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
              
    }
}
