//  SlotSelectionViewController.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 17/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.


import UIKit
//import FSCalendar


class SlotSelectionViewController: UIViewController,URLSessionDelegate {
    var screeningDeatails = ScreeningDetails()
   // fileprivate weak var calendar: FSCalendar!
    var arHoliday=[String]()
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    
    
    
    var departmentDetails=DepartmentModel()
    var patientDetails=PatientDetails()
    
    var appointmentSlotDetails=AppointmentSlotModel()
    var arAppointmentSlotDetails=[AppointmentSlotModel]()
    
    var deptname:String = ""
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var imgStatus: UIImageView!
    
    
    @IBOutlet weak var lblDepartmentName: UILabel!
    
    @IBOutlet weak var lblSlotsAvailable: UILabel!
    
    
    @IBOutlet weak var lblDateHeader: UILabel!
    
    
//    fileprivate var data = [CustomData(title:"The Islands!"),CustomData(title:"Subscribe to maxcodes"),CustomData(title:"Subscribe to maxcodes"),CustomData(title:"Subscribe to maxcodes"),CustomData(title:"Subscribe to maxcodes"),CustomData(title:"Subscribe to maxcodes"),CustomData(title:"Subscribe to maxcodes")]
     var data:[CustomData] = []
        let collectionView:UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.register(CustomCellTele.self, forCellWithReuseIdentifier: "cell")
            
            //cv.topAnchor.constraint(equalTo: tabView.topAnchor, constant: 20).isActive = true
           return cv
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = Int ()
        addCollectionView();
       // setUpFSCalendar();
        lblDepartmentName.text=deptname
        getHolidays()
        noSlotsAvailable()
    }
    
    
    
    
    
