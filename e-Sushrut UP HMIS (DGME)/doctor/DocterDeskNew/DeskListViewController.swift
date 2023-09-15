//
//  PharmacyQSlipViewController.swift
//  Railways-HMIS
//
//  Created by HICDAC on 10/01/23.
//

import UIKit
import PDFKit

class DeskListViewController:UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UITextFieldDelegate,URLSessionDelegate  {
    
    
    let searchController=UISearchController(searchResultsController: nil)

    @IBOutlet weak var deptList_btn: UIButton!
    
    @IBOutlet weak var cr_tf: UITextField!
    @IBOutlet weak var qr_iv: UIImageView!
    @IBOutlet weak var plus_iv: UIImageView!
    @IBOutlet weak var tableView: UITableView!

   
    var arrData = [OPDPatientDetails]()
    var allData=[OPDPatientDetails]()
    
    var arrOpdDept=[OPDLiteDepartmentModel]()
    var arrPatientSearchModel=[PatientSearchModel]()
       var id:String!
   
   
    var arDeptCode = [String]();
       var arUnitName = [String]();
       var arHgstrUnitName = [String]();
    var obj:PatientDetails!
    var finalDepartmentId:String! = nil
    
    
    var arrName = [String]();
    var arrCrNo = [String]();
    var arrEmpId = [String]();
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        //perform api call if any
        tableView.reloadData()
        }
    
    let refreshControl = UIRefreshControl()

    override func viewDidAppear(_ animated: Bool) {
        if(self.finalDepartmentId != nil){
            self.patientList(hospCode: UserDefaults.standard.string(forKey: "udHospCode")!, seatId: UserDefaults.standard.string(forKey: "udEmpcode")!, unitCode: self.finalDepartmentId)
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        deptList_btn.layer.cornerRadius = 8.0
        deptList_btn.layer.borderWidth = 1.5
        deptList_btn.layer.borderColor = UIColor.systemBlue.cgColor
        cr_tf.delegate=self
        defaultData()
        hideKeyboardWhenTappedAround()
        cr_tf.returnKeyType = .done
        self.navigationItem.title = "OPD Desk"
        showInernetAlert()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 440
        obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        
        getDepartmentUnitList(hospCode: UserDefaults.standard.string(forKey: "udHospCode")!, seatId: UserDefaults.standard.string(forKey: "udEmpcode")!)
        
        searchBarSetup()
        
        let tapQR = UITapGestureRecognizer(target: self, action: #selector(self.imageTappedQR))
        qr_iv.addGestureRecognizer(tapQR)
        qr_iv.isUserInteractionEnabled = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTappedPlus))
        plus_iv.addGestureRecognizer(tapGR)
        plus_iv.isUserInteractionEnabled = true
        
        addDoneButtonOnNumpad(textField: cr_tf)
    }
   
    func defaultData(){
        cr_tf.text! = "\(UserDefaults.standard.string(forKey:"udHospCode")!)"
    }
