//
//  ProceduresViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import UIKit
        
       
class ProcedureArrayData {
    var ProcedureCode: String!
    var ProcedureSideName: String!
    var ProcedureSideRemarks: String!
    var ProceduresName: String!
    var ServiceAreaCode: String!
    var ServiceAreaName: String!

    init(ProcedureCode:String,ProcedureSideName:String,ProcedureSideRemarks:String,ProceduresName:String,ServiceAreaCode:String,ServiceAreaName:String) {
        self.ProcedureCode = ProcedureCode
        self.ProcedureSideName = ProcedureSideName
        self.ProcedureSideRemarks = ProcedureSideRemarks
        self.ProceduresName = ProceduresName
        self.ServiceAreaCode = ServiceAreaCode
        self.ServiceAreaName = ServiceAreaName
       
    }
}
class ProceduresViewController: UIViewController, UITextViewDelegate {
    var callBack: ((_ id: [ProcedureArrayData], _ name: String, _ age: String)-> Void)?
    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var close_iv: UIImageView!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var investigationBtnArrow: UIButton!
    @IBOutlet weak var desc_tv: UITextView!
    
    var arrProcedure = [ProcedureModel]()
       var arrProcedureDetails = [ProcedureDetails]()
    var nameArray = [String]()
    
    var arrTestName = [String]();
    var arrSampleCode = [String]();
    var arrProcedureDetail = [String]();
    var arrServiceAreaName = [String]();
    var serviceAreaName,proceduresName,serviceAreaCode,procedureCode: String!
    
    var investigationStr:String = ""
    var sideStr:String = ""
    var descStr:String = ""
    
    var procedureArrayData = [ProcedureArrayData]()
    
    var id:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.reloadData()
        
        nameArray = procedureArrayData.map({ (list: ProcedureArrayData) -> String in
           (list.ProceduresName)!
       })
        
        defaultData()
        
        hideKeyboardWhenTappedAround()
        desc_tv.returnKeyType = .done
        
        let keypadToolbar: UIToolbar = UIToolbar()

        keypadToolbar.items=[
          UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: desc_tv, action: #selector(UITextField.resignFirstResponder)),
          UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        ]
        keypadToolbar.sizeToFit()
        // add a toolbar with a done button above the number pad
        desc_tv.inputAccessoryView = keypadToolbar
        
        investigationBtnArrow.layer.cornerRadius = 8.0
        investigationBtnArrow.layer.borderWidth = 1.5
        investigationBtnArrow.layer.borderColor = UIColor.systemBlue.cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:)))
        close_iv.isUserInteractionEnabled = true
        close_iv.addGestureRecognizer(tapGestureRecognizer)
        
        getProcedure()
       
    }
    func defaultData(){
        desc_tv.delegate = self
        desc_tv.text = "Description"
        desc_tv.textColor = UIColor.lightGray
        
        segment.selectedSegmentIndex = 0;
        sideStr = "Side"
        
        self.investigationBtnArrow.setTitle("Select Procedure", for: .normal)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if desc_tv.textColor == UIColor.lightGray {
            desc_tv.text = ""
            desc_tv.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if desc_tv.text == "" {
            desc_tv.text = "Description"
            desc_tv.textColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func doneBtn(_ sender: Any) {
       
        callBack?(self.procedureArrayData,sideStr,descStr)

        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addBtn(_ sender: Any) {
        descStr = desc_tv.text!
        if(investigationBtnArrow.currentTitle != "Select Procedure"){
            if((self.investigationBtnArrow.titleLabel!.text!.contains(self.nameArray))){
                alert(title: "Info", message: "Already added")
            }else{
                if(desc_tv.text! == "Description"){
                    descStr = ""
                }else{
                    descStr = desc_tv.text!
                }
                self.procedureArrayData.append(ProcedureArrayData(ProcedureCode: self.procedureCode, ProcedureSideName: sideStr, ProcedureSideRemarks: descStr, ProceduresName: self.proceduresName, ServiceAreaCode: self.serviceAreaCode, ServiceAreaName: self.serviceAreaName))
                print("procedure-\(self.procedureArrayData)")
    //            for procedureArrayData in self.procedureArrayData {
    //                print("procedureArrayData- \(InvestigationArrayData.title!)")
    //                procedureArrayData.append(procedureArrayData.title!)
    //            }
                 nameArray = procedureArrayData.map({ (list: ProcedureArrayData) -> String in
                    (list.ProceduresName)!
                })
                print("procedureArrayData\(self.procedureArrayData)")
               // self.appendLbl.text! = "\(nameArray)"
                self.myTableView.reloadData()
                defaultData()

            }
        }else{
            alert(title: "Info", message: "Please Select Procedure")
        }
       
        
        
    }
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        sideStr = segment.titleForSegment(at: segment.selectedSegmentIndex)!
        print("segmentStr-\(sideStr)")

    }
    @IBAction func investigationBtnArrow(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProcedureListViewController")as? ProcedureListViewController {
                       vc.callBack = { ( serviceAreaName: String,proceduresName: String,serviceAreaCode: String,procedureCode: String) in
                           
                           self.serviceAreaName = serviceAreaName
                           self.proceduresName = proceduresName
                           self.serviceAreaCode = serviceAreaCode
                           self.procedureCode = procedureCode
                           self.investigationBtnArrow.setTitle(proceduresName, for: .normal)
//                       if(self.investigationBtnArrow.title(for: .normal) != "Select Procedure"){
//                           self.arrProcedureDetails.append(ProcedureDetails(getInvestigation: "\(titleId)", getSide: "\(title)", getDescription: "\(service_area)"))
//                       }
                   }
                   vc.from = 1
                       vc.arrProcedure = self.arrProcedure
                   self.present(vc, animated: true, completion: nil)
                   }
    }
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getProcedure(){
              DispatchQueue.main.async {
                  self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
              }
           let urlStr = "\(ServiceUrl.testurl)AppOpdService/procedureListing?hosp_code=\(UserDefaults.standard.string(forKey: "udHospCode")!)"
            
              let url = URL(string: urlStr)

              print("DepartmentList---\(urlStr)")
              URLSession.shared.dataTask(with: url!) { (data, response, error) in
                  guard let data = data else { return }
                  do{
              
                      var json = try JSON(data:data)
                    //  print(url)
                     json=json["procedure_listing_details"]
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
                          self.arrProcedure.append(ProcedureModel(json: arr))
                      }
                          for i in 0 ..< self.arrProcedure.count {
                              self.arrTestName.append(self.arrProcedure[i].PROCEDURE_NAME)
                              self.arrSampleCode.append(self.arrProcedure[i].SERVICE_AREA_CODE)
                              self.arrProcedureDetail.append(self.arrProcedure[i].PROCEDURE_DETAIL)
                              self.arrServiceAreaName.append(self.arrProcedure[i].SERVICE_AREA_NAME)
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
}
extension ProceduresViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        procedureArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrugPrescribeTableViewCell
        cell.drugNameLbl!.text = procedureArrayData[indexPath.row].ProceduresName
        cell.dayAfternoonEveningNightLbl?.text = "\(procedureArrayData[indexPath.row].ProcedureSideName!)"
        cell.totalQtyLbl!.text = "\(String(procedureArrayData[indexPath.row].ProcedureSideRemarks!))"
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")

        self.nameArray.remove(at: indexPath.row)
        self.procedureArrayData.remove(at: indexPath.row)
          self.myTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
}
