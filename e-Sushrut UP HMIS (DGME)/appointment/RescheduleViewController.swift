//
//  RescheduleViewController.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 21/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit
//import FSCalendar


class RescheduleViewController: UIViewController, URLSessionDelegate {
    var myAppointmentDetails=PreviousAppointmentModel()
    var selectedIndex = Int ()
   // fileprivate weak var calendar: FSCalendar!
    var arHoliday=[String]()
    
    @IBOutlet weak var btnConfirm: UIButton!
   
    var appointmentSlotDetails=ShiftDetails()
    var arAppointmentSlotDetails=[ShiftDetails]()
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var imgStatus: UIImageView!
    
    
    @IBOutlet weak var lblDepartmentName: UILabel!
    
    @IBOutlet weak var lblSlotsAvailable: UILabel!
    
    
    @IBOutlet weak var lblDateHeader: UILabel!
    
    var arraySlotDates = [DateSlotDetails]()
    
    fileprivate var data:[DateSlotDetails] = []
       fileprivate let collectionView:UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
           return cv
       }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = Int ()
        addCollectionView();
       // setUpFSCalendar();
        lblDepartmentName.text=myAppointmentDetails.actulaparaname1
        print("myAppointmentDetails   \(myAppointmentDetails)")
       // getHolidays()
        //noSlotsAvailable()
        getDates(row_index: 0)
    }
    
    func getDates(row_index:Int) {
        self.arraySlotDates.removeAll()

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let dateStr = formatter.string(from: date)
        
       let todayList = DateSlotDetails(app_date: dateStr, t_app: "", book_app: "", avl_app: "")
        self.arraySlotDates.append(todayList)

        getSlots(date: dateStr,deptUnitCode: self.myAppointmentDetails.actualParaRefId)

        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let url2 = "\(ServiceUrl.getSlotsDateServer)\(obj!.hospCode)&pParaRefId=\(self.myAppointmentDetails.actualParaRefId)"
        let url = URL(string:url2)
        print("slot_url \(url2)")
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        urlSession.dataTask(with: url!) { (data, response, error) in
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
    
    
    
    @IBAction func btnSelectDateFromCalendar(_ sender: Any) {
      //  self.calendar.isHidden=false
    }
    
    
    
    @IBAction func btnConfirm(_ sender: Any) {

        
        let appointmentDetails = myAppointmentDetails.patfirstname+" "+myAppointmentDetails.patlastname+" ("+myAppointmentDetails.patgendercode+"/"+myAppointmentDetails.patage+") in "+myAppointmentDetails.actulaparaname1+"  on "+arAppointmentSlotDetails[0].date+" ."
       
        
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Confirm", message: appointmentDetails+"\n\nDo you want to proceed?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: { [] (_) in
            self.bookAppointment();
        }
        ))
            
           
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    private func bookAppointment( )
    {
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let age = myAppointmentDetails.patage.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
        let url = URL(string: ServiceUrl.rescheduleappointmenturl)
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
       
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "appointmentNo": myAppointmentDetails.appointmentno,
                          "appointmentQueueNo": myAppointmentDetails.appointmentqueueno,
                          "appointmentForId": "1",
                          "patFirstName": myAppointmentDetails.patfirstname,
                          "patMiddleName": myAppointmentDetails.patmiddlename,
                          "patLastName": myAppointmentDetails.patlastname,
                          "patGuardianName": myAppointmentDetails.patguardianname,
                          "patSpouseName": myAppointmentDetails.patspousename,
                          "patDOB": "",
            "appointmentDate": arAppointmentSlotDetails[0].date,
                          "emailId": myAppointmentDetails.emailid,
                          "mobileNo": myAppointmentDetails.mobileno,
            "appointmentTime": arAppointmentSlotDetails[0].slotst,
                          "appointmentStatus": "2",
                          "slotType": "3",
                          "remarks": myAppointmentDetails.remarks,
                          "appointmentTypeId": "1",
                          "appointmentMode": "13",
                          "patAgeUnit": "Yr",
                            "patAge": age,
                          "patGenderCode": myAppointmentDetails.patgendercode,
                          "allActualParameterId": "",
                          "shiftId": arAppointmentSlotDetails[0].shift,
                          "slotST": arAppointmentSlotDetails[0].slotst,
                          "slotET": arAppointmentSlotDetails[0].slotet,
                          "shiftST": arAppointmentSlotDetails[0].shiftst,
                          "shiftET": arAppointmentSlotDetails[0].shiftet,
            "hcode": obj!.hospCode,
            "patCrNo": myAppointmentDetails.patcrno

        ]
        print("parameters :::: \(ServiceUrl.rescheduleappointmenturl)----\(parameters)")
        request.httpBody = parameters.percentEncoded()
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        
    urlSession.dataTask(with: request) { (data, response, error) in
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

                    DispatchQueue.main.async {
                       
                    
                    let viewController:RescheduleSummaryViewController = self.storyboard!.instantiateViewController(withIdentifier: "RescheduleSummaryViewController") as! RescheduleSummaryViewController

                        
                        viewController.patName = self.myAppointmentDetails.patfirstname+" "+self.myAppointmentDetails.patlastname
                        viewController.crno = self.myAppointmentDetails.patcrno
                        viewController.gender = self.myAppointmentDetails.patgendercode
                        viewController.age = self.myAppointmentDetails.patage
                        
                        
                        
                        viewController.departUnitName = self.myAppointmentDetails.actulaparaname1
                        viewController.slotSt = self.arAppointmentSlotDetails[0].slotst
                        viewController.slotEt = self.arAppointmentSlotDetails[0].slotet
                        viewController.appointmentNo = appointmentNo
                        viewController.appointmentDate =  self.arAppointmentSlotDetails[0].date
                        viewController.appointmentNo = appointmentNo
                    
                        
                    self.navigationController!.show(viewController, sender: self)
                    
                        
                    }
                    
                    
                    
                }
                else{
   
                    self.alert(title: "", message:"Unable to reschedule appointment.Please try again later.")
                    
                }
               
                
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
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
        
        //let url = URL(string: ServiceUrl.getAppointmentSlots+date+"&deptUnitCode="+deptUnitCode)
        let url = URL(string: url2)
       // print(url)
        print("url_rescheduled"+url2)
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
                       
                    self.appointmentSlotDetails=ShiftDetails(json: jsonn.arrayValue[0])
                        
                    }
                for arr in jsonn.arrayValue{
                    if(arr["GETSLOTSTATUS"]=="1"){
                    self.arAppointmentSlotDetails.append(ShiftDetails(json: arr))
                    }
                }
                }else{
                    //no slots available
                    self.noSlotsAvailable()
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
//                 self.arrData=self.generalData
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
     let today = Date()
     let nextFollowingSundays = today.nextFollowingSundays(52)
     nextFollowingSundays.forEach { sunday in sunday
         let today = sunday
                           let formatter = DateFormatter()
//                       formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateFormat = "dd-MMM-yyyy"
                    let todaysDateString = formatter.string(from: today)
         arHoliday.append(todaysDateString)
 //        print(todaysDateString)
     }
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
                           // self.setDateCollectionViewData();
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
    
    
    
    
    
    
   /* private func setDateCollectionViewData()
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
      
        let dateStr = formatter.string(from: date)

        let calendar = Calendar(identifier: .gregorian)
        if let currDate = formatter.date(from: dateStr) {
            for i in 0..<10 {
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
                    
                    getSlots(date: formatter.string(from: date),deptUnitCode: myAppointmentDetails.actualParaRefId)
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
    
    
    
    
    
   
     
     
     
     
     
/*    private func setUpFSCalendar()
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

            getSlots(date: formatter.string(from: date),deptUnitCode: myAppointmentDetails.actulaparaid1)
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
     }*/
    
    
    
    func alert(title:String,message:String)  {
        DispatchQueue.main.async {
           
        let alertController = UIAlertController(title: title, message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    
    
   
    
}
















    extension RescheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/5)
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.arraySlotDates.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
           // cell.data = self.data[indexPath.item]
            cell.data = self.arraySlotDates[indexPath.item]
           if(indexPath.row==0){
               cell.bg.text = "Today, "+self.arraySlotDates[indexPath.row].app_date
           }else{
               cell.bg.text = self.arraySlotDates[indexPath.row].app_date

           }
           cell.bg.textAlignment = .center
           print("indexPath.row-\(indexPath.item)")
            
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
            lblDateHeader.text=self.arraySlotDates[indexPath.item].app_date
            
            
            
            getSlots(date: self.arraySlotDates[indexPath.item].app_date,deptUnitCode: myAppointmentDetails.actualParaRefId)
           
                
            print("hello "+appointmentSlotDetails.date+" "+appointmentSlotDetails.slotst)
            print(myAppointmentDetails.actulaparaid1)
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
//
//            if myAppointmentDetails.appointmentdate==appointmentSlotDetails.date
//            {
//                noSlotsAvailable()
//            }
                
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
         //   cell.bg.backgroundColor = UIColor(rgb: 0xeffefb)
          //  cell.bg.layer.borderColor = UIColor(rgb: 0xa6e1f1).cgColor
            cell.bg.layer.borderWidth = 2.0
            cell.bg.layer.cornerRadius = 10.0
        }
        
        
        
        
    }


  
