//  AppointmentStatusViewController.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 16/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
class AppointmentStatusViewController: UIViewController,URLSessionDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet var lblNoRecordsFound: UILabel!
    
    @IBOutlet weak var txtSelectPatient: UITextField!
    
    
    @IBOutlet weak var appointmentStatusTableView: UITableView!
    
    var allData=[PreviousAppointmentModel]()
    var selectPatientPicker = UIPickerView()
    
    
    var arRegisteredPatients=[PatientDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        
        
        
        
        appointmentStatusTableView.rowHeight = UITableView.automaticDimension
        appointmentStatusTableView.estimatedRowHeight = 44
        
        
        selectPatientPicker.delegate=self
        selectPatientPicker.dataSource=self
        txtSelectPatient.inputView = selectPatientPicker
     //   let mobileNo =  UserDefaults.standard.string(forKey:"udMobileNo");
        
        
       // getCrList(mobileNo: mobileNo!)
        
        
        //To retrieve the saved object
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        
//        print("hello"+obj!.crno)
    //    self.setDefaultValue(item: obj ?? PatientDetails(), inComponent: 0)
        
        
            txtSelectPatient.text = obj!.firstName+" "+obj!.lastName+" ("+obj!.crno+")"
        
        getPreviousAppointments(crno: obj!.crno);
        
    }
    
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            
          
                 return arRegisteredPatients.count
            }

        
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            
            return arRegisteredPatients[row].firstName+" "+arRegisteredPatients[row].lastName+" ("+arRegisteredPatients[row].crno+")"
   
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
//            txtSelectPatient.text = arRegisteredPatients[row].firstName+" "+arRegisteredPatients[row].lastName+" ("+arRegisteredPatients[row].crno+")"
               
            //getPreviousAppointments(crno: arRegisteredPatients[row].crno);
            
            
            self.view.endEditing(false)
        }
    
    
    
 
    func getPreviousAppointments(crno:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
                let url = URL(string: ServiceUrl.getPreviousAppointmentsByCRNoUrl+crno )
        
        
        allData.removeAll();
    print("jsonParsing::::\(ServiceUrl.getPreviousAppointmentsByCRNoUrl+crno)")
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
               
//print(url)
        urlSession.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                return }
            do{
                let json = try JSON(data:data)
                print(data)
                
                
                let status = json["status"].stringValue
                if status=="1"
                {
                    let jsonArray=json["appointments_list"].array;
                    let jsonn =   JSON(jsonArray!)
                    for arr in jsonn.arrayValue{
                    self.allData.append(PreviousAppointmentModel(json: arr))
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                            
                        }
                }
                
                
                print("knsknkds\(self.allData)")
                DispatchQueue.main.async {
                    self.appointmentStatusTableView.backgroundView=nil
                    self.appointmentStatusTableView.separatorStyle = .singleLine
                    self.appointmentStatusTableView.reloadData()
                    self.view.activityStopAnimating()

                }
                }
                else{
                  //for no appointments
                    DispatchQueue.main.async {
                        self.appointmentStatusTableView.backgroundView=self.lblNoRecordsFound
                        self.appointmentStatusTableView.separatorStyle = .none
                        self.appointmentStatusTableView.reloadData()
                        self.view.activityStopAnimating()

                    }
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
                }
                print("response")
            }catch{
                print("error")
                print(error.localizedDescription)
            }
            }.resume()
    }
   
   
    
    func showAlert() {
        if !self.isInternetAvailable() {
            let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    
    private func showCancelAlert(s:PreviousAppointmentModel)
    {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Appointment cancellation", message: "Why do you want to cancel appointment?", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
            textField.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }
        
        
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        
        let loginAction = UIAlertAction(title: "Proceed", style: .default) { [unowned self] _ in
               guard let remarks = alert.textFields?[0].text
                     else  { return } // Should never happen

               // Perform login action
            
            self.cancelAppointment(appointmentno: s.appointmentno, patcrno: s.patcrno, episodecode: s.episodecode, patfirstname: s.patfirstname, patmiddlename: s.patmiddlename, patlastname: s.patlastname, patguardianname: s.patguardianname, patgendercode: s.patgendercode, emailid: s.emailid, mobileno: s.mobileno, appointmentqueueno: s.appointmentqueueno, appointmenttime: s.appointmenttime, appointmentstatus: s.appointmentstatus, statusremarks: s.statusremarks, slottype: s.slottype, remarks: remarks, appointmenttypeid: s.appointmenttypeid, modulespecificcode: s.modulespecificcode, appointmentmode: s.appointmentmode, modulespecifickeyname: s.modulespecifickeyname, patage: s.patage, patspousename: s.patspousename, appointmentdate: s.appointmentdate, appointmentforid: s.appointmentforid, appointmentforname: s.appointmentforname, actulaparaid1: s.actulaparaid1, actulaparaid2: s.actulaparaid2, actulaparaid3: s.actulaparaid3, actulaparaid4: s.actulaparaid4, actulaparaid5: s.actulaparaid5, actulaparaid6: s.actulaparaid6, actulaparaid7: s.actulaparaid7, actulaparaname1: s.actulaparaname1, actulaparaname2: s.actulaparaname2, actulaparaname3: s.actulaparaname3, actulaparaname4: s.actulaparaname4, actulaparaname5: s.actulaparaname5, actulaparaname6: s.actulaparaname6, actulaparaname7: s.actulaparaname7)
           }
        loginAction.isEnabled = false
           alert.addAction(loginAction)
           present(alert, animated: true)
        // 4. Present the alert.
//        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    private func cancelAppointment( appointmentno: String,  patcrno: String,  episodecode: String,  patfirstname: String,  patmiddlename: String,  patlastname: String,  patguardianname: String,  patgendercode: String,  emailid: String,  mobileno: String,  appointmentqueueno: String,  appointmenttime: String,  appointmentstatus: String,  statusremarks: String,  slottype: String,  remarks: String,  appointmenttypeid: String,  modulespecificcode: String,  appointmentmode: String,  modulespecifickeyname: String,  patage: String,  patspousename: String,  appointmentdate: String,  appointmentforid: String,  appointmentforname: String,  actulaparaid1: String,  actulaparaid2: String,  actulaparaid3: String,  actulaparaid4: String,  actulaparaid5: String,  actulaparaid6: String,  actulaparaid7: String,  actulaparaname1: String,  actulaparaname2: String,  actulaparaname3: String,  actulaparaname4: String,  actulaparaname5: String,  actulaparaname6: String,  actulaparaname7: String)
    {
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        
    let url = URL(string: ServiceUrl.cancelAppointmentUrl)
    var request = URLRequest(url: url!)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let parameters: [String: Any] = [
        
        
        
        "appointmentNo": appointmentno,
                        "patCrNo": patcrno,
                        "episodeCode": episodecode,
                        "patFirstName": patfirstname,
                        "patMiddleName": patmiddlename,
                        "patLastName": patlastname,
                        "patGuardianName": patguardianname,
                        "patGenderCode": patgendercode,
                        "emailId": emailid,
                        "mobileNo": mobileno,
                        "appointmentQueueNo": appointmentqueueno,
                        "appointmentTime": appointmenttime,
                        "appointmentStatus": appointmentstatus,
                        "statusRemarks": statusremarks,
                        "slotType": slottype,
                        "remarks": remarks,
                        "appointmentTypeId": appointmenttypeid,
                        "moduleSpecificCode": modulespecificcode,
                        "appointmentMode": appointmentmode,
                        "moduleSpecificKeyName": modulespecifickeyname,
                        "patAge": patage,
                        "patSpouseName": patspousename,
                        "appointmentDate": appointmentdate,
                        "appointmentForId": appointmentforid,
                        "appointmentForName": appointmentforname,
                        "actualParaId1": actulaparaid1,
                        "actualParaId2": actulaparaid2,
                        "actualParaId3": actulaparaid3,
                        "actualParaId4": actulaparaid4,
                        "actualParaId5": actulaparaid5,
                        "actualParaId6": actulaparaid6,
                        "actualParaId7": actulaparaid7,
                        "actualParaName1": actulaparaname1,
                        "actualParaName2": actulaparaname2,
                        "actualParaName3": actulaparaname3,
                        "actualParaName4": actulaparaname4,
                        "actualParaName5": actulaparaname5,
                        "actualParaName6": actulaparaname6,
                        "actualParaName7": actulaparaname7,
        "hcode": obj!.hospCode
        
    ]
        request.httpBody = parameters.percentEncoded()
    
    let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    
urlSession.dataTask(with: request) { (data, response, error) in
        guard let data = data else { return }
        do{
//                    print("url \(url)")
            let json = try JSON(data:data)
            
           // print(data)
            let status = json["SUCCESS"].stringValue
            print("status :::: \(status)")
            
            if status=="true"
            {
                
                
                DispatchQueue.main.async {

                   let apppointmentNo = json["APPTNO"].stringValue

                        
                    let alert = UIAlertController(title: "Appointment Cancelled", message: "Your appointment number " + apppointmentNo  + " is cancelled successfully.", preferredStyle: .alert)
                   // alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white

                    let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
       
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
                
            }
            else{
//                self.alert(message:"Unable to register patient.Please try again later.")
                self.showToast(message: "Unable to cancel appointment.Please try again later.", font: .systemFont(ofSize: 12.0))

            }
           
            
            
        }catch{
            print("sudeep"+error.localizedDescription)
        }
        }.resume()
    }
    
    
    
   
   
}

extension AppointmentStatusViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentStatusTableViewCell
        

        cell.txtAppointmentNumber.text="Appointment No-Queue No: "+allData[indexPath.row].appointmentno
        cell.txtAppointmentDate.text="Appointment On: "+allData[indexPath.row].appointmentdate
        cell.txtDeptUnit.text="Dept/Unit: "+allData[indexPath.row].actulaparaname1
        
        
        
        if allData[indexPath.row].appointmentstatus=="0"
        {
            cell.txtStatus.text="Status : Cancelled"
            cell.txtStatus.textColor=UIColor.red
            cell.btnView.isHidden=true
        }
         if allData[indexPath.row].appointmentstatus=="1"
        {
            cell.txtStatus.text="Status : Booked"
           // cell.txtStatus.textColor=UIColor(rgb: 0x669900)
            cell.btnView.isHidden=false
        }
         if allData[indexPath.row].appointmentstatus=="2"
        {
            cell.txtStatus.text="Status : Rescheduled"
           // cell.txtStatus.textColor=UIColor(rgb: 0x0099cc)
            cell.btnView.isHidden=false
        }
         if allData[indexPath.row].appointmentstatus=="3"
        {
            //cell.txtStatus.textColor=UIColor(rgb: 0x669900)
            cell.txtStatus.text="Status : Confirmed"
            cell.btnView.isHidden=true
        }
        
        
        cell.btnCancel.tag = indexPath.row
         cell.btnCancel.addTarget(self,action:#selector(btnCancelAppointment(sender:)), for: .touchUpInside)
        
        cell.btnReschedule.tag = indexPath.row
         cell.btnReschedule.addTarget(self,action:#selector(btnRescheduleAppointment(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func btnCancelAppointment(sender:UIButton) {

        let buttonRow = sender.tag
        showCancelAlert(s:self.allData[buttonRow])
        
    }
    
    
    
    @objc func btnRescheduleAppointment(sender:UIButton) {

        let buttonRow = sender.tag
        
        DispatchQueue.main.async {
//            let vc = (self.storyboard!.instantiateViewController(withIdentifier: "RescheduleViewController") as? RescheduleViewController)!
//            vc.myAppointmentDetails=self.allData[buttonRow]
//    self.navigationController!.pushViewController( vc, animated: true)
            
            let vc = (UIStoryboard.init(name: "Appointment", bundle: Bundle.main).instantiateViewController(withIdentifier: "RescheduleViewController") as? RescheduleViewController)!
            vc.myAppointmentDetails=self.allData[buttonRow]
            print("deptcodde  \(self.allData[buttonRow].actualParaRefId)")
            self.navigationController!.pushViewController( vc, animated: true)
            
            
        }

    }
}
extension UIAlertController {

    func isRemarksValid(_ email: String) -> Bool {
        return email.count > 0
    }

    

    @objc func textDidChangeInLoginAlert() {
        if let remarks = textFields?[0].text,
//            let password = textFields?[1].text,
            let action = actions.last {
            action.isEnabled = isRemarksValid(remarks)
        }
    }
}
