//
//  DeskViewController.swift
//  CustomDialogBox
//
//  Created by sudeep rai on 12/09/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit
//import JitsiMeet
//import FSCalendar

//class DeskViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
class DeskViewController: UIViewController,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var lblFinalDiagnosis: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var diagnosisSwitchRef: UISwitch!
    
    @IBOutlet weak var txtAutoComplete: UITextField!
    var arSnomed=[DiagnosisModel]()
    var pickerView=UIPickerView()
    
    var snomedCodes=""
    var snomedCodesDiagnosis=""
    var strSwStatus="Provisionsal"
    
    
//    fileprivate weak var calendar: FSCalendar!
    var arHoliday=[String]()
    
    var displayDate:String=""
    var followUpDate:String=""
    
    var pickerToolbar: UIToolbar?
    
    @IBOutlet weak var btnFollowUpRef: UIButton!
    var datePicker = UIDatePicker()
    @IBOutlet weak var btnComplaints: UIButton!
    
    @IBOutlet weak var btnHistory: UIButton!
    
    @IBOutlet weak var btnExaminations: UIButton!
    
    @IBOutlet weak var btnDiagnosis: UIButton!
    
    @IBOutlet weak var btnTests: UIButton!
    
    
    @IBOutlet weak var btnProcedures: UIButton!
    
    @IBOutlet weak var btnRx: UIButton!
    
    @IBOutlet weak var btnVitals: UIButton!
    
    
    
    
    
    
    @IBOutlet weak var lblTypeSelected: UILabel!
    var arrData=PresData()
    var patientData=PatientRequestDetails()
    
//  fileprivate var pipViewCoordinator: PiPViewCoordinator?
//     fileprivate var jitsiMeetView: JitsiMeetView?
    
    
    
    @IBOutlet weak var txtChiefComplaints: UITextView!
    
    @IBOutlet weak var txtHistory: UITextView!
    
    @IBOutlet weak var txtExaminations: UITextView!
    @IBOutlet weak var txtDiagnosis: UITextView!
    
    @IBOutlet weak var txtTests: UITextView!
    
    @IBOutlet weak var txtProcedures: UITextView!
    
    
    @IBOutlet weak var txtRx: UITextView!
    
    @IBOutlet weak var txtvitals: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
        
        
        
        
      /*
        
        self.navigationItem.title = patientData.patName+" ("+patientData.patGender+"/"+patientData.patAge+")"
        getHolidays()
         // Do any additional setup after loading the view.
                       let calendar = FSCalendar(frame: CGRect(x: 0, y: self.view.frame.size.height-300, width: self.view.frame.size.width, height: 300))
                       calendar.dataSource = self
                       calendar.delegate = self
        view.addSubview(calendar)
         self.calendar = calendar
        
        self.calendar.backgroundColor = UIColor.white
        self.calendar.isHidden=true
        
        
        self.hideKeyboardWhenTappedAround()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.savePrescription(sender:)))

        */
        
        borderView.layer.cornerRadius = 6.0
        borderView.layer.borderWidth = 1.2
        borderView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        
