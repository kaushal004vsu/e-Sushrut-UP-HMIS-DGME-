//
//  PopupActionViewController.swift
//  CustomDialogBox
//
//  Created by Shubham Singh on 01/04/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

//Protocol to inform the Parent viewController to take some action based on the dialog box
protocol PopUpProtocol {
    func handleAction(action: Bool)
}

class PopUpActionViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var lblPatientName: UILabel!
    @IBOutlet weak var refAccept: UIButton!
    static let identifier = "PopUpActionViewController"

    var delegate: PopUpProtocol?
    var arrData = PatientRequestDetails()
    var isUpcoming = false
    @IBOutlet weak var edtMessage: UITextView!
    @IBOutlet weak var lblPatientDetails: UITextView!
    //MARK:- outlets for the view controller
    @IBOutlet weak var dialogBoxView: UIView!
   
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- lifecyle methods for the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
        if isUpcoming {
            refAccept.isHidden=true
        }
        print(isUpcoming)
        lblPatientName.text=arrData.patName+" ("+arrData.patGender+"/"+arrData.patAge+"/"+arrData.patMobileNo+")"
        
        edtMessage.delegate=self
        let patName=self.arrData.patName
               let gender=arrData.patGender
               let age=arrData.patAge
               let mobileNumber=arrData.patMobileNo
        var weight=arrData.patWeight
        var height = arrData.patHeight
        var medications = arrData.patMedication
        var diagnosis = arrData.patPastDiagnosis
        var allergy = arrData.patAllergies
        var remarks = arrData.rmrks
        
        var labelText="";
        if weight != "" {
            weight="Weight: "+weight
            labelText=labelText+weight
        }
        if !height.isEmpty  {
            height="Height: "+height
            labelText=labelText+"    "+height
        }
        if !medications.isEmpty {
        medications="Medications: "+medications
            labelText=labelText+"\n"+medications
    }
    if !diagnosis.isEmpty  {
        diagnosis="Past Diagnosis: : "+diagnosis
        labelText=labelText+"\n"+diagnosis
    }
        if !allergy.isEmpty
        {
            allergy="Allergies: "+allergy
            labelText=labelText+"\n"+allergy
        }
        if !remarks.isEmpty
        {
        remarks="Problem Description: "+remarks
            labelText=labelText+"\n"+remarks
        }
             
          lblPatientDetails.text = patName+" ("+gender+"/"+age+"/"+mobileNumber+")"+"\n"+weight+"\t"+height+"\n"+medications+"\n"+diagnosis+"\n"+allergy+"\n"+remarks
        
        lblPatientDetails.text=labelText
        
        //adding an overlay to the view to give focus to the dialog box
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        //customizing the dialog box view
        dialogBoxView.layer.cornerRadius = 6.0
        dialogBoxView.layer.borderWidth = 1.2
        dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        

    }
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }

    @IBAction func btnSendMessage(_ sender: Any) {
        if !edtMessage.text.isEmpty {
            //call update message service
            if !self.edtMessage.text.isEmpty {
                updateDoctorMessage(doctorMessage: self.edtMessage.text!,isSendMessage: true)
            }
        
        self.delegate?.handleAction(action: true)
        self.dismiss(animated: true, completion: nil)
        }
        else{
            //show alert to enter message
            showAlert(title: "Warning!", message: "Message can't be empty. Please enter message")
        }
    }
    
    @IBAction func btnRejectRequest(_ sender: Any) {
        
        
        
        
        if !edtMessage.text.isEmpty {
           rejectRequest(docMessage: edtMessage.text)
            self.delegate?.handleAction(action: true)
             self.dismiss(animated: true, completion: nil)
            
        }else{
            //show error doctor message can't be empty.
            showAlert(title: "Warning!", message: "Message can't be empty. Please enter message")
        }
        
        
        
    }
    
    
    @IBAction func btnAcceptRequest(_ sender: Any) {
       
        
//        if !edtMessage.text.isEmpty {
            acceptRequest(docMessage: edtMessage.text)
                    self.delegate?.handleAction(action: true)
             self.dismiss(animated: true, completion: nil)
     
//        }else{
//            //show error doctor message can't be empty.
//            showAlert(title: "Warning!", message: "Message can't be empty. Please enter message")
//        }
        
        
    }
    
    
    
    
    func acceptRequest(docMessage:String) {
        let empCode=UserDefaults.standard.string(forKey: "udEmpcode")
        let consName=UserDefaults.standard.string(forKey: "udUserdisplayname")!
        let consMobileNo=UserDefaults.standard.string(forKey: "udMobileNo")
        
        let encodedConsName = consName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
       
        let initialUrl=ServiceUrl.updateRequestStatus+arrData.hospCode
        let firstHalfUrl="&requestID=\(arrData.requestID)&reqStatus=1&consltID=\(empCode!)&consltName=\(encodedConsName!)"
        
        let secondHalfUrl="&consltMobNo=\(consMobileNo!)&docMessage=&doctorToken="
        let url=initialUrl+firstHalfUrl+secondHalfUrl
        
       
        acceptRequestServiceCall(updateRequestUrl: url, docMessage: edtMessage.text!)
        
        
        
        print(url)
    }
    
    
    
    
    func acceptRequestServiceCall(updateRequestUrl:String,docMessage:String){
//            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let url = URL(string: updateRequestUrl)
      DispatchQueue.main.async {
           self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
       }
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let json = try JSON(data:data)
                    print(data)

                   let status = json["Status"].stringValue
                    if status == "1"
                    {
                        //call update message service
                        if !docMessage.isEmpty
                        {
                            self.updateDoctorMessage(doctorMessage: docMessage,isSendMessage: false)
                        }
                        print("status=1")
                        //call generate episode webservice
                        self.generateEpisodeServiceCall()
                       
                    //callfcm notification service
                        
                        self.sendFcmPush(title: "eConsultation Request Approved", message: "Your eConsultation request for \(self.arrData.departmentName) at \(self.arrData.hospitalName) has been approved by \(UserDefaults.standard.string(forKey: "udUserdisplayname")!) . The doctor will call you soon, please visit “Consultation and Status” page and wait for join video call link to be shown.")
                    }
                    else{
                        //show alert could not update request.
                    }
                   
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
                }.resume()
        }
    
    
    
    
    func generateEpisodeServiceCall(){
    //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        
        let url = URL(string: ServiceUrl.generateEpisode+arrData.requestID+"&hospCode="+arrData.hospCode)
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        print(data)

                    }
                    }.resume()
            }
    
    
    
    func updateDoctorMessage(doctorMessage:String,isSendMessage:Bool){
       //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
           let empCode=UserDefaults.standard.string(forKey: "udEmpcode")!
                  let consName=UserDefaults.standard.string(forKey: "udUserdisplayname")!
            let encodedConsName = consName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
          let encodedDocMessage = doctorMessage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlString=ServiceUrl.updateDoctorMessage + arrData.requestID + "&docMessage=" + encodedDocMessage + "&consltID=" + empCode + "&consltName=" + encodedConsName + "&hospCode=" + arrData.hospCode
        
//        let encodedUrl=urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
           
       // print(urlString)
        let url = URL(string: urlString)
     
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
                       guard let data = data else { return }
                       do{
                           print(data)
if isSendMessage
{
    self.sendFcmPush(title: "Message from "+UserDefaults.standard.string(forKey: "udUserdisplayname")!,message: doctorMessage)
                        }
                       }
                       }.resume()
               }
       
    
    func rejectRequest(docMessage:String) {
        let empCode=UserDefaults.standard.string(forKey: "udEmpcode")
        let consName=UserDefaults.standard.string(forKey: "udUserdisplayname")!
        let consMobileNo=UserDefaults.standard.string(forKey: "udMobileNo")
        
        let encodedConsName = consName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
      // let encodedDocMessage = docMessage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let initialUrl=ServiceUrl.updateRequestStatus+arrData.hospCode
        let firstHalfUrl="&requestID=\(arrData.requestID)&reqStatus=4&consltID=\(empCode!)&consltName=\(encodedConsName)"
        
        let secondHalfUrl="&consltMobNo=\(consMobileNo!)&docMessage=&doctorToken="
        let url=initialUrl+firstHalfUrl+secondHalfUrl
        
       
        rejectRequestServiceCall(updateRequestUrl: url,docMessage: docMessage)
        
        
        
        print(url)
    }
    
    
    
    
    
    func rejectRequestServiceCall(updateRequestUrl:String,docMessage:String){
    //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                let url = URL(string: updateRequestUrl)
          DispatchQueue.main.async {
               self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
           }
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        let json = try JSON(data:data)
                        print(data)

                       let status = json["Status"].stringValue
                        if status == "1"
                        {
                            //call update message service
                          
                            self.updateDoctorMessage(doctorMessage: docMessage,isSendMessage: false)

                            print("status=1")
                        //callfcm notification service for rejected request.
                            self.sendFcmPush(title: "eConsultation Request Rejected", message: "Your eConsultation request for \(self.arrData.departmentName) at \(self.arrData.hospitalName) has been rejected by \(UserDefaults.standard.string(forKey: "udUserdisplayname")!) . Please check \"Consultation & Status page\" for doctor's message.")
                        }
                        else{
                            //show alert could not update request.
                        }
                       
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                        }
                        
                        
                    }catch{
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                        }
                        print(error.localizedDescription)
                    }
                    }.resume()
            }
    
    
    
    
    
    
    
    
    
    
    
    
    /**
     Send notification to patient
     */
    func sendFcmPush(title:String,message:String){
      
        let url = URL(string: "https://fcm.googleapis.com/fcm/send")
               
                var request = URLRequest(url: url!)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ServiceUrl.serverLegacyKey, forHTTPHeaderField: "Authorization")
                request.httpMethod = "POST"

        let parameters = "{\"data\":{\"title\":\"\(title)\",\"content\":\"\(message)\",\"navigateTo\":\"\"},\"to\":\"\(arrData.patientToken)\"}"
        
                request.httpBody = parameters.data(using: .utf8)
                
    //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                
                
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        print("url \(url!)")
                        let json = try JSON(data:data)
                        
                       
                        print(":::::"+json.stringValue)
                        
                        
                    }catch{
                        print("sudeep"+error.localizedDescription)
                    }
                    }.resume()
            }
    
    
    
   func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        return self.textLimit(existingText: edtMessage.text,
                              newText: text,
                              limit: 300)
    }
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }

    
    
    func showAlert(title:String,message:String)  {
           let alertController = UIAlertController(title: title, message:
               message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
           
           present(alertController, animated: true, completion: nil)
       }
    
    
    
    
}
