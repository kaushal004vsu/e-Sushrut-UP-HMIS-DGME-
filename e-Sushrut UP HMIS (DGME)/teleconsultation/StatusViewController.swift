//
//  StatusViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 29/09/22.
//

import UIKit
import JitsiMeetSDK

class StatusViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    struct Category {
        let name : String
        var items : [UpcomingModel]
    }
    @IBOutlet weak var patien_header_stack: UIStackView!
    @IBOutlet weak var patient_name: UILabel!
    @IBOutlet weak var cr_no: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    fileprivate var jitsiMeetView: JitsiMeetView?
    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    
    var sec = 100

    @IBOutlet weak var reqListTableView: UITableView!
   
    var upcomingArrayList = [UpcomingModel]()
      var pastArrayList = [UpcomingModel]()
      var arrStatusModel=[StatusModel]()
    var searchArrRes = [[String:Any]]()
    var searching:Bool = false
    
    //
    var sections = [Category]()
    //////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showInternetAlert()
        hideKeyboardWhenTappedAround()
        //Assign delegate  don't forget
        txtName.delegate = self
        reqListTableView.delegate = self
        reqListTableView.dataSource = self
       // reqListTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        patien_header_stack.layer.cornerRadius = 10
        patient_name.text = obj?.firstName
        cr_no.text = obj?.crno
        getRequestList()
        //getRequestList();