//        txtChiefComplaints.layer.cornerRadius = 6.0
//        txtChiefComplaints.layer.borderWidth = 1.2
//        txtChiefComplaints.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//
//        txtHistory.layer.cornerRadius = 6.0
//               txtHistory.layer.borderWidth = 1.2
//               txtHistory.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//
//        txtExaminations.layer.cornerRadius = 6.0
//               txtExaminations.layer.borderWidth = 1.2
//               txtExaminations.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//
//        txtDiagnosis.layer.cornerRadius = 6.0
//               txtDiagnosis.layer.borderWidth = 1.2
//               txtDiagnosis.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//
//        txtTests.layer.cornerRadius = 6.0
//               txtTests.layer.borderWidth = 1.2
//               txtTests.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//
//        txtProcedures.layer.cornerRadius = 6.0
//               txtProcedures.layer.borderWidth = 1.2
//               txtProcedures.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//
//        txtRx.layer.cornerRadius = 6.0
//               txtRx.layer.borderWidth = 1.2
//               txtRx.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//
//        txtvitals.layer.cornerRadius = 6.0
//               txtvitals.layer.borderWidth = 1.2
//               txtvitals.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        
        pickerView.dataSource=self
               pickerView.delegate=self
               txtAutoComplete.delegate=self
        
    }
    
    
    @IBAction func btnClear(_ sender: Any) {
        
        if txtChiefComplaints.isHidden==false
        {
             txtChiefComplaints.text = ""
        }
        else if txtHistory.isHidden==false
        {
            txtHistory.text = ""
        }
        else if txtExaminations.isHidden==false
        {
            txtExaminations.text = ""
        }
        else if txtDiagnosis.isHidden==false
        {
            txtDiagnosis.text = ""
        }
        else if txtTests.isHidden==false
        {
            txtTests.text = ""
        }
        else if txtProcedures.isHidden==false
        {
            txtProcedures.text = ""
        }
        else if txtRx.isHidden==false
        {
            txtRx.text = ""
        }
        else if txtvitals.isHidden==false
        {
            txtvitals.text = ""
        }
    }
    
    @objc func savePrescription(sender: UIBarButtonItem) {
        let chiefComplaints=txtChiefComplaints.text!
        let history=txtHistory.text!
        let examinations=txtExaminations.text!
        let diagnosis=txtDiagnosis.text!
        let tests=txtTests.text!
        let procedures=txtProcedures.text!
        let rx=txtRx.text!
        let vitals=txtvitals.text!
        
        arrData=PresData(chiefComplaints: chiefComplaints,history: history,Examinations: examinations,diagnosis: diagnosis,tests: tests,procedures: procedures,rx: rx,vitals: vitals, pres_diagnosis_type: strSwStatus)
        
        
    let viewController:PrescriptionPreviewViewController = self.storyboard!.instantiateViewController(withIdentifier: "PrescriptionPreviewViewController") as! PrescriptionPreviewViewController
       
           viewController.arrData=arrData
        viewController.patientData=patientData
        viewController.followUpDate=followUpDate
        viewController.displayDate=displayDate
        
        viewController.snomedCodes=snomedCodes
        viewController.snomedCodesDiagnosis=snomedCodesDiagnosis
        viewController.strSwStatus=strSwStatus

           self.navigationController!.show(viewController, sender: self)
       }
    
    
    @IBAction func btnPatDocs(_ sender: Any) {
        viewDocuments()
    }
    
    
    @IBAction func btnPatDetails(_ sender: Any) {
        showPopup(parentVC: self,arrData: patientData)
    }
    
    
    @IBAction func btnVideoCall(_ sender: Any) {
         let consName=UserDefaults.standard.string(forKey: "udUserdisplayname")!
        sendFcmPush(title:"eConsultation Doctor Call", message: consName+" is calling you for eConsultation. Please join the call using the “Join Video Call” link shown in the “Consultation and Status” page of the app.");

        
       // makeJitsiCall()
        
       
       
    }
    
    
    @IBAction func btnAudioCall(_ sender: Any) {
        if let url = URL(string: "tel://\(patientData.patMobileNo)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func btnComplaints(_ sender: Any) {
        showTextView(textView: txtChiefComplaints)
        selectedTab(button: btnComplaints)
        lblTypeSelected.text="Complaints"
    }
    
    @IBAction func btnHistory(_ sender: Any) {
         showTextView(textView: txtHistory)
         selectedTab(button: btnHistory)
          lblTypeSelected.text="History"
    }
    
    @IBAction func btnExaminations(_ sender: Any) {
         showTextView(textView: txtExaminations)
         selectedTab(button: btnExaminations)
          lblTypeSelected.text="Examinations"
    }
    
    @IBAction func btnDiagnosis(_ sender: Any) {
         showTextView(textView: txtDiagnosis)
         selectedTab(button: btnDiagnosis)
          lblTypeSelected.text="Diagnosis"
    }
    
    @IBAction func btnTests(_ sender: Any) {
         showTextView(textView: txtTests)
         selectedTab(button: btnTests)
          lblTypeSelected.text="Tests"
    }
    
    @IBAction func btnProcedures(_ sender: Any) {
         showTextView(textView: txtProcedures)
         selectedTab(button: btnProcedures)
          lblTypeSelected.text="Procedures"
    }
    
    @IBAction func btnRx(_ sender: Any) {
         showTextView(textView: txtRx)
         selectedTab(button: btnRx)
          lblTypeSelected.text="Treatment Advice"
    }
    
    
    @IBAction func btnVitals(_ sender: Any) {
         showTextView(textView: txtvitals)
         selectedTab(button: btnVitals)
          lblTypeSelected.text="Vitals"
    }
    
    
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
          self.view.frame.origin.y = -250 // Move view 150 points upward
     }

     @objc func keyboardWillHide(sender: NSNotification) {
          self.view.frame.origin.y = 0 // Move view to original position
     }
    
    
    
    
    
    func viewDocuments()
    {
   
//        let viewController:DocumentViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "DocumentViewViewController") as! DocumentViewViewController
//                   viewController.arrData=patientData
//                   self.navigationController!.show(viewController, sender: self)
    }
    
    
    
    func showPopup(parentVC: UIViewController,arrData: PatientRequestDetails){
               //creating a reference for the dialogView controller
              
              
               if let patientDetailsViewController = UIStoryboard(name: "CustomView", bundle: nil).instantiateViewController(withIdentifier: "PatientDetailsViewController") as? PatientDetailsViewController {
                   patientDetailsViewController.modalPresentationStyle = .custom
                   patientDetailsViewController.modalTransitionStyle = .crossDissolve
                   
                   //setting the delegate of the dialog box to the parent viewController
                   //patientDetailsViewController.delegate = parentVC as? PopUpProtocol
   patientDetailsViewController.arrData=arrData
                   parentVC.present(patientDetailsViewController, animated: true)
                   
                   
                   
                     
               }
    }
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        _ = CGRect(origin: CGPoint.zero, size: size)
//        pipViewCoordinator?.resetBounds(bounds: rect)
    }
