//
//  CreateNDHMIDViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 07/09/22.
//

import UIKit

class CreateNDHMIDViewController: UIViewController ,UITextFieldDelegate, URLSessionDelegate{
    var token = ""
    var txnId = ""
    @IBOutlet weak var txtPatientName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtDateBirth: UITextField!
    @IBOutlet weak var txtState_Ut: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    
    @IBOutlet weak var lblAlreadyUser: UILabel!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var lblconfirmPassword: UILabel!
    

    var umidData = UmidData()
    //Uidate picker
    let datepicker = UIDatePicker()
    let imageIcon  = UIImageView()
    let imageIcon2  = UIImageView()
    var passClick:Bool = false
    var confPassClick:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        imageIcon.image = UIImage(named: "open_eye")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "open_eye")!.size.width, height: UIImage(named: "open_eye")!.size.height)
        imageIcon.frame = CGRect(x: 5, y: 5, width: 22, height: 22)
        txtPassword.rightView = contentView
        txtPassword.rightViewMode = .always
        
        let tapPassGesture1 = UITapGestureRecognizer(target: self, action: #selector(imagePassTapped(tapGesture:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapPassGesture1)
        
        imageIcon2.image = UIImage(named: "open_eye")
        let contentView2 = UIView()
        contentView2.addSubview(imageIcon2)
        contentView2.frame = CGRect(x: 0, y: 0, width: UIImage(named: "open_eye")!.size.width, height: UIImage(named: "open_eye")!.size.height)
        imageIcon2.frame = CGRect(x: 5, y: 5, width: 22, height: 22)
       txtConfirmPassword.rightView = contentView2
       txtConfirmPassword.rightViewMode = .always
        let tapConfPassGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageConfPassTapped(tapGesture:)))
        imageIcon2.isUserInteractionEnabled = true
        imageIcon2.addGestureRecognizer(tapConfPassGesture2)
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")

        txtPatientName.isEnabled = false
        txtDateBirth.isEnabled = false
        txtState_Ut.isEnabled = false
        txtAddress.isEnabled = false
        txtGender.isEnabled = false
        
        txtPatientName.text = "\(obj!.firstName)"
        txtDateBirth.text = "\(obj!.dob)"
        txtState_Ut.text = "\(obj!.state)"
        txtAddress.text = "\(obj!.sublocality), \(obj!.city)"
        txtGender.text = "\(obj!.gender)"
        
        //show date picker
        createDatePicker()
        
        // create the gesture recognizer
