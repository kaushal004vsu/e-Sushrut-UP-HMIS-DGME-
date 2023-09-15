//
//  InvestigationViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import UIKit
//class InvestigationArrayData:NSObject {
//    var title: String!
//    var titleID: String!
//    var side: String!
//    var sideID: String!
//    var desc: String!
//
//    init(title:String,titleID:String,side:String,sideID:String,desc:String) {
//        self.title = title
//        self.titleID = titleID
//        self.side = side
//        self.sideID = sideID
//        self.desc = desc
//    }
//}
class InvestigationArrayData:NSObject {
    var investigationDetails = [InvestigationModel]() ;
         var side: String!
         var remarks: String!
         var isBoolExternal:Bool!
         var EpisodeCode: String!//": "10512015",
         var IsExternal: String!//": "0",
         var IsTestGroup: String!//": "0",
         var LabCode: String!//": "10003",
         var LabName: String!//": "Biochemistry-Biochemistry",
         var SampleCode: String!//": "1002",
         var SampleName: String!//": "BLD",
         var SideCode: String!//": "0",
         var SideName: String!//": "Side",
         var SideRemarks: String!//": "",
         var TestCode: String!//": "10008",
         var TestName: String!//": "Alkaline Phosphatase (ALP) (1002) ",
         var VisitNo: String!//": "1"
         var tariffId: String!
         var isConsent: String!
         var testDetail: String!
         var visitDate: String!
         var testName: String!
    
    init( investigationDetails:[InvestigationModel],side:String,remarks:String, isBoolExternal:Bool,episodeCode:String,visitNo:String,TestName:String,isConsent:String,testDetail:String,visitDate:String,testName:String) {
        super.init()
        
        self.isConsent = isConsent
        self.testDetail = testDetail
        self.visitDate = visitDate
        self.testName = testName
        self.investigationDetails = investigationDetails
        self.side = side;
        self.remarks = remarks;
        self.isBoolExternal = isBoolExternal;


               //emr parameters
               self.EpisodeCode = episodeCode;
               self.IsExternal = (isBoolExternal) ? "1" : "0";
               self.IsTestGroup = "0";
        
//        for i in investigationDetails
//        {
//            print("inestigationdetails-- \(i.TEST_NAME)")
//            print("investigationDetails-- \(i.TEST_DETAIL)")
//                       let result = i.TEST_DETAIL.split(separator: "^")
//            self.TestCode = String(result[0])
//            self.tariffId=String(result[0])
//            self.LabCode = String(result[1])
//            self.SampleCode = String(result[2])
//            self.SampleName = String(result[3])
//            self.LabName = String(result[4])
//            self.TestName = i.TEST_NAME
//            self.isConsent=i.ISCONSENTREQUIRED
//            
//        }
      //  print("print_investi--\( self.TestCode!)--\(self.LabCode!)--\(self.SampleCode!)--\(self.SampleName!)--\(self.SampleName!)--\(self.LabName!)")

              self.VisitNo = visitNo;
               self.SideCode = sideNameToCode(sideName: side);
               self.TestName = TestName;
               self.SideName = side;
               self.SideRemarks = remarks;
              

    }
    func sideNameToCode(sideName:String)->String{
        if (sideName == "Side") {
                   return "0";
               } else if (sideName == "NR") {
                   return "1";
               } else if (sideName == "Left") {
                   return "2";
               } else if (sideName == "Right") {
                   return "3";
               } else if (sideName == "Bilateral") {
                   return "4";
               } else {
                   return "Side";
               }
    }
}
class InvestigationViewController: UIViewController, UITextViewDelegate {
    var callBack: ((_ id: [InvestigationArrayData], _ name: String, _ age: String)-> Void)?
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var close_iv: UIImageView!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var investigationBtnArrow: UIButton!
    @IBOutlet weak var desc_tv: UITextView!
    
    
    
    
    var arrInvestigation = [InvestigationModel]()
    var nameArray = [String]()
    
    var arrTestName = [String]();
    var arrSampleCode = [String]();
    var arrTarif = [String]();
    var titleId:String!
    
    var investigationStr:String = ""
    var sideStr:String = ""
    var descStr:String = ""
    var opdPatientDetails=OPDPatientDetails()
    var investigationArrayData = [InvestigationArrayData]()
    
    var testDetailStr: String!
    var visitDateStr: String!
    var testNameStr: String!
    var isConsentStr: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        self.myTableView.reloadData()
        nameArray =   self.investigationArrayData.map({ (list: InvestigationArrayData) -> String in
            (list.TestName)
       })
       