//    fileprivate func cleanUp() {
//        jitsiMeetView?.removeFromSuperview()
//        jitsiMeetView = nil
//        pipViewCoordinator = nil
//    }
    
    
    
    
    
    /**
     Send notification to patient
     */
    func sendFcmPush(title:String,message:String){
      
        let url = URL(string: "https://fcm.googleapis.com/fcm/send")
               
                var request = URLRequest(url: url!)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ServiceUrl.serverLegacyKey, forHTTPHeaderField: "Authorization")
                request.httpMethod = "POST"

        let parameters = "{\"data\":{\"title\":\"\(title)\",\"content\":\"\(message)\",\"navigateTo\":\""+patientData.requestID+"\"},\"to\":\"\(patientData.patientToken)\"}"
       // print("parametra:: "+parameters)
                request.httpBody = parameters.data(using: .utf8)
                
    //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                
                
            URLSession.shared.dataTask(with: request) { (data, response, error) in
//                    guard let data = data else { return }
//                    do{
////                        print("url \(url!)")
//                        //let json = try JSON(data:data)
//
//
////                        print(":::::"+json.stringValue)
//
//
//                    }catch{
//                        print("error "+error.localizedDescription)
//                    }
                    }.resume()
            }
    
    
    
    
//    func makeJitsiCall()
//    {
//        cleanUp()
//               // create and configure jitsimeet view
//                       let jitsiMeetView = JitsiMeetView()
//                       jitsiMeetView.delegate = self
//                       self.jitsiMeetView = jitsiMeetView
//                       let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
//                           builder.welcomePageEnabled = true
//                           builder.serverURL = URL(string: "https://mconsultancy.uat.dcservices.in")
//                           builder.room = self.patientData.requestID
//                           builder.subject=self.patientData.patName
//               //            P37913200617000002
//                       }
//                       jitsiMeetView.join(options)
//                       // Enable jitsimeet view to be a view that can be displayed
//                       // on top of all the things, and let the coordinator to manage
//                       // the view state and interactions
//                       pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
//                       pipViewCoordinator?.configureAsStickyView(withParentView: view)
//
//                       // animate in
//                       jitsiMeetView.alpha = 0
//                       pipViewCoordinator?.show()
//    }
    func showTextView(textView: UITextView)
    {
        txtChiefComplaints.isHidden=true
        txtHistory.isHidden=true
        txtExaminations.isHidden=true
        txtDiagnosis.isHidden=true
        txtTests.isHidden=true
        txtProcedures.isHidden=true
        txtRx.isHidden=true
        txtvitals.isHidden=true
        
        
        diagnosisSwitchRef.isHidden=true
        lblFinalDiagnosis.isHidden=true
        txtAutoComplete.isHidden=true
        textView.isHidden=false
        
        if textView==txtDiagnosis
        {
        
            diagnosisSwitchRef.isHidden=false
            lblFinalDiagnosis.isHidden=false
if diagnosisSwitchRef.isOn {
  print("The Switch is on")
    txtAutoComplete.isHidden=false
    txtDiagnosis.isEditable=false
    strSwStatus="Final"
    
   
} else {
    print("The Switch is off")
    txtAutoComplete.isHidden=true
     txtDiagnosis.isEditable=true
    strSwStatus="Provisional"
    
}
        }
        
    }
    
    @IBAction func switchButtonClicked(_ sender: Any) {
        if diagnosisSwitchRef.isOn {
          print("The Switch is on")
            txtAutoComplete.isHidden=false
            txtDiagnosis.isEditable=false
            txtDiagnosis.text=""
            strSwStatus="Final"
            diagnosisSwitchRef.setOn(true, animated:true)
           
        } else {
            print("The Switch is off")
            txtAutoComplete.isHidden=true
             txtDiagnosis.isEditable=true
            txtDiagnosis.text=""
            strSwStatus="Provisional"
            diagnosisSwitchRef.setOn(false, animated:true)
        }
    }
    
    @IBAction func btnFollowUp(_ sender: Any) {
        //calendar.isHidden=false
    }
    func selectedTab(button: UIButton)
    {
        
        btnComplaints.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
        btnComplaints.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        btnHistory.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
        btnHistory.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        btnExaminations.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
        btnExaminations.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        btnDiagnosis.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
        btnDiagnosis.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        btnTests.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
        btnTests.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        btnProcedures.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
        btnProcedures.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        btnRx.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
        btnRx.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        btnVitals.backgroundColor = UIColor(displayP3Red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)
             btnVitals.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
      
        button.backgroundColor = UIColor.blue
       button.setTitleColor(UIColor.white, for: UIControl.State.normal)

    }
    
    
   func getHolidays(){
        arHoliday=[String]()
    let today = Date()
    let nextFollowingSundays = today.nextFollowingSundays(52)
    nextFollowingSundays.forEach { sunday in sunday
        let today = sunday
                          let formatter = DateFormatter()
                      formatter.dateFormat = "yyyy-MM-dd"
                   let todaysDateString = formatter.string(from: today)
        arHoliday.append(todaysDateString)
//        print(todaysDateString)
    }
            DispatchQueue.main.async {
                self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            }
        
            
    let url = URL(string: ServiceUrl.getHolidays)
    //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        let json = try JSON(data:data)

                       if json["holiday_list"].count != 0
                       {
                        for arr in json["holiday_list"].arrayValue{
                        
                            //self.arrData.append(PatientRequestDetails(json: arr))
                               print(arr["VARHOLIDAYDATE"].stringValue);
                            
                            self.arHoliday.append(arr["VARHOLIDAYDATE"].stringValue.substring(toIndex: 10))
                                  }

      
                        }
                        
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                        }
                         
                  
                        
                    }catch{
                        
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                        }
                        
                        
                        print("aa"+error.localizedDescription)
                    }
                    }.resume()
            }
    
    
    
    
    
    
   /* func minimumDate(for calendar: FSCalendar) -> Date
       {
          return Date()
       }

       func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
       {
           let formatter=DateFormatter()
           formatter.dateFormat="yyyy-MM-dd"
           let dateString = formatter.string(from: date)
           
           let datesWithEvent = arHoliday
           if datesWithEvent.contains(dateString) {
            
            alert(title: "Holiday",message: "Selected date is a holiday.")
               return false
           }
           else
           {
               return true
           }
          
       }
       
       
       func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
           let formatter=DateFormatter()
           formatter.dateFormat="yyyy-MM-dd hh:mm:ss"
//           print("date    \(formatter.string(from: date))")
        followUpDate=formatter.string(from: date)
        formatter.dateFormat="EEE, dd MMM"
//        print("display date \(formatter.string(from: date))")
        
        displayDate=formatter.string(from: date)
        btnFollowUpRef.setTitle(displayDate, for: .normal)
           calendar.isHidden=true
       }
    
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view == self.view {
            if calendar.isHidden==false
            {
            calendar.resignFirstResponder()
            calendar.isHidden=true
            followUpDate=""
            displayDate=""
            btnFollowUpRef.setTitle("Follow Up Visit", for: .normal)
            }
        }
    }
    */
    func alert(title:String,message:String)  {
        let alertController = UIAlertController(title: title, message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    /** Diagnosis snomed code*/
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if(textField == txtAutoComplete){
          let strLength = textField.text?.count ?? 0
          print(strLength)
        if strLength >= 2 {
            print("hello")
            getSnomed(term: textField.text!)
           
           
        }
       }
       return true
    }

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arSnomed.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        arSnomed[row].term
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row > arSnomed.count-1){
            return
          }
        else{
        txtAutoComplete.text=arSnomed[row].term
        
        
        txtDiagnosis.text=txtDiagnosis.text + arSnomed[row].term + ", "
        self.snomedCodes=self.snomedCodes+arSnomed[row].term+"|"+arSnomed[row].id+","
        
        self.snomedCodesDiagnosis=self.snomedCodesDiagnosis+arSnomed[row].id+",";
        txtAutoComplete.text=""
        arSnomed.removeAll()
            self.txtAutoComplete.inputView=nil
        txtAutoComplete.resignFirstResponder()
        }
    }
    
    
    func getSnomed(term:String){
        //        print("check update")
            arSnomed.removeAll()
                            
            let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
        let url = URL(string: ServiceUrl.ip+"csnoserv/api/search/search?term=\(encodedTerm ?? "")&state=active&semantictag=all&acceptability=synonyms&returnlimit=10&refsetid=null" )
            
        //            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                        guard let data = data else {
                            return }
                        do{
                            let json = try JSON(data:data)
                            if json.arrayValue.count != 0
                            {
                            for arr in json.arrayValue
                            {
                                print(arr["term"].stringValue)
                               let term = arr["term"].stringValue
                              let id =  arr["id"].stringValue
                                self.arSnomed.append(DiagnosisModel(term: term,id: id))
                            }
                            
                            DispatchQueue.main.async {
          self.txtAutoComplete.inputView = self.pickerView
                     
                     self.txtAutoComplete.resignFirstResponder()
                     self.txtAutoComplete.becomeFirstResponder()
                            }
                            }
                        }catch{
                            print("error")
                            print(error.localizedDescription)
                        }
                        }.resume()
                }
    

    
    
    
    
}
//extension DeskViewController: JitsiMeetViewDelegate {
//    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
//        DispatchQueue.main.async {
//            self.pipViewCoordinator?.hide() { _ in
//                self.cleanUp()
//            }
//        }
//    }
//
//    func enterPicture(inPicture data: [AnyHashable : Any]!) {
//        DispatchQueue.main.async {
//            self.pipViewCoordinator?.enterPictureInPicture()
//        }
//    }
//}