//        self.reqListTableView.estimatedRowHeight = 100
//            self.reqListTableView.rowHeight = UITableView.automaticDimension
       // reqListTableView.estimatedRowHeight = 300
    }
    
    func getRequestList(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
         //  let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
           
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")

           let url = URL(string: ServiceUrl.viewRequestListByPatMobNo + obj!.mobileNo + "&userId=" + "0")
           print("gerReq \(ServiceUrl.viewRequestListByPatMobNo + obj!.mobileNo + "&userId=" + "0")")
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               guard let data = data else { return }
               do{
                   let json = try JSON(data:data)
                   self.arrStatusModel.removeAll();
                   let status=json["Status"].stringValue
                   
                   let jarr=json["Data"]
                   print(jarr.stringValue)
                   for arr in jarr.arrayValue{
                      if jarr.count==0
                      {
                          self.alert(title: "", message: "No Result Found!")
                      }else{
                          self.arrStatusModel.append(StatusModel(json: arr))
                          
                      }
                   }
                  
                   
                   DispatchQueue.main.async { [self] in
                       self.view.activityStopAnimating()
                       print("arrStatusModel:: \(self.arrStatusModel.count)")
                       for group in arrStatusModel {
                           
                           if(obj!.crno == group.crNo){
                              print("my crno\(obj!.crno) list crno  \(group.crNo)")
                                   let today = Date()
                                   let formatter = DateFormatter()
                                   formatter.dateFormat = "yyyy-MM-dd"
                                   let todayDate = formatter.string(from: today)
                                   
                                   let dateFormatter = DateFormatter()
                                   dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                   let someDate = dateFormatter.date(from: group.apptDate)
                                   dateFormatter.dateFormat = "yyyy-MM-dd"
                                   
                                   let appointmentDate = formatter.string(from: someDate!)
                                  
                                   if (appointmentDate < todayDate || group.requestStatus == "2") {
                                       print("past appointmentDate \(appointmentDate) , todayDate \(todayDate) requestStatus\(group.requestStatus)" )
                                       self.pastArrayList.append((UpcomingModel(requestID: group.requestID, CRNo: group.crNo, scrResponse: group.scrResponse, consName: group.consName, deptUnitCode: group.deptUnitCode, deptUnitName: group.deptUnitName, hospCode: group.hospCode, requestStatus: group.requestStatus, patMobileNo: group.patMobileNo, consMobileNo: group.consMobileNo, patDocs: group.patDocs, docMessage: group.docMessage, cnsltntId: group.cnsltntId, patName: group.patName, patAge: group.patAge, patGender: group.patGender, rmrks: group.rmrks, email: group.email, date: group.date, patWeight: group.patWeight, patHeight: group.patHeight, patMedication: group.patMedication, patPastDiagnosis: group.patPastDiagnosis, patAllergies: group.patAllergies, deptName: group.deptName, deptCode: group.deptCode, appointmentNo: group.appointmentNo, apptStartTime: group.apptStartTime, apptEndTime: group.apptEndTime, apptDate: group.apptDate, hospitalName: group.hospitalName, isEpisodeExist: group.isEpisodeExist, episodeCode: group.episodeCode, episodeVisitNo: group.episodeVisitNo, requestStatusCompleteDate: group.requestStatusCompleteDate, requestStatusCompleteMode: group.requestStatusCompleteMode, isPast: true, patientToken: group.patientToken, doctorToken: group.doctorToken, consultationTime: group.consultationTime)))
                                       } else {
                                           print("upcoming appointmentDate \(appointmentDate) , todayDate \(todayDate) requestStatus\(group.requestStatus)" )
                                        self.upcomingArrayList.append((UpcomingModel(requestID: group.requestID, CRNo: group.crNo, scrResponse: group.scrResponse, consName: group.consName, deptUnitCode: group.deptUnitCode, deptUnitName: group.deptUnitName, hospCode: group.hospCode, requestStatus: group.requestStatus, patMobileNo: group.patMobileNo, consMobileNo: group.consMobileNo, patDocs: group.patDocs, docMessage: group.docMessage, cnsltntId: group.cnsltntId, patName: group.patName, patAge: group.patAge, patGender: group.patGender, rmrks: group.rmrks, email: group.email, date: group.date, patWeight: group.patWeight, patHeight: group.patHeight, patMedication: group.patMedication, patPastDiagnosis: group.patPastDiagnosis, patAllergies: group.patAllergies, deptName: group.deptName, deptCode: group.deptCode, appointmentNo: group.appointmentNo, apptStartTime: group.apptStartTime, apptEndTime: group.apptEndTime, apptDate: group.apptDate, hospitalName: group.hospitalName, isEpisodeExist: group.isEpisodeExist, episodeCode: group.episodeCode, episodeVisitNo: group.episodeVisitNo, requestStatusCompleteDate: group.requestStatusCompleteDate, requestStatusCompleteMode: group.requestStatusCompleteMode, isPast: false, patientToken: group.patientToken, doctorToken: group.doctorToken, consultationTime: group.consultationTime)))
                                       }
                                   
                          }
                        
                       }
                       
                       //print("upcomingArrayList  \(upcomingArrayList)")
                       //my array
                       sections = [
                           Category(name:"Upcoming", items:upcomingArrayList),
                           Category(name:"Past", items:pastArrayList)
                       ]
                       
                       DispatchQueue.main.async {
                      // self.reqListTableView.backgroundView=self.lblNoReportsFound
                           if(upcomingArrayList.count == 0 && pastArrayList.count == 0){
                               self.alert(title: "No Record Found!", message: "No Request Status found for the selected patient.")
                           }else{
                               self.reqListTableView.separatorStyle = .singleLine
                               self.reqListTableView.reloadData()
                           }
                     
                       }
                   }
                   
               }catch{
                   print("error:: "+error.localizedDescription)
               }
               }.resume()
       }
    func alert(title:String,message:String)
       {
           DispatchQueue.main.async {
              
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
               //                print("Handle Ok logic here")
               self.navigationController?.popToRootViewController(animated: true)
           })
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
               
           }
       }
    
    // MARK: - TableView Delegate & DataSource
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           guard let tableView = view as? UITableViewHeaderFooterView else { return }
           // tableView.backgroundView?.backgroundColor = UIColor.black
           tableView.textLabel?.textColor = UIColor.red
       }
   
