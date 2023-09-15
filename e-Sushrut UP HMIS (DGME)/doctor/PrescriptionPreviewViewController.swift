//
//  PrescriptionPreviewViewController.swift
//  CustomDialogBox
//
//  Created by sudeep rai on 13/09/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class PrescriptionPreviewViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var arrData=PresData()
    var patientData=PatientRequestDetails()
    var followUpDate:String=""
    var displayDate:String=""
    var imageData=""
    
    var snomedCodes:String=""
    var snomedCodesDiagnosis:String=""
    
    var strSwStatus:String=""
    
    @IBOutlet weak var imgIsUploadedRef: UIImageView!
    @IBOutlet weak var lblPatientDetails: UILabel!
    
    
    @IBOutlet weak var lblFolloeUp: UILabel!
    
    
    @IBOutlet weak var txtChiefComplaints: UITextView!
    
    @IBOutlet weak var txtHistory: UITextView!
    
    
    @IBOutlet weak var txtExaminations: UITextView!
    
    @IBOutlet weak var txtDiagnosis: UITextView!
    
    @IBOutlet weak var txtTests: UITextView!
    
    
    @IBOutlet weak var txtProcedures: UITextView!
    @IBOutlet weak var txtRx: UITextView!
    
    @IBOutlet weak var txtVitals: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Preview"
        lblPatientDetails.text=patientData.patName+" ("+patientData.patGender+"/"+patientData.patAge+")"
        
self.hideKeyboardWhenTappedAround()
        addBackgroundBorder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.savePrescription(sender:)))
        
        txtChiefComplaints.text=arrData.pres_complaint
        txtHistory.text=arrData.pres_history
        txtExaminations.text=arrData.pres_examination
        txtDiagnosis.text=arrData.pres_diagnosis
        txtTests.text=arrData.pres_test
        txtProcedures.text=arrData.pres_procedure
        txtRx.text=arrData.pres_treatment
        txtVitals.text=arrData.pres_vitals