//    @objc func refresh(_ sender: AnyObject) {
//       // Code to refresh table view
//        self.patientList(hospCode: UserDefaults.standard.string(forKey: "udHospCode")!, seatId: UserDefaults.standard.string(forKey: "udEmpcode")!, unitCode: self.finalDepartmentId)
//    }
    
    func addDoneButtonOnNumpad(textField: UITextField) {

      let keypadToolbar: UIToolbar = UIToolbar()

      // add a done button to the numberpad
      keypadToolbar.items=[
        UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
        UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
      ]
      keypadToolbar.sizeToFit()
      // add a toolbar with a done button above the number pad
      textField.inputAccessoryView = keypadToolbar
    }
    @objc func imageTappedQR(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if(self.deptList_btn.title(for: .normal) != "Select Department"){
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScannerViewController")as? ScannerViewController {
                    vc.callBack = { (crStr: String) in
                        self.cr_tf.text! = crStr
                    }
                    self.present(vc, animated: true, completion: nil)
                }
            }else{
                self.alert(title: "Info", message: "Please Select Department")
            }
        }
          
    }
    
    @objc func imageTappedPlus(sender: UITapGestureRecognizer) {
        if(self.deptList_btn.title(for: .normal) != "Select Department"){
            if sender.state == .ended {
               var crno = cr_tf.text!;
               if (crno.count >  5  && crno.count < 15) {
                 getDataFromEmpNo(id: crno)
                   
              } else {
                  getStampingData(crno: crno)
              }
          }
        }else{
            self.alert(title: "Info", message: "Please Select Department")
        }
    }
    
    func getDataFromEmpNo(id:String){
        self.arrPatientSearchModel.removeAll()
               DispatchQueue.main.async {
                   self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
               }
               let urlStr = "\(ServiceUrl.testurl)AppOpdService/searchPatientDtlByUniqueid?modeval=3&hospCode=100&id=\(id)"
               let url = URL(string: urlStr)

               print("DepartmentList---\(urlStr)")
               URLSession.shared.dataTask(with: url!) { (data, response, error) in
                   guard let data = data else { return }
                   do{
               
                       var json = try JSON(data:data)
                     //  print(url)
                      json=json["data"]
                       print(json)
                       if json.count == 0
                       {
                           DispatchQueue.main.async {
                               self.alert(title: "No Patient Found", message: "No Patient found for given ID.")
                               self.view.activityStopAnimating()
                           }
                       }
                       else{
                       for arr in json.arrayValue{
                           self.arrPatientSearchModel.append(PatientSearchModel(json: arr))
                           
                       }
                       DispatchQueue.main.async {
                           self.view.activityStopAnimating()
                                   if(self.deptList_btn.title(for: .normal) != "Select Department"){
                                       if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PatientSearchViewController")as? PatientSearchViewController {
                                           vc.callBack = { (name: String,crStr: String,empId: String) in
                                               self.cr_tf.text! = crStr
                                           }
                                           vc.from = 1
                                           vc.arrPatientSearchModel = self.arrPatientSearchModel
                                           self.present(vc, animated: true, completion: nil)
                                       }
                           
                                   }else{
                                       self.alert(title: "Info", message: "Please Select Department")
                                   }
                       }
                           
                       }
                       
                   }catch{
                       print("Error "+error.localizedDescription)
                   }
                   }.resume()
           
    
       
    }
    func getStampingData(crno:String){
        if(crno.count != 15){
            self.alert(title: "Info", message: "Please enter a valid CR No.")
            return
        }
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let deptCode = String(self.id.prefix(3));

        let data = JSON([
            "deptcode": deptCode,
                    "deptunitcode": finalDepartmentId!,
            "hospitalcode": UserDefaults.standard.string(forKey: "udHospCode")!,
                    "patcrno": crno,
                    "latitude": "",
                    "longitude": "",
                    "token": "",
                    "iskiosk": "2",
        ])
        
         //print("Stamping_data - \(data.rawString()!)")
        callStampingService(data: data)
    }
    func callStampingService(data:JSON)
    {
       
        let url = URL(string: ServiceUrl.qrStampingUrl)
       
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
           
            "jsonData":data.rawString()!
            
]
        
        request.httpBody = parameters.percentEncoded()
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
         
    urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                
               // print(data)
                let status = json["status"].stringValue
                print("status :::: \(status)")
                
                if status=="1"
                {
                    let message=json["details"][0]["MSG"].stringValue
                    DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.eStampingAlert(title:"Self Registration", message: message);
                        self.defaultData()
                    }
                }
                else{
                    let stringData=String(data: data, encoding: String.Encoding.utf8) as String?
                    let json = JSON.init(parseJSON: stringData!)
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    self.showAlert(title:"Self Registration", message:  json["msg"].stringValue);
                        self.defaultData()
                    }
                    
                }
               
                
                
            }catch{
                print("sudeep"+error.localizedDescription)
                let stringData=String(data: data, encoding: String.Encoding.utf8) as String?
                let json = JSON.init(parseJSON: stringData!)
                DispatchQueue.main.async {
                self.view.activityStopAnimating()
                self.showAlert(title:"Self Registration", message:  json["msg"].stringValue);
                }
            }
            }.resume()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
       }
    
    
    @IBAction func deptAction_arrow(_ sender: Any) {
                if(self.arrOpdDept.isEmpty){
                    self.alert(title: "No Record Found!", message: "")
                }else{
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupListViewController")as? PopupListViewController {
                        vc.callBack = { (id: String,unit_name: String,hgstr_unit_name: String) in
                            self.id = id
                            self.deptList_btn.setTitle(unit_name, for: .normal)
                            if(self.deptList_btn.title(for: .normal) != "Select Department"){
                               // self.getDivzionList(zoneId: id)
                                self.finalDepartmentId = id.slice(from: "#", to: "#")!
                                print("deptCode---\(self.finalDepartmentId ?? "")")
                                self.patientList(hospCode: UserDefaults.standard.string(forKey: "udHospCode")!, seatId: UserDefaults.standard.string(forKey: "udEmpcode")!, unitCode: self.finalDepartmentId)
                            }
                        }
                        vc.from = 1
                        vc.detpArrData = self.arrOpdDept
                        self.present(vc, animated: true, completion: nil)
                }
        
                }
    }
    func getDepartmentUnitList(hospCode:String,seatId:String){
           DispatchQueue.main.async {
               self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
           }
           let urlStr = "\(ServiceUrl.opdLiteDeptList)\(hospCode)&seatId=\(seatId)&deptcode=&roomNo="
         
           let url = URL(string: urlStr)

           print("DepartmentList---\(urlStr)")
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               guard let data = data else { return }
               do{
           
                   var json = try JSON(data:data)
                 //  print(url)
                  json=json["data"]
                   print(json)
                   if json.count == 0
                   {
                       DispatchQueue.main.async {
                           self.alert(title: "Info", message: "No Record found")
                           self.view.activityStopAnimating()
                       }
                   }
                   else{
                   for arr in json.arrayValue{
                       self.arrOpdDept.append(OPDLiteDepartmentModel(json: arr))
                   }
                       for i in 0 ..< self.arrOpdDept.count {
                           self.arDeptCode.append(self.arrOpdDept[i].COLUMN)
                           self.arUnitName.append(self.arrOpdDept[i].UNITNAME)
                           self.arHgstrUnitName.append(self.arrOpdDept[i].HGSTR_UNITNAME)
                       }
                     //  self.selectDepartment.optionArray = self.arrOpdDept
                   DispatchQueue.main.async {
                       self.view.activityStopAnimating()
                   }
                       
                   }
                   
               }catch{
                   print("Error "+error.localizedDescription)
               }
               }.resume()
       }
    
    func patientList(hospCode:String,seatId:String,unitCode:String){
        self.arrData.removeAll()
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
      //  var url2="https://hmissail.uat.dcservices.in/HISServices/service/AppOpdService/procPatientDtl?modeval=1&hospCode=21101&seatId=10108&deptcode=13411&roomNo=0"
        let url2 = "\(ServiceUrl.testurl)AppOpdService/procPatientDtl?modeval=1&hospCode=\(hospCode)&seatId=\(seatId)&deptcode=\(unitCode)&roomNo="

        print("url2---\(url2)")
        let url = URL(string: url2)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                let jarr=json["data"]

                if (jarr.count != 0){
                for arr in jarr.arrayValue{
                           self.arrData.append(OPDPatientDetails(json: arr))
                           self.allData=self.arrData
                       }
                }else {
                    self.alert(title: "No Record Found!", message: "OPD not found.")
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    
                }
                
            }catch{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    
                }
                print("error:: "+error.localizedDescription)
            }
            }.resume()
    }
    
    func showInernetAlert() {
        if !AppUtilityFunctions.isInternetAvailable() {
            alert(title: "Warning",message: "The Internet is not available")
        }
    }
    func alert(title:String,message:String)
    {
        DispatchQueue.main.async {
           
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
            //                print("Handle Ok logic here")
          //  self.navigationController?.popToRootViewController(animated: true)
          
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
            
        }
    }
    private func searchBarSetup(){
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        
        //self.searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 11.0, *) {
              navigationItem.searchController=searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            searchController.hidesNavigationBarDuringPresentation = true
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
//        if(textField == cr_tf){
//            let maxLength = 15
//            let currentString: NSString = (textField.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }
//        else{
//            let maxLength = 6
//            let currentString: NSString = (textField.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }
              
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
    func showAlert(title:String,message:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
              //  self.navigationController?.popToRootViewController(animated: true)
               
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
    func eStampingAlert(title:String,message:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
              //  self.navigationController?.popToRootViewController(animated: true)
                self.patientList(hospCode: UserDefaults.standard.string(forKey: "udHospCode")!, seatId: UserDefaults.standard.string(forKey: "udEmpcode")!, unitCode: self.finalDepartmentId)
                self.dismiss(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
}
extension DeskListViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.arrData=self.allData
        }
        else{
            self.arrData=self.allData
              arrData=arrData.filter{
                  $0.patname.lowercased().contains(searchText.lowercased())
                  || $0.patcrno.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

extension DeskListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OPDTableViewCell
        
        
        cell.que_no_title.text = "Queue No."
        cell.que_no_lbl.text = arrData[indexPath.row].queno
        
        cell.name_lbl.text = arrData[indexPath.row].patname
        if(arrData[indexPath.row].isconfirmed == "2"){
            cell.status_lbl.text = "Attended"
            cell.status_lbl.textColor = UIColor.red
            cell.re_print_btn.isHidden = false
        }else{
            cell.status_lbl.text = "Waiting"
            cell.status_lbl.textColor = UIColor.systemGreen
            cell.re_print_btn.isHidden = true
            
        }
        
        cell.age_gender_mob_lbl.text = "\(arrData[indexPath.row].genderage)/\(arrData[indexPath.row].patprimarycatcode)/\(arrData[indexPath.row].mobileno)"
        cell.cr_lbl.text = "Cr. No.\(arrData[indexPath.row].patcrno)"
        //
        cell.que_no_lbl.layer.masksToBounds = true
        cell.que_no_lbl.layer.cornerRadius = 5
        cell.que_no_lbl.layer.borderWidth = 1
        cell.que_no_lbl.layer.borderColor = UIColor.black.cgColor
        
        cell.re_print_btn.tag = indexPath.row
        cell.re_print_btn.addTarget(self, action: #selector(re_print(sender:)), for: .touchUpInside)
        //        print("days"+days)
        return cell
    }
    @objc func re_print(sender: UIButton){
        let buttonTag = sender.tag
        print("buttonTag \(buttonTag)")
        //        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController)!
        //        vc.from = 4
        //        vc.hospCode = arrData[buttonTag].departmentunitname
        //        self.navigationController!.pushViewController( vc, animated: true)
        let viewController = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewRxViewController") as? ViewRxViewController)!
        viewController.arrData2=arrData[buttonTag]
        viewController.from = 100
        self.navigationController!.show(viewController, sender: self)
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "OPDLiteVController")as? OPDLiteVController {
            vc.callBack = { (param1: String,param2: String,param3: String) in
               // self.cr_tf.text! = param1
                //self.showAlert(title: "Info", message: ""+param1)
              
            }
            vc.opdPatientDetails=arrData[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
    }
}
