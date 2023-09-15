//
//  OPDAppointmentViewController.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 17/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
class OPDAppointmentViewController: UIViewController,URLSessionDelegate{
//,UIPickerViewDataSource,UIPickerViewDelegate {

    var arrData=[DepartmentModel]()
    var generalData=[DepartmentModel]()
    var specialData=[DepartmentModel]()
    var allData=[DepartmentModel]()
    
    var arRegisteredPatients=[PatientDetails]()
    
    var patientDetails = PatientDetails()
    
    @IBOutlet weak var segRef: UISegmentedControl!
  //  @IBOutlet weak var txtSelectPatient: UITextField!
    @IBOutlet weak var departmentsTableView: UITableView!
    
    var selectPatientPicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        showAlert()
       
        departmentsTableView.rowHeight = UITableView.automaticDimension
        departmentsTableView.estimatedRowHeight = 44
        
        
//        selectPatientPicker.delegate=self
//        selectPatientPicker.dataSource=self
//        txtSelectPatient.inputView = selectPatientPicker
        
        
//        let mobileNo =  UserDefaults.standard.string(forKey:"udMobileNo");
       // getCrList(mobileNo: mobileNo!)
        
        //To retrieve the saved object
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        self.patientDetails=obj!
        print("hello"+obj!.crno)
        //self.setDefaultValue(item: obj ?? PatientDetails(), inComponent: 0)
        getDepartments(crno:obj!.crno);
    }
    
    @IBAction func btnSegRef(_ sender: Any) {
        if segRef.selectedSegmentIndex == 0
               {

                arrData=generalData
            DispatchQueue.main.async {
                self.departmentsTableView.reloadData()
            }

               }
               if segRef.selectedSegmentIndex == 1
               {

                arrData=specialData
                DispatchQueue.main.async {
                   
                    self.departmentsTableView.reloadData()
                    
                }
               }
               if segRef.selectedSegmentIndex == 2
               {

                arrData=allData
                DispatchQueue.main.async {
                    self.departmentsTableView.reloadData()
                }
               }
    }
    
    
    
    func getDepartments(crno:String){
        
        print("getDepartments called.."+ServiceUrl.getAppointmentDepartmens+crno)
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let url = URL(string: ServiceUrl.getAppointmentDepartmens+crno)
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        urlSession.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                print("getDepartments called.. \(data)")
                if json["status"].stringValue=="1"
                {
                    
                    let departmentData=json["dept_list"].array
                    let jsonn =   JSON(departmentData!)
                for arr in jsonn.arrayValue{
                    self.allData.append(DepartmentModel(json: arr))
                    print(arr["DEPTNAME"].stringValue)
                    if arr["UNIT_TYPE_CODE"].stringValue=="1"
                    {
                    self.generalData.append(DepartmentModel(json: arr))
                        
                    }
                    if arr["UNIT_TYPE_CODE"].stringValue=="2"
                    {
                    self.specialData.append(DepartmentModel(json: arr))
                    }

                
                }
                }else{
                    //showalert
                    print("in else")
                }
               
                 self.arrData=self.generalData
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.departmentsTableView.reloadData()
                    
                }
            
            }catch{
                
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                
                
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    
   /*
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
       
            txtSelectPatient.text = arRegisteredPatients[row].firstName+" "+arRegisteredPatients[row].lastName+" ("+arRegisteredPatients[row].crno+")"
          
           patientDetails=arRegisteredPatients[row]
            
            self.view.endEditing(false)
        }
    
  
    private func getCrList(mobileNo:String)
{
        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
    let url = URL(string: ServiceUrl.getPatDtlsFromcrno+mobileNo+"&smsFlag=0" )
    let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
urlSession.dataTask(with: url!) { (data, response, error) in
        guard let data = data else {
            return }
        do{
            let json = try JSON(data:data)
     
            
            let jsonArray=json["patientdetails"].array;
            if jsonArray==nil
            {
                print("nil json array");
            }else
            {
                let jsonn =   JSON(jsonArray!)
            
          
             for arr in jsonn.arrayValue{
                self.arRegisteredPatients.append(PatientDetails(json: arr))
            }
    
                
            }
        
            DispatchQueue.main.async {
                self.view.activityStopAnimating()
                self.selectPatientPicker.reloadAllComponents()
                
               

                

                //To retrieve the saved object
                let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
                self.patientDetails=obj!
                print("hello"+obj!.crno)
                self.setDefaultValue(item: obj ?? PatientDetails(), inComponent: 0)
                self.getDepartments();
            }
            
        }catch{
            print("error")
            print(error.localizedDescription)
        }
        }.resume()
}
  
    
    
    func setDefaultValue(item: PatientDetails, inComponent: Int){
        if let indexPosition =  arRegisteredPatients.firstIndex(where: {
            $0.crno == item.crno
        }){
            
        selectPatientPicker.selectRow(indexPosition, inComponent: inComponent, animated: true)
            txtSelectPatient.text=item.firstName+" "+item.lastName+" ("+item.crno+")"
       // txtGender.text = arGender[indexPosition]
     }
  
    }
    
    
     */
    
    
    
    func showAlert() {
        if !AppUtilityFunctions.isInternetAvailable() {
            let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
}

extension OPDAppointmentViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OPDAppointmentDepartmentTableViewCell
        
        cell.lblDepartment.text = arrData[indexPath.row].deptname
        
//        cell.labelTariffCharge.text = "Rs. "+arrData[indexPath.row].tariffCharge
        
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let viewController = (UIStoryboard.init(name: "Appointment", bundle: Bundle.main).instantiateViewController(withIdentifier: "OPDSlotSelectionViewController") as? OPDSlotSelectionViewController)!
        viewController.departmentDetails=arrData[indexPath.row]
        viewController.patientDetails=patientDetails
        self.navigationController!.show(viewController, sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