//        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.doSomethingOnTap))
//        txtUserName.addGestureRecognizer(labelTapGesture)
        
        txtUserName.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtPassword.addTarget(self, action: #selector(self.textFielpassworddDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtConfirmPassword.addTarget(self, action: #selector(self.textFielconfirmPassDidChange(textField:)), for: UIControl.Event.editingChanged)

        
    }
    
    @objc func imagePassTapped(tapGesture:UITapGestureRecognizer){
        let tappedImage = tapGesture.view as! UIImageView
        if passClick{
            passClick = false
            tappedImage.image = UIImage(named: "open_eye")
            txtPassword.isSecureTextEntry = true
        }else{
            passClick = true
            tappedImage.image = UIImage(named: "close_eye")
            txtPassword.isSecureTextEntry = false
        }
    }
    @objc func imageConfPassTapped(tapGesture:UITapGestureRecognizer){
        let tappedImage = tapGesture.view as! UIImageView
        if confPassClick{
            confPassClick = false
            tappedImage.image = UIImage(named: "open_eye")
            txtConfirmPassword.isSecureTextEntry = true
        }else{
            confPassClick = true
            tappedImage.image = UIImage(named: "close_eye")
            txtConfirmPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func txtPasswordAction(_ sender: Any) {

    }
    
    @IBAction func txtConfirmPassAction(_ sender: Any) {

        
    }
    @objc func textFieldDidChange(textField : UITextField){
        if txtUserName.text!.matches("^[A-Za-z\\d.]{4,}$") {
            checkHealthId(username: txtUserName.text!)
        }
        else{
            self.lblAlreadyUser.isHidden = false
            self.lblAlreadyUser.text = "Must contain atleast 4 letters. Please note, we allow alphabets and numbers in the ABHA and do not allow special character except dot (.)"
           }
       

    }
    @objc func textFielpassworddDidChange(textField : UITextField){

        if txtPassword.text!.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$") {
            self.lblpassword.isHidden = true
        }else{
            self.lblpassword.isHidden = false
            self.lblpassword.text = "Must contain an uppercase, a lowercase, a number, a special character and at least 8 or more characters"
        }
    }
    @objc func textFielconfirmPassDidChange(textField : UITextField){

        if (txtPassword.text! != txtConfirmPassword.text!) {
            self.lblconfirmPassword.isHidden = false
            self.lblconfirmPassword.text = "Confirm password do not match"
        }
        else{
            self.lblconfirmPassword.isHidden = true
           }
       

    }
//    @objc func doSomethingOnTap() {
//
//    }
    
    @IBAction func submitAction(_ sender: Any) {
        if (txtPatientName.text?.isEmpty)! {
            showAlert(message: "Please enter Patient Name")
            txtPatientName.becomeFirstResponder()
        }else if (txtUserName.text?.isEmpty)! {
            showAlert(message: "Please enter ABHA Address")
            txtUserName.becomeFirstResponder()
        }
//        else if (self.isValidUsername(Input: txtUserName.text!)) {
//         //   showAlert(message: txtUserName.text!)
//            showAlert(message: "Must contain atleast 4 letters. Please note, we allow alphabets and numbers in the ABHA and do not allow special character except dot (.)")
//        }
        else if (txtPassword.text?.isEmpty)! {
            showAlert(message: "Please enter password")
            txtPassword.becomeFirstResponder()
        }else if (txtConfirmPassword.text?.isEmpty)! {
            showAlert(message: "Please enter confirm password")
            txtConfirmPassword.becomeFirstResponder()
        }else if (txtPassword.text! != txtConfirmPassword.text!) {
            showAlert(message: "Password doesn't match")
            txtConfirmPassword.becomeFirstResponder()
        }else if (txtDateBirth.text?.isEmpty)! {
            showAlert(message: "Enter/Select Date of Birth")
            txtDateBirth.becomeFirstResponder()
        }else if (txtState_Ut.text?.isEmpty)! {
            showAlert(message: "Please enter State/UT")
            txtState_Ut.becomeFirstResponder()
        }else if (txtAddress.text?.isEmpty)! {
            showAlert(message: "Please enter Address")
            txtAddress.becomeFirstResponder()
        }else if (txtGender.text?.isEmpty)! {
            showAlert(message: "Please enter Gender")
            txtGender.becomeFirstResponder()
        }else if(lblAlreadyUser.isHidden == false || lblpassword.isHidden == false || lblconfirmPassword.isHidden == false){
            showAlert(message: "Please fill all required fields correctly")
            
        }else{
            callCreateHelthId()
        }
    }
    
    var isValidUsername: Bool {
            NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z\\d.]{4,}$").evaluate(with: self)
        }
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donepressed))
        
        toolbar.setItems([donebtn], animated: true)
        
        txtDateBirth.inputAccessoryView = toolbar
        
        txtDateBirth.inputView = datepicker
        
        datepicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            datepicker.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
        }
    }
    @objc func donepressed() {
        let dateformator = DateFormatter()
        
        dateformator.dateStyle = .medium
        dateformator.timeStyle = .none
        
        
        let stringA = formattedDateFromString(dateString: dateformator.string(from: datepicker.date), withFormat: "dd/MM/yyyy")
        
        txtDateBirth.text = stringA
        self.view.endEditing(true)
    }
    
    // input string should always be in format "Jul 21, 2016" ("MMM dd, yyyy")
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM dd, yyyy"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    func checkHealthId(username:String){
//        DispatchQueue.main.async {
//            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
//        }
        let json: [String: String] = ["healthId": username]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let url = URL(string: ServiceUrl.ndhm+"hip/v1/search/existsByHealthId")! //PUT Your URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                let status=responseJSON["status"] as? Bool
                 if(status!){
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.lblAlreadyUser.text = "ABHA Address \(username) is already taken, try another one"
                        self.lblAlreadyUser.isHidden = false
                    }
                }else{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.lblAlreadyUser.isHidden = true
                        
                        
                    }
                }
            }
        }

        task.resume()
        
    }
    
    func callCreateHelthId(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
      //  var umidData:UmidData = obj!.umidData
        
        var str = obj!.dob
        var strArray = str.components(separatedBy: "-")

        let json: [String: String] = [
            "overridePatDtlExistCheck":"true"
            ,"address":"\(obj!.sublocality), \(obj!.city)"
             ,"dayOfBirth":strArray[0]//dob birth
             ,"monthOfBirth":strArray[1]//month only
             ,"yearOfBirth":strArray[2]//year only karna hai
             ,"districtCode": ""
            ,"email":obj!.email
             ,"firstName":obj!.firstName
            ,"middleName":obj!.middleName
            ,"lastName":obj!.lastName
           ,"gender":txtGender.text!
             ,"healthId":txtUserName.text!
             ,"name":"\(obj!.firstName)"
             ,"password":txtPassword.text!
            ,"pincode":obj!.pincode
             ,"profilePhoto":""
             ,"restrictions":""
            ,"stateCode":""
             ,"subdistrictCode":""
             ,"townCode":""
             ,"villageCode":""
             ,"wardCode":""
            ,"mobile":obj!.mobileNo
             ,"token":self.token
             ,"txnId":self.txnId
                
            
//            "overridePatDtlExistCheck":"true",
//            "address":"test for railnilayam",
//            "dayOfBirth":"01",
//            "districtCode":"",
//            "email":"",
//            "firstName":"Sudeep  Rai",
//            "gender":"M",
//            "healthId":"sudeep.ded3ede33d76",
//            "lastName":"Rai",
//            "middleName":"",
//            "monthOfBirth":"06",
//            "name":"Sudeep  Rai  Rai",
//            "password":"Test@2120",
//            "pincode":"201001",
//            "profilePhoto":"",
//            "restrictions":"",
//            "stateCode":"",
//            "subdistrictCode":"",
//            "townCode":"",
//            "villageCode":"",
//            "wardCode":"",
//            "yearOfBirth":"1997",
//            "mobile":"7042420714",
//            "txnId":"e6376449-f43e-4333-a252-ef2e6d2dac50",
//            "token":"eyJhbGciOiJSUzUxMiJ9.eyJzdWIiOiI5MzE1MDU5NTM3IiwiY2xpZW50SWQiOiJFX1NVU0hSVVRfUkFJTFRFTCIsInN5c3RlbSI6IkFCSEEtTiIsImV4cCI6MTY2MzE1MTgyNSwiaWF0IjoxNjYzMTUwMDI1LCJ0eG5JZCI6ImU2Mzc2NDQ5LWY0M2UtNDMzMy1hMjUyLWVmMmU2ZDJkYWM1MCJ9.fv-SJ3II-a-HnOKUzZoFxJzbxqeTRgPsa6FBHBzu3bahACNF4Gj6AWLKttPpmoW_rP9eNDoTZBr2FByBfhg1bAdozCQAnts5UAV3ckOhTQKQG67WQ3t4WMs4Lj651fMFjJN1P5jtUqviH8_MTXW3hqEY2P4z9S7bMxlqistvBcdh6udUTY9b-HURfQO1hrc7gkkE0aD7ftn1equKLt2Oj3EEdTuP0nAm9lH9635pF25P3gcbPS_WikKqklepqUicQjUqNHmpBcRftZ-M5ui-N6AVrJ3rgHVx_Nry2BC7I7EUELY4_gf9WzAJAI4_ZC0BGmH3GR3VODmo_zMO4oieXCpvx2ZXCSPDhfy-gx7c01DfC8N53lPl3CH5ozO5Na9-pEMu82EOP8k-fvu0Ou3P3nfMjao7yXahrOxdrWcKpUEzQzoqSxFlf3Gc9R5MiXMepd_UlO1L26Ozd4r_eyLG-8vQs87Yr7B1Yws-WtT_CjulalOJbCbY_TKrKI7x26jE9EaeaaO97aqKRB0OFqcj8zHMFJ0RvLjjFgyF8xb1AgSFGxXWdQ550nZurb9GFKVijfHrq9xVDm0gzNmjVC53R1kHcqqbidnegTOcS9sXShVmftM4NEXguBxatrCEEk_y9FpYhamR_Kv3ildD7Z7uqn15C3Ioc4erwioZPOj4-_4"
                                      
        ]

        print(json)
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let url = URL(string: ServiceUrl.ndhm+"hip/v1/registration/mobile/createHealthId")! 
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("fbdcf45645fgnG34534FvdfFvdfbNytHERgSdbsdvsdvs3", forHTTPHeaderField: "HIS-AUTH-KEY")
        // insert json data to the request
        request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("hello")
                    print(error?.localizedDescription ?? "No data")
                    return
                }
             
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                 print("responseJSON")
                   let token=responseJSON["token"] as? String ?? ""
                     if(token.isEmpty){
                         DispatchQueue.main.async {
                             print("response ")
                             self.view.activityStopAnimating()
                             let isSuccess=responseJSON["isSuccess"] as? Int ?? 0
                             if let data = responseJSON["Error"] as? [String:Any] {
                                 if let details = data["details"] as? [[String:Any]] {
                                     let dict = details[0]
                                     if let message = dict["message"] as? String{
                                         print(message)
                                         self.showAlert(message: "\(message)")
                                     }
                                 }
                             }else {
                                 let error=responseJSON["error"] as? String ?? ""
                                 self.showAlert(message: "\(error)")
                             }
                         }
                    }else{
                        print("inside else")
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                           let ndhmHealthId = responseJSON["healthId"] as? String ?? ""
                            let ndhmPatHealthId = responseJSON["healthIdNumber"] as? String ?? ""
                        self.updateHealthId(ndhmID: ndhmHealthId, ndhmPatHealthId: ndhmPatHealthId)
                        }
                      
                    }
                }else {
                   
                    DispatchQueue.main.async {
                        let viewController:NDHMIdSummaryViewController = self.storyboard!.instantiateViewController(withIdentifier: "NDHMIdSummaryViewController") as! NDHMIdSummaryViewController
                            viewController.ndhmID = "123456"
                            viewController.ndhmPatHealthId = "654321"
                            self.navigationController!.show(viewController, sender: self)
                        self.showAlert(message: "Something went wrong.")

                        self.view.activityStopAnimating()
                       
                        
                    }
                }
            }
            task.resume()

       

        
    }
    func updateHealthId(ndhmID:String,ndhmPatHealthId:String){
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")

        let url2 = "\(ServiceUrl.updateNdhmId)?hospCode=\(obj!.hospCode)&ndhmId=\(ndhmID)&ndhmPatHealthId=\(ndhmPatHealthId)&crno=\(obj!.crno)&mobileNo=\(obj!.mobileNo)&umid=\(obj!.umidNo)"
        print(url2)
        let url = URL(string:url2 )
        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data else { return }
            do{
                var json = try JSON(data:data)
                let status = json["status"].stringValue
                if status=="1"{
                                   DispatchQueue.main.async {
                                   ///call view controler here
                                       self.view.activityStopAnimating()
                                       let viewController:NDHMIdSummaryViewController = self.storyboard!.instantiateViewController(withIdentifier: "NDHMIdSummaryViewController") as! NDHMIdSummaryViewController
                                           viewController.ndhmID = ndhmID
                                           viewController.ndhmPatHealthId = ndhmPatHealthId
                                           self.navigationController!.show(viewController, sender: self)
                                       
                                       self.showAlert(message: "Token Created Successfully!!")
                                   }
                               }
                               else{
//                                   let stringData=String(data: data, encoding: String.Encoding.utf8) as String?
//                                   let json = JSON.init(parseJSON: stringData!)
                                   DispatchQueue.main.async {
                                       self.view.activityStopAnimating()
                                       self.showAlert(message: "Unable to update ABHA Number.")
                                   }
                               }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                
            }catch{
                print("error"+error.localizedDescription)
            }
            }.resume()
    }


    
    private func showAlert(message:String)  {
        DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Info!", message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
   
}