//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
//        //input text
////        let searchText  = textField.text! + string
////        //add matching text to arrya
////        searchArrRes = self.pastArrayList.filter({(($0.consName as! String).localizedCaseInsensitiveContains(searchText))})
////
////
////        if(searchArrRes.count == 0){
////            searching = false
////        }else{
////            searching = true
////        }
////        self.reqListTableView.reloadData();
//
//        return true
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if( searching == true){
            return 2
        }
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if( searching == true){
            return ""
        }
        return self.sections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( searching == true){
           return searchArrRes.count
        }else{
            let items = self.sections[section].items
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StatusTableViewCell

        //  var dict = itemsA[indexPath.section]
        
        if( searching == true){
            var dict = searchArrRes[indexPath.row]
            cell.request_status_lbl.text = dict["name"] as? String
            cell.consultant_name_lbl.text = dict["number"] as? String
        }else{
            let items = self.sections[indexPath.section].items
            let item = items[indexPath.row]
            self.sec = indexPath.section
            print("isPast \(indexPath.row) --- \(indexPath.section)")
            cell.request_status_lbl.text =  item.requestStatus
            cell.consultant_name_lbl.text = "Your Appointment with " + item.consName
            cell.dept_name_lbl.text = item.hospitalName
            cell.unitname_lbl.text = item.deptUnitName
            
//            cell.view_prescription_lbl.isHidden = true
            cell.request_date_lbl.text = "\(item.requestID)/\(item.date)"
            
            cell.join_call_lbl.isHidden = true
            cell.unatteneded_msg_lbl.isHidden = true
            cell.consultation_time_lbl.isHidden = true
            cell.btnView_prescription_lbl.isHidden = true
            
//            cell.join_call_lbl.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive = true
//            cell.unatteneded_msg_lbl.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive = true
//            cell.consultation_time_lbl.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive = true
            
            //print("isPast \(item.isPast)")
            
            if (item.docMessage == "") {
                cell.btnDoc_message.isHidden = true
            }else{
                cell.btnDoc_message.isHidden = false
            }
            
            if (item.requestStatus == "2") {
                cell.btnRateUs.isHidden = false
            }else{
                cell.btnRateUs.isHidden = true
            }
            
            if (item.requestStatus == "0") {
                cell.request_status_lbl.text = ""
                cell.request_status_lbl.isHidden = true
                if (item.isPast) {
                    cell.request_status_lbl.isHidden = false
                    cell.request_status_lbl.text = "Unattended"
                    cell.request_status_lbl.textColor = UIColor(named: "unattended_lbl");
                    cell.unatteneded_msg_lbl.isHidden = false
                } else {
                    cell.unatteneded_msg_lbl.isHidden = true
                }
                cell.request_status_lbl.textColor = UIColor(named: "unattended_lbl")
                //cell.request_status_lbl.textColor = .systemYellow
                } else if (item.requestStatus == "1") {
                    cell.request_status_lbl.text = "Approved"
                    cell.request_status_lbl.textColor = .systemGreen
                    cell.request_status_lbl.textColor = UIColor(named: "approved_lbl")
                    cell.join_call_lbl.isHidden = false
                            //enableVideoCall(healthWorkerRequestListDetails.getDocMessage());
                            cell.join_call_lbl.isHidden = false
                            if (item.isPast) {
                                cell.request_status_lbl.text = "Unattended"
                                //cell.request_status_lbl.textColor = .systemYellow
                                cell.request_status_lbl.textColor = UIColor(named: "unattended_lbl")
                                cell.unatteneded_msg_lbl.isHidden = false
                            }
                    
                    cell.consultation_time_lbl.text = item.consultationTime
                    if(cell.consultation_time_lbl.text == "Join Call"){
                        cell.consultation_time_lbl.isHidden = true
                        cell.join_call_lbl.isHidden = false
                    }else{
                        cell.consultation_time_lbl.isHidden = false
                        cell.join_call_lbl.isHidden = true
                    }
                    cell.consultant_name_lbl.isHidden = false
                }else if(item.requestStatus == "2"){
                    cell.request_status_lbl.text = "Completed"
                    cell.request_status_lbl.textColor = UIColor(named: "completed_lbl")
                    cell.consultant_name_lbl.isHidden = false
                    cell.btnView_prescription_lbl.isHidden = false
                }else if(item.requestStatus == "4"){
                    cell.request_status_lbl.text = "Rejected"
                    cell.request_status_lbl.textColor = .red
                    cell.consultant_name_lbl.isHidden = false
                }
            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//
//            let someDate = dateFormatter.date(from: item.apptDate)
//            dateFormatter.dateFormat = "EEE, dd MMM"
//
//            let formatter = DateFormatter()
//            let date2 = formatter.string(from: someDate ?? Date())
//            cell.appointment_date_lbl.text = date2
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "EEE, dd MMM"

            let date: NSDate? = dateFormatterGet.date(from: item.apptDate) as NSDate?
           // print(dateFormatterPrint.string(from: date! as Date))
            if date != nil {
                cell.appointment_date_lbl.text = dateFormatterPrint.string(from: date! as Date)
            }
            
            

            
            cell.join_call_lbl.tag = indexPath.row
            cell.join_call_lbl.addTarget(self,action:#selector(joinCall(sender:)), for: .touchUpInside)
            
            cell.btnDoc_message.tag = indexPath.row
            cell.btnDoc_message.addTarget(self,action:#selector(sendMessage(sender:)), for: .touchUpInside)
            
            cell.btnRateUs.tag = indexPath.row
            cell.btnRateUs.addTarget(self,action:#selector(rateUs(sender:)), for: .touchUpInside)
            //cell.btnRateUs.frame.name = "myParameter"
            cell.btnRateUs.tag = indexPath.row
            
            cell.btnView_prescription_lbl.tag = indexPath.row
            cell.btnView_prescription_lbl.addTarget(self,action:#selector(viewPrescription(sender:)), for: .touchUpInside)
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StatusTableViewCell
       
        print("You tapped table view cell index is \(indexPath.section).")
        let items = self.sections[indexPath.section].items
        let item = items[indexPath.row]
        if (item.requestStatus == "0" && item.isPast != true) {
            alert(title: "Info", message: "Show")
        }
        self.scrollToTop()

    }
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0);
        self.reqListTableView.scrollToRow(at: topRow, at: .top, animated: true)
       }
  

    @objc func joinCall(sender:UIButton) {
            let buttonRow = sender.tag
                let items = self.sections[sec].items
                let item = items[buttonRow]
        makeJitsiCall(requestID:item.requestID,patName:item.patName);
    }
    func makeJitsiCall(requestID:String,patName:String){
        cleanUp()
               // create and configure jitsimeet view
                       let jitsiMeetView = JitsiMeetView()
                       jitsiMeetView.delegate = self
                       self.jitsiMeetView = jitsiMeetView
                       let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                          // builder.welcomePageEnabled = true
                           builder.serverURL = URL(string: ServiceUrl.jitsiUrl)
                           builder.room = requestID
                           builder.setSubject(patName)
                       }
                       jitsiMeetView.join(options)
                       // Enable jitsimeet view to be a view that can be displayed
                       // on top of all the things, and let the coordinator to manage
                       // the view state and interactions
                       pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
                       pipViewCoordinator?.configureAsStickyView(withParentView: view)

                       // animate in
                       jitsiMeetView.alpha = 0
                       pipViewCoordinator?.show()
    }
    fileprivate func cleanUp() {
        jitsiMeetView?.removeFromSuperview()
        jitsiMeetView = nil
        pipViewCoordinator = nil
    }
   
    @objc func sendMessage(sender:UIButton) {
            let buttonRow = sender.tag
        
        let vc = (UIStoryboard.init(name: "teleconsultation", bundle: Bundle.main).instantiateViewController(withIdentifier: "PatientMessageViewController") as? PatientMessageViewController)!
        let items = self.sections[sec].items
        let item = items[buttonRow]
        vc.arrData=item
        print("buttonRow----\(buttonRow)---\(item.requestID)---\(sec)")
//        vc.requestId = item.requestID
//        vc.hospCode = item.hospCode
        self.navigationController!.pushViewController( vc, animated: true)
    }
    @objc func rateUs(sender:UIButton) {
            let buttonRow = sender.tag
 
        print("sectionn  \(sec)")
        let items = self.sections[sec].items
        let item = items[buttonRow]
        
        let vc = (UIStoryboard.init(name: "teleconsultation", bundle: Bundle.main).instantiateViewController(withIdentifier: "RatingViewController") as? RatingViewController)!
        vc.requestId = item.requestID
        vc.hopCode = item.hospCode
        self.navigationController!.pushViewController( vc, animated: true)
//            if arrData[buttonRow].requestStatus == "0"
//                {
//                    showPopup(parentVC: self,arrData: arrData[buttonRow])
//                    }
    }
    
    @objc func viewPrescription(sender:UIButton) {
            let buttonRow = sender.tag
        
//        let viewController:ViewRxViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewRxViewController") as! ViewRxViewController
//        viewController.arrData=arrData[indexPath.row]
//        self.navigationController!.show(viewController, sender: self)
        let items = self.sections[sec].items
        let item = items[buttonRow]
        let vc = (UIStoryboard.init(name: "teleconsultation", bundle: Bundle.main).instantiateViewController(withIdentifier: "PrescriptionViewController") as? PrescriptionViewController)!
        vc.requestStatusCompleteMode = item.requestStatusCompleteMode
        vc.entryDate = item.date
        vc.hospCode = item.hospCode
        vc.episodecode = item.episodeCode
        vc.visitNo = item.episodeVisitNo
        vc.CRNo = item.CRNo
        vc.requestID = item.requestID
        self.navigationController!.pushViewController( vc, animated: true)
    }
    func showInternetAlert() {
           if !AppUtilityFunctions.isInternetAvailable() {
               self.inernetAlert(title: "Warning",message: "The Internet is not available")
           }
       }

   func inernetAlert(title:String,message:String)
       {
           DispatchQueue.main.async {
              
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
               self.navigationController?.popToRootViewController(animated: true)
           })
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
               
           }
       }
}
extension StatusViewController: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.hide() { _ in
                self.cleanUp()
            }
        }
    }

    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}