//         self.sendFcmPush(title: "eConsultation Completed", message: "Your prescription for eConsultation with  \(UserDefaults.standard.string(forKey: "udUserdisplayname")!) has been generated. You can view the PDF from Consultation and Status  page.")
        if followUpDate != ""
        {
        lblFolloeUp.text="OPD Visit Date: "+displayDate
             lblFolloeUp.isHidden=false
        }else{
            lblFolloeUp.isHidden=true
        }
        
        print("strswstatus    "+strSwStatus)
        
        if (strSwStatus=="Final") {
            txtDiagnosis.isEditable=false
        } else {
            strSwStatus = "Provisional"
            txtDiagnosis.isEditable=true
        }
        print(getRequestBody())
    }
    
    
    
    
    func addBackgroundBorder()
    {
        txtChiefComplaints.layer.cornerRadius = 6.0
               txtChiefComplaints.layer.borderWidth = 1.2
               txtChiefComplaints.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
               
               txtHistory.layer.cornerRadius = 6.0
                      txtHistory.layer.borderWidth = 1.2
                      txtHistory.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
               
               txtExaminations.layer.cornerRadius = 6.0
                      txtExaminations.layer.borderWidth = 1.2
                      txtExaminations.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
               
               txtDiagnosis.layer.cornerRadius = 6.0
                      txtDiagnosis.layer.borderWidth = 1.2
                      txtDiagnosis.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
               
               txtTests.layer.cornerRadius = 6.0
                      txtTests.layer.borderWidth = 1.2
                      txtTests.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
               
               txtProcedures.layer.cornerRadius = 6.0
                      txtProcedures.layer.borderWidth = 1.2
                      txtProcedures.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
               
               txtRx.layer.cornerRadius = 6.0
                      txtRx.layer.borderWidth = 1.2
                      txtRx.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
               
               txtVitals.layer.cornerRadius = 6.0
                      txtVitals.layer.borderWidth = 1.2
                      txtVitals.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
    }
   

    
    
    
    @objc func savePrescription(sender: UIBarButtonItem) {
//        let chiefComplaints=txtChiefComplaints.text!
//        let history=txtHistory.text!
//        let examinations=txtExaminations.text!
//        let diagnosis=txtDiagnosis.text!
//        let tests=txtTests.text!
//        let procedures=txtProcedures.text!
//        let rx=txtRx.text!
//        let vitals=txtVitals.text!
        
        
      
       callSavePrescriptionService()

       }
    
    func getRequestBody() -> String
    {
        do{
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let data = try! encoder.encode(patientData)
//             let patData=String(data: data, encoding: .utf8)!
            
            
            let chiefComplaint=txtChiefComplaints.text!
            let history=txtHistory.text!
            let examinations=txtExaminations.text!
            let diagnosis=txtDiagnosis.text!
            let tests=txtTests.text!
            let procedures=txtProcedures.text!
            let rx=txtRx.text!
            let vitals=txtVitals.text!
            
             var presDataa=PresData()
            presDataa=PresData(chiefComplaints: chiefComplaint, history: history, Examinations: examinations, diagnosis: diagnosis, tests: tests, procedures: procedures, rx: rx, vitals: vitals,pres_diagnosis_type: strSwStatus)
            
            
            let printData=SavePrescription(pat_data: patientData,pres_data: presDataa)
             let encoder = JSONEncoder()
                       encoder.outputFormatting = .prettyPrinted
                       let data = try! encoder.encode(printData)
                        let patData=String(data: data, encoding: .utf8)!
           
            if !self.imageData.isEmpty
            {
                self.imageData=String(self.imageData.filter { !" \n\t\r".contains($0) })
                
            }
                
           let imageData = ",{" +
                           "\"image\": {" +
            "\"image_data\": \""+self.imageData+"\"" +
                           "}}";

                   let snomedDataDiagnosis = ",{" +
                           "\"snomed\": {" +
                    "\"snomed_diagnosis\": \""+self.snomedCodesDiagnosis+"\"" +
                           "}}";
            
            let revisitDate=",{" +
            " \"revisit\": {" +
            " \"revisitDate\": \"" + followUpDate + "\"" +
            "}}";
            
                  let s = "{" +
                           "\"JSON_DATA\": [" + patData + imageData + snomedDataDiagnosis +  revisitDate + "]" +
                           "}";
//             print(s)
            
            return s;
        }
        
    }
    
     func callSavePrescriptionService(){
      
                let url = URL(string: ServiceUrl.savePrescriptionUrl)
               
                var request = URLRequest(url: url!)
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"

        let data = Data(getRequestBody().utf8)
//        let data = (getRequestBody().data(using: .utf8,allowLossyConversion: false))! as Data
        

                request.httpBody = data
        
                
    //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                
                
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard data != nil else { return }
                    do{
                      
                        
                        let empCode=UserDefaults.standard.string(forKey: "udEmpcode")
                               let consName=UserDefaults.standard.string(forKey: "udUserdisplayname")!
                               let consMobileNo=UserDefaults.standard.string(forKey: "udMobileNo")
                               
                               let encodedConsName = consName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                        
                        
                        let initialUrl=ServiceUrl.updateRequestStatus+self.patientData.hospCode
                        let firstHalfUrl="&requestID=\(self.patientData.requestID)&reqStatus=2&consltID=\(empCode!)&consltName=\(encodedConsName!)"
                        
                        let secondHalfUrl="&consltMobNo=\(consMobileNo!)&docMessage=&doctorToken="
                        let url=initialUrl+firstHalfUrl+secondHalfUrl
                        self.updateRequestStatus(updateRequestUrl: url)
                       
                          
                       
                    }
                    }.resume()
            }
    
    
    
    func updateRequestStatus(updateRequestUrl:String){
    //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            let url = URL(string: updateRequestUrl)
         
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        let json = try JSON(data:data)
//                        print(data)

                       let status = json["Status"].stringValue
                        if status == "1"
                        {
                            print("status=1")
                            self.sendFcmPush(title: "eConsultation Completed", message: "Your prescription for eConsultation with  \(UserDefaults.standard.string(forKey: "udUserdisplayname")!) has been generated. You can view the PDF from Consultation and Status page.")
                        }
                        else{
                            //show alert could not update request.
                        }
                       
                      DispatchQueue.main.async {
                        
//                        self.navigationController?.popToRootViewController(animated: true)
                        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                    }.resume()
            }
    
    
    @IBAction func btnScanPrescription(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.camera
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            
            
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage else {
                    return
            }
 
//        img1.setImage(image, for: UIControl.State.normal)
        let imagee=self.resizeImage(image: image, targetSize: CGSize(width:1000.0 , height:1000.0))
        self.imageData=convertImageToBase64(image: imagee)

        if !imageData.isEmpty
        {
        imgIsUploadedRef.isHidden=false
        }
        else
        {
            imgIsUploadedRef.isHidden=true
        }
        
        
        
            self.dismiss(animated:true, completion: nil)
        
}
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 50.0)!
        return imageData.base64EncodedString()
//        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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

        let parameters = "{\"data\":{\"title\":\"\(title)\",\"content\":\"\(message)\",\"navigateTo\":\"\"},\"to\":\"\(patientData.patientToken)\"}"
          print(parameters)
                  request.httpBody = parameters.data(using: .utf8)
                  
      //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                  
                  
              URLSession.shared.dataTask(with: request) { (data, response, error) in
                      guard let data = data else { return }
                      do{
                          print("url \(url!)")
                          let json = try JSON(data:data)
                          
                         
                          print(":::::"+json.stringValue)
                          
                          
                      }catch{
                          print("error"+error.localizedDescription)
                      }
                      }.resume()
              }
}