        defaultData()
        myTableView.delegate = self
        myTableView.dataSource = self
        
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
        
        getInvestigation()
       
    }
    
    func defaultData(){
        desc_tv.delegate = self
        desc_tv.text = "Description"
        desc_tv.textColor = UIColor.lightGray
        
        segment.selectedSegmentIndex = 0;
        sideStr = "Side"
        
        self.investigationBtnArrow.setTitle("Select Investigation", for: .normal)
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
        callBack?(self.investigationArrayData,sideStr,descStr)
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addBtn(_ sender: Any) {
        if(investigationBtnArrow.currentTitle != "Select Investigation"){
            if((self.investigationBtnArrow.titleLabel!.text!.contains(self.nameArray))){
                alert(title: "Info", message: "Already added")
            }else{
                if(desc_tv.text! == "Description"){
                    descStr = ""
                }else{
                    descStr = desc_tv.text!
                }
           
                self.investigationArrayData.append(InvestigationArrayData(investigationDetails: self.arrInvestigation ,side: sideStr, remarks: descStr, isBoolExternal: true, episodeCode: opdPatientDetails.episodecode, visitNo: opdPatientDetails.visitNo,TestName: self.investigationBtnArrow.titleLabel!.text!,isConsent: self.isConsentStr,testDetail:  self.testDetailStr,visitDate: self.visitDateStr,testName: self.testNameStr))
                
                 nameArray =   self.investigationArrayData.map({ (list: InvestigationArrayData) -> String in
                     (list.TestName)
                })
//                print("investigationArrayData\(self.investigationArrayData)")

            }
        }else{
            self.alert(title: "Info", message: "Please Select Investigation")
        }
        
        self.myTableView.reloadData()
        defaultData()
    }
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        sideStr = segment.titleForSegment(at: segment.selectedSegmentIndex)!
        print("segmentStr-\(sideStr)")
        

    }
    @IBAction func investigationBtnArrow(_ sender: Any) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InvestigationListViewController")as? InvestigationListViewController {
            vc.callBack = { (title: String,titleId: String,isConsentStr: String,testDetailStr:String,visitDateStr:String,testNameStr:String) in
                self.titleId = titleId
                self.isConsentStr = isConsentStr
                self.testDetailStr = testDetailStr
                self.visitDateStr = visitDateStr
                self.testNameStr = testNameStr
                self.investigationBtnArrow.setTitle(title, for: .normal)
                if(self.investigationBtnArrow.title(for: .normal) != "Select Investigation"){
                   
                }
            }
            vc.from = 1
            vc.arrInvestigation = self.arrInvestigation
            self.present(vc, animated: true, completion: nil)
            }
    }
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getInvestigation(){
           DispatchQueue.main.async {
               self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
           }
        let urlStr = "\(ServiceUrl.testurl)AppOpdService/investigationList?hosp_code=\(UserDefaults.standard.string(forKey: "udHospCode")!)"
         
           let url = URL(string: urlStr)

           print("DepartmentList---\(urlStr)")
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               guard let data = data else { return }
               do{
           
                   var json = try JSON(data:data)
                 //  print(url)
                  json=json["investigation_details"]
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
                       self.arrInvestigation.append(InvestigationModel(json: arr))
                   }
                       for i in 0 ..< self.arrInvestigation.count {
                           self.arrTestName.append(self.arrInvestigation[i].TEST_NAME)
                           self.arrSampleCode.append(self.arrInvestigation[i].SAMPLECODE)
                           self.arrTarif.append(self.arrInvestigation[i].TARIFF)
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
    
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
    
    func convertIntoJSONString(arrayObject: [Any]) -> String? {

            do {
                let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
                if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                    return jsonString as String
                }
                
            } catch let error as NSError {
                print("Array convertIntoJSON - \(error.description)")
            }
            return nil
        }
}
extension InvestigationViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        investigationArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrugPrescribeTableViewCell
        cell.drugNameLbl!.text = investigationArrayData[indexPath.row].TestName
        cell.dayAfternoonEveningNightLbl?.text = "\(investigationArrayData[indexPath.row].side!)"
        
        cell.totalQtyLbl!.text = "\(String(investigationArrayData[indexPath.row].remarks!))"
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          print("Deleted-\(self.nameArray)--\(indexPath.row)")

        self.nameArray.remove(at: indexPath.row)
        self.investigationArrayData.remove(at: indexPath.row)
          self.myTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
}
