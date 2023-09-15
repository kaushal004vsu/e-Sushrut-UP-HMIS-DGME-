//  OPDSlotSelectionViewController.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 17/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.


import UIKit
//import FSCalendar
struct CustomData {
    var displayDate: String
    var dateString: String
   
}
var selectedIndex = Int ()


class OPDSlotSelectionViewController: UIViewController,URLSessionDelegate {

   // fileprivate weak var calendar: FSCalendar!
    var arHoliday=[String]()
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    
    
    
    var departmentDetails=DepartmentModel()
    var patientDetails=PatientDetails()
    
    var appointmentSlotDetails=AppointmentSlotModel()
    var arAppointmentSlotDetails=[AppointmentSlotModel]()
    
    var arraySlotDates = [DateSlotDetails]()

    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var imgStatus: UIImageView!
    
    
    @IBOutlet weak var lblDepartmentName: UILabel!
    
    @IBOutlet weak var lblSlotsAvailable: UILabel!
    
    
    @IBOutlet weak var lblDateHeader: UILabel!
    
    
    
    
     //var data:[CustomData] = []
        let collectionView:UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
            
            //cv.topAnchor.constraint(equalTo: tabView.topAnchor, constant: 20).isActive = true
           return cv
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = Int ()
        addCollectionView();
       // setUpFSCalendar();
        lblDepartmentName.text=departmentDetails.deptname
       // getHolidays()
        getDates(row_index: 0)
        noSlotsAvailable()
    }

    func getDates(row_index:Int) {
        var sema = DispatchSemaphore( value: 0 )

        self.arraySlotDates.removeAll()

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let dateStr = formatter.string(from: date)
        
       let todayList = DateSlotDetails(app_date: dateStr, t_app: "", book_app: "", avl_app: "")
        self.arraySlotDates.append(todayList)

        getSlots(date: dateStr,deptUnitCode: departmentDetails.actualparameterreferenceid)

        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        
        let url2 = "\(ServiceUrl.getSlotsDateServer)\(obj!.hospCode)&pParaRefId=\(self.departmentDetails.actualparameterreferenceid)"
        let url = URL(string:url2)
        print("slot_url \(url2)")
        
//        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
//        urlSession.dataTask(with: url!) { (data, response, error) in
         
      //  let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                
                if json["status"].stringValue=="1"  {
                    let appointmentData=json["data"].array
                    let jsonn =   JSON(appointmentData ?? "")
                for arr in jsonn.arrayValue{
                    self.arraySlotDates.append(DateSlotDetails(json: arr))
                }
                }else{
                    self.alert(title: "Info", message: "Slot not available!")
                }
                print("self_arraySlotDates--\(self.arraySlotDates)")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.view.activityStopAnimating()
                }
            
            }catch{
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.view.activityStopAnimating()
                }
                print(error.localizedDescription)
            }
            }.resume()

        }
    
    @IBAction func btnConfirm(_ sender: Any) {
        let appopointmentDetails="Appointment request for "+self.patientDetails.firstName+" "+self.patientDetails.lastName+" ("+patientDetails.gender+"/"+patientDetails.age+") "+" in "+self.departmentDetails.deptname+" on "+arAppointmentSlotDetails[0].date+"."
        
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Confirm", message: appopointmentDetails+"\n\nDo you want to proceed?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: { [] (_) in
       
        
            self.bookAppointment(firstName: self.patientDetails.firstName,
                        middleName: "",
                        lastName: self.patientDetails.lastName,
                        age: self.patientDetails.age,
                        patAgeUnit: "Yr",
                        fatherName: self.patientDetails.fatherName,
                        spouseName: self.patientDetails.spouseName,
                        mobileNo: self.patientDetails.mobileNo,
                        email: self.patientDetails.email,
                        remarks: "",
                        genderId: self.patientDetails.gender,
                        departmentUnitCode: self.departmentDetails.unitcode,
                        departUnitName: self.departmentDetails.deptname, departLocation: self.departmentDetails.loCode, shiftId: self.arAppointmentSlotDetails[0].shift,
                        shiftSt: self.arAppointmentSlotDetails[0].shiftst,
                        shiftet: self.arAppointmentSlotDetails[0].shiftet,
                        slotSt: self.arAppointmentSlotDetails[0].slotst,
                        slotEt: self.arAppointmentSlotDetails[0].slotet,
                        actualparameterreferenceid: self.departmentDetails.actualparameterreferenceid,
                        appointmentDate: self.arAppointmentSlotDetails[0].date,
                        crno:self.patientDetails.crno,
                                 tariff_id: self.departmentDetails.tariffId,
                                 payment_type: "3",
                                 payment_fee: self.departmentDetails.charge
                                 
            );
            
           

        }
        ))
            
           
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    private func bookAppointment( firstName: String,  middleName: String,  lastName: String,  age: String,  patAgeUnit: String,  fatherName: String,  spouseName: String,  mobileNo: String,  email: String,  remarks: String,  genderId: String,  departmentUnitCode: String,  departUnitName: String,  departLocation: String,  shiftId: String,  shiftSt: String,  shiftet: String,  slotSt: String,  slotEt: String,  actualparameterreferenceid: String,  appointmentDate: String,  crno:String,  tariff_id:String,  payment_type:String,  payment_fee:String)
 
    {
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")

        
        let url = URL(string: ServiceUrl.makeAppointment)
       
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
           
"appointmentForId":"1",
"patFirstName":firstName,
"patMiddleName":middleName,
"patLastName":"",
"patGuardianName":fatherName,
"patSpouseName":spouseName,
"patDOB":"",
"appointmentDate":appointmentDate,
"emailId":email,
"mobileNo":mobileNo,
"appointmentTime":slotSt,
"appointmentStatus":"1",
"slotType":"3",
"remarks":remarks,
"appointmentTypeId":"1",
"appointmentMode":"13",
"patAgeUnit":patAgeUnit,
"patAge":age,
"patGenderCode":genderId,
"allActualParameterId":"",
"shiftId":shiftId,
"slotST":slotSt,
"slotET":slotEt,
"actualParameterReferenceId":actualparameterreferenceid,
"shiftST":shiftSt,
"shiftET":shiftet,
"hcode":obj!.hospCode,
"deptUnitCode":departmentUnitCode,
"deptUnitName":departUnitName,
"deptLocation":departLocation,
"patCrNo":crno,
"tariff_id":tariff_id,
"payment_type":payment_type,
"payment_fee":payment_fee,
"payment_ref_no":"",
"transaction_id":"",
"is_fees_paid":"0"

        ]
        print("parameters--\(parameters)")
        
        request.httpBody = parameters.percentEncoded()
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                
               // print(data)
                let status = json["SUCCESS"].stringValue
                print("status :::: \(status)")
                
                if status=="true"
                {
                    //TODO call crlist webservice
                    print(json["APPTNO"].stringValue)
                   let appointmentNo = json["APPTNO"].stringValue
                    
                    
                    
                    
//                    let patName=json["patName"].stringValue
//                    let crno  = json["CrNo"].stringValue
//                    let gender = json["patGender"].stringValue
//                    let age = json["patAge"].stringValue
                    
                    DispatchQueue.main.async {
                       
                    
//                    let viewController:AppointmentSummaryViewController = self.storyboard!.instantiateViewController(withIdentifier: "AppointmentSummaryViewController") as! AppointmentSummaryViewController

                        let viewController:AppointmentSummaryViewController = (UIStoryboard.init(name: "Appointment", bundle: Bundle.main).instantiateViewController(withIdentifier: "AppointmentSummaryViewController") as? AppointmentSummaryViewController)!
                        
                    viewController.patName = firstName+" "+lastName
                    viewController.crno = crno
                    viewController.gender = genderId
                    viewController.age = age
                        
                        viewController.departUnitName = departUnitName
                        viewController.slotSt = slotSt
                        viewController.slotEt = slotEt
                        viewController.appointmentNo = appointmentNo
                        viewController.appointmentDate =  appointmentDate
                        
                        
                    self.navigationController!.show(viewController, sender: self)
                    
                        
                    }
                    
                    
                    
                }
                else{
                    var message = json["msg"].stringValue
                    if(message.trimmingCharacters(in: .whitespacesAndNewlines).count == 0){
                        message = "Unable to make appointment.Please try again later."
                    }
                    
                    self.alert(title: "Info!", message:message)
                    
                }
               
                
                
            }catch{
                print("sudeep"+error.localizedDescription)
            }
            }.resume()
    }
    
    
    
    
    func getSlots(date:String,deptUnitCode:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        arAppointmentSlotDetails.removeAll()
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let url2 = "\(ServiceUrl.shiftNameurl)hospCode=\(obj!.hospCode)&aptDate=\(date)&deptUnitCode=\(deptUnitCode)"
        print("url_appointment \(url2)")

        let url = URL(string: url2)
       // let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
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
                    print("GETSLOTSTATUS \(arr["GETSLOTSTATUS"])")
                if(arr["GETSLOTSTATUS"]=="1")
                    {
                    self.arAppointmentSlotDetails.append(AppointmentSlotModel(json: arr))
                }
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

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
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
                            //self.setDateCollectionViewData();
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
    
    
    
    
    
    
 /*   private func setDateCollectionViewData()
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
      
        let dateStr = formatter.string(from: date)

        let calendar = Calendar(identifier: .gregorian)
       
        
        let totalDays = Date().getDaysInMonth();
        print("totalDays \(totalDays)")
        if let currDate = formatter.date(from: dateStr) {
            for i in 0..<120 {
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
                    
                    getSlots(date: formatter.string(from: date),deptUnitCode: departmentDetails.actualparameterreferenceid)
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
    } */
    
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
    
}
















    extension OPDSlotSelectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/5)
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arraySlotDates.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
            
             cell.data = self.arraySlotDates[indexPath.item]
            if(indexPath.row==0){
                cell.bg.text = "Today, "+self.arraySlotDates[indexPath.row].app_date
            }else{
                cell.bg.text = self.arraySlotDates[indexPath.row].app_date

            }
            cell.bg.textAlignment = .center
            print("indexPath.row-\(indexPath.item)")
            
            if selectedIndex == indexPath.row{
                selectedCellState(cell: cell)
             }else{
                defaultCellState(cell: cell)
             }
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            selectedIndex = indexPath.row
            lblDateHeader.text=self.arraySlotDates[indexPath.item].app_date

            
            getSlots(date: self.arraySlotDates[indexPath.item].app_date,deptUnitCode: departmentDetails.actualparameterreferenceid)
           
                
            print("hello "+appointmentSlotDetails.date+" "+departmentDetails.actualparameterreferenceid+" \(indexPath.item)")
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
        
        private func defaultCellState(cell:CustomCell)
        {
            cell.bg.backgroundColor = UIColor.systemGray
            cell.bg.layer.borderColor = UIColor.lightGray.cgColor
            cell.bg.layer.borderWidth = 1.0
            cell.bg.layer.cornerRadius = 10.0
        }
        
        private func selectedCellState(cell:CustomCell)
        {
           // cell.bg.backgroundColor = UIColor(rgb: 0xeffefb)
            //cell.bg.layer.borderColor = UIColor(rgb: 0xa6e1f1).cgColor
            cell.bg.layer.borderWidth = 2.0
            cell.bg.layer.cornerRadius = 10.0
        }
        
        
        
        
    }


    class CustomCell: UICollectionViewCell {
        
        var data: DateSlotDetails? {
            didSet {
                guard let data = data else { return }
//                bg.image = data.backgroundImage
                bg.text=data.app_date;
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