//    @IBAction func btnSelectDateFromCalendar(_ sender: Any) {
////        self.calendar.isHidden=false
//    }
    
    
    
    @IBAction func btnConfirm(_ sender: Any) {
       
        let appopointmentDetails="Appointment request for "+self.screeningDeatails.patName+" ("+screeningDeatails.patGender+"/"+screeningDeatails.patAge+") "+" in "+self.screeningDeatails.deptUnitName+" on "+arAppointmentSlotDetails[0].date+"."
        
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Confirm", message: appopointmentDetails+"Do you want to proceed?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: { [self, weak alert] (_) in
            DispatchQueue.main.async {
                self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            }
            
            self.bookAppointment(requestId: screeningDeatails.requestId, crno: screeningDeatails.crno, scrResponse: screeningDeatails.scrResponse, consName:  screeningDeatails.consName, deptUnitCode: screeningDeatails.deptUnitCode, deptUnitName: screeningDeatails.deptUnitName, requestStatus: screeningDeatails.requestStatus, patMobileNo: screeningDeatails.patMobileNo, consMobileNo: screeningDeatails.consMobileNo, patDocs: screeningDeatails.patDocs, docMessage: screeningDeatails.docMessage, constId: screeningDeatails.constId, patName: screeningDeatails.patName, patAge: screeningDeatails.patAge, patGender: screeningDeatails.patGender, email: screeningDeatails.email, remarks: screeningDeatails.remarks, patWeight: screeningDeatails.patWeight, patHeight: screeningDeatails.patHeight, medications: screeningDeatails.medications, pastdiagnosis: screeningDeatails.pastdiagnosis, pastAllergies: screeningDeatails.pastAllergies, userId: screeningDeatails.userId, stateCode: screeningDeatails.stateCode, districtCode:  screeningDeatails.districtCode, apptDeptUnitCode: screeningDeatails.apptDeptUnit, guardianName: screeningDeatails.guardianName, ptientToken: screeningDeatails.patientToken, apptDate: self.arAppointmentSlotDetails[0].date, slotst: self.arAppointmentSlotDetails[0].slotst, slotet: self.arAppointmentSlotDetails[0].slotet, shiftId: self.arAppointmentSlotDetails[0].shift);

        }
        ))
            
           
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    private func bookAppointment(requestId:String,crno:String, scrResponse:String, consName:String, deptUnitCode:String,  deptUnitName:String, requestStatus:String, patMobileNo:String, consMobileNo:String, patDocs:String, docMessage:String, constId:String, patName:String, patAge:String, patGender:String, email:String, remarks:String, patWeight:String, patHeight:String, medications:String, pastdiagnosis:String, pastAllergies:String, userId:String,  stateCode:String, districtCode:String, apptDeptUnitCode:String, guardianName:String,  ptientToken:String, apptDate:String, slotst:String, slotet:String, shiftId:String)
    {
        let url = URL(string: ServiceUrl.bookAppointment)
       print(ServiceUrl.bookAppointment)
        let parameters: [String: Any] = [ "pat_dtls":[
            "requestID": "P",
            "CRNo": crno,
            "scrResponse": scrResponse,
            "consName": consName,
            "deptUnitCode": deptUnitCode,
            "deptUnitName": deptUnitName,
            "requestStatus": requestStatus,
            "consMobileNo": consMobileNo,
            "patDocs": patDocs,
            "docMessage": docMessage,
            "cnsltntId": constId,
            "rmrks": remarks,
            "email": email,
            "patWeight": patWeight,
            "patHeight": patHeight,
            "patMedication": medications,
            "patPastDiagnosis": pastdiagnosis,
            "patAllergies": pastAllergies,
            "userId": userId,
            "patientToken": screeningDeatails.patientToken,
            "address": "",
            "hospCode": screeningDeatails.hospCode,
            "patMobileNo": patMobileNo,
            "patName": patName,
            "patAge": patAge,
            "patGender": patGender,
            "appt_dept_unit": apptDeptUnitCode,
            "state_code": stateCode,
            "district_code": districtCode,
            "country_code": "IND",
            "pat_guardian": guardianName,
            "appointmentDate": apptDate,
            "appointmentTime": slotst,
            "start_time": slotst,
            "end_time": slotet,
            "shiftId": shiftId
            ]
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)

        print(String(decoding: jsonData!, as: UTF8.self))
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

       
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                self.alert(title: "", message:"error")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("response string:  \(responseJSON)") //Code after Successfull POST Request
                
                var status1:Bool = responseJSON["Status"] as! Bool
                var message:String = (responseJSON["Message"]) as! String
                var crno = (responseJSON["CrNo"])
                print("Status \(status1)")
                
                if (status1)
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                       
                        let finalRequestId:String = message.slice(from: "no ", to: " raised")!

                        let viewController:AppoinmentSuccesfulViewController = (UIStoryboard.init(name: "teleconsultation", bundle: Bundle.main).instantiateViewController(withIdentifier: "AppoinmentSuccesfulViewController") as? AppoinmentSuccesfulViewController)!
                        viewController.requestId = finalRequestId as! String
                        viewController.crno = crno as! String
                        viewController.screeningDetails = self.screeningDeatails
                        viewController.apptDate = apptDate as! String
                       self.navigationController!.show(viewController, sender: self)
                    }
                                       
                }else{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        
                    }
                    self.alert(title: "Cannot Raise Request", message:message)
                  
                }
            }
        }

        task.resume()
        
        
        
    }
    
    func getSlots(date:String,deptUnitCode:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        arAppointmentSlotDetails.removeAll()
        let url = URL(string:ServiceUrl.getSlots + screeningDeatails.hospCode+"&aptDate="+date+"&deptUnitCode="+screeningDeatails.deptUnitCode)
        print("slot url \(url)")
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        urlSession.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                
                if json["status"].stringValue=="1"
                {
                    
                    let appointmentData=json["slot_list"].array
                    let jsonn =   JSON(appointmentData ?? "")
                    if jsonn.count>0 {
                       
                    self.appointmentSlotDetails=AppointmentSlotModel(json: jsonn.arrayValue[0])
                        
                    }
                for arr in jsonn.arrayValue{
                    self.arAppointmentSlotDetails.append(AppointmentSlotModel(json: arr))
                }
                }else{
                    //no slots available
                    self.noSlotsAvailable()
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    if self.arAppointmentSlotDetails.count==0{
                        //no slots available
                        self.noSlotsAvailable()
                    }else{
                        //slots available
                        self.slotsAvailable()
                    }
                    }
            
            }catch{
                
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                
                
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    func getHolidays(){
         arHoliday=[String]()
 //    let today = Date()
     //let nextFollowingSundays = today.nextFollowingSundays(52)
//     nextFollowingSundays.forEach { sunday in sunday
//         let today = sunday
//                           let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MMM-yyyy"
//                    let todaysDateString = formatter.string(from: today)
//         arHoliday.append(todaysDateString)
//     }
             DispatchQueue.main.async {
                 self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
             }
         
             
     let url = URL(string: ServiceUrl.getHolidays)
                 let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

             urlSession.dataTask(with: url!) { (data, response, error) in
                     guard let data = data else { return }
                     do{
                         let json = try JSON(data:data)

                        if json["holiday_list"].count != 0
                        {
                            let formatter = DateFormatter()
                         for arr in json["holiday_list"].arrayValue{
                         
                             //self.arrData.append(PatientRequestDetails(json: arr))
                            let holidayDate=arr["VARHOLIDAYDATE"].stringValue
                            let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                                let date = dateFormatter.date(from: holidayDate)
                                dateFormatter.dateFormat = "dd-MMM-yyyy"
                                dateFormatter.string(from: date!)
                            
                            formatter.dateFormat = "dd-MMM-yyyy"
                           let hDate = formatter.string(from: date ?? Date())
                            self.arHoliday.append(hDate)
                            print(hDate);
                             
//                             self.arHoliday.append(arr["VARHOLIDAYDATE"].stringValue.substring(toIndex: 10))
                                   }
                           
       
                         }
                         
                         DispatchQueue.main.async {
                             self.view.activityStopAnimating()
                            
                            //setting dates to date collectionview slider
                            self.setDateCollectionViewData();
                            self.collectionView.reloadData()
                         }
                          
                   
                         
                     }catch{
                         
                         DispatchQueue.main.async {
                             self.view.activityStopAnimating()
                         }
                         
                         
                         print("aa"+error.localizedDescription)
                     }
                     }.resume()
             }
    
    
    
    
    
    
    private func setDateCollectionViewData()
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
      
        let dateStr = formatter.string(from: date)

        let calendar = Calendar(identifier: .gregorian)
       
        
        let totalDays = Date().getDaysInMonth();
        print("totalDays \(totalDays)")
        if let currDate = formatter.date(from: dateStr) {
            for i in 0..<totalDays {
                let newDate = calendar.date(byAdding: .day, value: i, to: currDate)
                let displayDateformatter = DateFormatter()
                
              let  datesWithEvent=arHoliday
                if datesWithEvent.contains(formatter.string(from: newDate!)) {
                    continue;
                  
                }
                
                
                if i==0 {
                    
                    displayDateformatter.dateFormat = "dd MMM"
                    let todayDisplayDate="Today, "+displayDateformatter.string(from: newDate!)
                    self.data.append( contentsOf: [CustomData(displayDate:todayDisplayDate, dateString: formatter.string(from: newDate!))])
                    lblDateHeader.text=todayDisplayDate
                    
                    getSlots(date: formatter.string(from: date),deptUnitCode: departmentDetails.unitcode)
                }
                
                else if i==1 {
                    
                    displayDateformatter.dateFormat = "dd MMM"
                    let tomorrowDisplayDate="Tomorrow, "+displayDateformatter.string(from: newDate!)
                    self.data.append( contentsOf: [CustomData(displayDate:tomorrowDisplayDate, dateString: formatter.string(from: newDate!))])
                }
                else{
                    
                    displayDateformatter.dateFormat = "EEE, dd MMM"
                self.data.append( contentsOf: [CustomData(displayDate:displayDateformatter.string(from: newDate!), dateString: formatter.string(from: newDate!))])
                }
            }
        }
    }
    
    private func addCollectionView()
    {
        view.addSubview(collectionView)
              collectionView.backgroundColor = .white
              collectionView.delegate = self
              collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemGray6
        
        
              collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
              collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
              collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
              collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
    }
    
    
    
    
    
   
     
     
     
     
     
  /*  private func setUpFSCalendar()
    {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: self.view.frame.size.height-300, width: self.view.frame.size.width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
view.addSubview(calendar)
self.calendar = calendar
self.calendar.backgroundColor = UIColor.white
self.calendar.isHidden=true
    }
     func minimumDate(for calendar: FSCalendar) -> Date
        {
           return Date()
        }

        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
        {
            let formatter=DateFormatter()
//            formatter.dateFormat="yyyy-MM-dd"
            formatter.dateFormat="dd-MMM-yyyy"
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
            formatter.dateFormat="dd-MMM-yyyy"

            getSlots(date: formatter.string(from: date),deptUnitCode: departmentDetails.unitcode)
         formatter.dateFormat="EEE, dd MMM"
            selectedIndex = -1
            DispatchQueue.main.async {
                self.lblDateHeader.text=formatter.string(from: date)
            self.collectionView.reloadData()
                calendar.isHidden=true
            }
            
        }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          let touch = touches.first
          if touch?.view == self.view {
             if calendar.isHidden==false
             {
             calendar.resignFirstResponder()
             calendar.isHidden=true
             }
         }
     }
   */

    
    
    func alert(title:String,message:String)  {
        DispatchQueue.main.async {
           
        let alertController = UIAlertController(title: title, message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            // Inform the user that the user name and password are incorrect
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Within your authentication handler delegate method, you should check to see if the challenge protection space has an authentication type of NSURLAuthenticationMethodServerTrust
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
            // and if so, obtain the serverTrust information from that protection space.
            && challenge.protectionSpace.serverTrust != nil
            && challenge.protectionSpace.host == ServiceUrl.hostName {
            
            let proposedCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, proposedCredential)
        }
    }
    
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
    
}
















    extension SlotSelectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/5)
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCellTele
            cell.data = self.data[indexPath.item]
            
            if selectedIndex == indexPath.row
                {
                selectedCellState(cell: cell)
                }
                else
                {
                    defaultCellState(cell: cell)
                }
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            selectedIndex = indexPath.row
            lblDateHeader.text=self.data[indexPath.item].displayDate
            
            
            
            getSlots(date: self.data[indexPath.item].dateString,deptUnitCode: departmentDetails.unitcode)
           
                
            print("hello "+appointmentSlotDetails.date+" "+appointmentSlotDetails.slotst)
            print(departmentDetails.unitcode)
            self.collectionView.reloadData()
        }
        
        
        
        private func noSlotsAvailable()
        {
            DispatchQueue.main.async {
              
                self.imgStatus.image = UIImage(named:"thumbs_down.png");
                self.lblSlotsAvailable.text="No slot is available for the selected date, Kindly select another date.";
                self.btnConfirm.isHidden=true
            }
        }
        private func slotsAvailable()
        {
            DispatchQueue.main.async {
                self.btnConfirm.isHidden=false
                self.imgStatus.image = UIImage(named:"slots_available.png");
                self.lblSlotsAvailable.text="\(self.arAppointmentSlotDetails.count) Slots Available, Please press confirm to raise appointment request.";
            }
        }
        
        private func defaultCellState(cell:CustomCellTele)
        {
            cell.bg.backgroundColor = UIColor.systemGray
            cell.bg.layer.borderColor = UIColor.lightGray.cgColor
            cell.bg.layer.borderWidth = 1.0
            cell.bg.layer.cornerRadius = 10.0
        }
        
        private func selectedCellState(cell:CustomCellTele)
        {
           // cell.bg.backgroundColor = UIColor(rgb: 0xeffefb)
            //cell.bg.layer.borderColor = UIColor(rgb: 0xa6e1f1).cgColor
            cell.bg.layer.borderWidth = 2.0
            cell.bg.layer.cornerRadius = 10.0
        }
        
        
        
        
    }


   
class CustomCellTele: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
//                bg.image = data.backgroundImage
            bg.text=data.displayDate;
            bg.backgroundColor = .cyan
            bg.textAlignment = .center
            bg.font = UIFont.boldSystemFont(ofSize: 14.0)
            bg.adjustsFontSizeToFitWidth = true
            bg.sizeToFit()
            
        }
    }
    
     let bg: UILabel = {
       let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10.0
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
   
        contentView.addSubview(bg)

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: 10).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

