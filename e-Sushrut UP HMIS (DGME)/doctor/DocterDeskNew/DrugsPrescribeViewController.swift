//
//  DrugsPrescribeViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import UIKit

class DrugArrayData {
    var drugName: String!
    var drugCode: String!
    var day: String!
    var afternoon: String!
    var evening: String!
    var night: String!
    var totalDrugGiven: String!
    var totalQty: Int!
    var dayWeekMonthStr: String!
    
    var drugCodeValue: String!
    var desc: String!
    var frequencyName: String!
    var expDate: String!


    init(drugName:String,drugCode:String,day:String,afternoon:String,evening:String,night:String,totalDrugGiven:String,totalQty:Int,dayWeekMonthStr:String,drugCodeValue:String,desc:String,frequencyName:String,expDate:String) {
        self.drugName = drugName
        self.drugCode = drugCode
        self.day = day
        self.afternoon = afternoon
        self.evening = evening
        self.night = night
        self.totalDrugGiven = totalDrugGiven
        self.totalQty = totalQty
        self.dayWeekMonthStr = dayWeekMonthStr
        self.drugCodeValue = drugCodeValue
        self.desc = desc
        self.frequencyName = frequencyName
        self.expDate = expDate
    }
}

class DrugsPrescribeViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var close_iv: UIImageView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var desc_tv: UITextView!
    @IBOutlet weak var drugnameArrow: UIButton!
    
    @IBOutlet weak var drugNameStk: UIStackView!
    @IBOutlet weak var shor_name_btn: UIButton!
    @IBOutlet weak var label_drugname_lbl: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    var drugArrayData = [DrugArrayData]()

    @IBOutlet weak var dayQty: UITextField!
    @IBOutlet weak var afternoonQty: UITextField!
    @IBOutlet weak var eveningQty: UITextField!
    @IBOutlet weak var nightQty: UITextField!
    
    @IBOutlet weak var totalDrugGiven: UITextField!
    
    @IBOutlet weak var daySegment: UISegmentedControl!
    
    @IBOutlet weak var specialDescription: UITextView!
    @IBOutlet weak var qtyLbl: UILabel!
    var nameArray = [String]()
    var dayWeekMonthStr:String!
    var expiry_date: String!

    
    var callBack: ((_ param1: [DrugArrayData], _ param2: String, _ param3: String)-> Void)?
    var arrOpdDept=[DrugListStandardModel]()
    
//    var arDrugCode = [String]();
//    var arrShortType = [String]();
//    var arrQty = [String]();
    var drug_code:String!
    var descStr:String = ""
    var frequencyNameStr:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
//        shor_name_btn.isHidden = true
//        label_drugname_lbl.isHidden = true
       
        defaultData()
       
        nameArray = drugArrayData.map({ (list: DrugArrayData) -> String in
            (list.drugName)!
       })
        dayWeekMonthStr = "Days"
      
//        self.myTableView.rowHeight = UITableView.automaticDimension
//        self.myTableView.estimatedRowHeight = 100
        myTableView.delegate = self
        myTableView.dataSource = self
        hideKeyboardWhenTappedAround()
        
        dayQty.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingDidBegin)
       afternoonQty.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingDidBegin)
        eveningQty.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingDidBegin)
        nightQty.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingDidBegin)
        totalDrugGiven.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingDidBegin)
        
        dayQty.delegate = self
        afternoonQty.delegate = self
        eveningQty.delegate = self
        nightQty.delegate = self
        totalDrugGiven.delegate = self
        
        doneKeybord(textField: dayQty)
        doneKeybord(textField: afternoonQty)
        doneKeybord(textField: eveningQty)
        doneKeybord(textField: nightQty)
        doneKeybord(textField: totalDrugGiven)
        
        
        desc_tv.returnKeyType = .done
        
        let keypadToolbar: UIToolbar = UIToolbar()

        keypadToolbar.items=[
          UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: desc_tv, action: #selector(UITextField.resignFirstResponder)),
          UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        ]
        keypadToolbar.sizeToFit()
        desc_tv.inputAccessoryView = keypadToolbar
        
        drugnameArrow.layer.cornerRadius = 8.0
        drugnameArrow.layer.borderWidth = 1.5
        drugnameArrow.layer.borderColor = UIColor.systemBlue.cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:)))
        close_iv.isUserInteractionEnabled = true
        close_iv.addGestureRecognizer(tapGestureRecognizer)

    drugList(hospCode: UserDefaults.standard.string(forKey: "udHospCode")!)
    }
    @objc private func textFieldDidChange(_ textField:UITextField) {
//        if(textField == self.dayQty){
//            if(self.dayQty.clearsOnBeginEditing){
//                self.dayQty.text! = "kkk"
//            }else{
//                self.afternoonQty.becomeFirstResponder()
//            }
//        }
    }
    func defaultData(){
        self.drugnameArrow.setTitle("Select Drug", for: .normal)
        if(self.drugnameArrow.currentTitle != "Select Drug"){
            self.shor_name_btn.isHidden = false
            self.label_drugname_lbl.isHidden = false
        }else{
            self.shor_name_btn.isHidden = true
            self.label_drugname_lbl.isHidden = true
        }
        
        dayQty.text! = "1"
        afternoonQty.text! = "0"
        eveningQty.text! = "0"
        nightQty.text! = "0"
        totalDrugGiven.text! = "1"
        
        
        daySegment.selectedSegmentIndex = 0;
        dayWeekMonthStr = "Days"
        
        desc_tv.delegate = self
        desc_tv.text = "Add Special Condition"
        desc_tv.textColor = UIColor.lightGray
        
        
    }
    
  
    
    func doneKeybord(textField:UITextField){
        textField.returnKeyType = .done
        
        let keypadToolbar: UIToolbar = UIToolbar()

        keypadToolbar.items=[
          UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
          UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        ]
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if specialDescription.textColor == UIColor.lightGray {
            specialDescription.text = ""
            specialDescription.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if specialDescription.text == "" {
            specialDescription.text = "Add Special Condition"
            specialDescription.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func addSegment(_ segment: UISegmentedControl) {
        dayWeekMonthStr
        = segment.titleForSegment(at: segment.selectedSegmentIndex)!
        print("segmentStr-\(String(describing: dayWeekMonthStr))")
    }
    @IBAction func doneBtn(_ sender: Any) {
        callBack?(self.drugArrayData,"","")
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        
        if(drugnameArrow.currentTitle != "Select Drug"){
            if(dayQty.text!.count != 0 && afternoonQty.text!.count != 0 && eveningQty.text!.count != 0 && nightQty.text!.count != 0){
                
                print("total_drug--\(dayQty.text!)--\(afternoonQty.text!)--\(eveningQty.text!)--\(nightQty.text!)--\(totalDrugGiven.text!)")
                
            if(dayQty.text! != "0" || afternoonQty.text! != "0" || eveningQty.text! != "0" || nightQty.text! != "0"){
                if(totalDrugGiven.text != "0"  && totalDrugGiven.text!.count != 0){
                    if((self.drugnameArrow.titleLabel!.text!.contains(self.nameArray))){
                self.showAlert(title: "Info", message: "Already added")
               }else{
                var daysqtyStr:Int = 1
                var afternoonQtyStr = 0
                var eveningQtyStr = 0
                var nightQtyStr = 0
                var totalDrugGivenStr = 1
                var totalQty:Int = 1

                if((dayQty.text?.count) == nil || dayQty.text?.count == 0){
                     daysqtyStr = 1
                }else{
                     daysqtyStr = Int(dayQty.text!)!
                }
                if((afternoonQty.text?.count) == nil || afternoonQty.text?.count == 0){
                    afternoonQtyStr = 0
                }else{
                    afternoonQtyStr = Int(afternoonQty.text!)!
                }
                if((eveningQty.text?.count) == nil || eveningQty.text?.count == 0){
                    eveningQtyStr = 0
                }else{
                    eveningQtyStr = Int(eveningQty.text!)!
                }
                if((nightQty.text?.count) == nil || nightQty.text?.count == 0){
                    nightQtyStr = 0
                }else{
                    nightQtyStr = Int(nightQty.text!)!
                }
                if((totalDrugGiven.text?.count) == nil || totalDrugGiven.text?.count == 0){
                    totalDrugGivenStr = 1
                }else{
                    totalDrugGivenStr = Int(totalDrugGiven.text!)!
                }
                
                if(dayWeekMonthStr == "Days"){
                totalQty = (daysqtyStr + afternoonQtyStr + eveningQtyStr + nightQtyStr) * (totalDrugGivenStr) * 1
                }else if(dayWeekMonthStr == "Weeks"){
                totalQty = (daysqtyStr + afternoonQtyStr + eveningQtyStr + nightQtyStr) * (totalDrugGivenStr) * 7
                }else if(dayWeekMonthStr == "Months"){
                totalQty = (daysqtyStr + afternoonQtyStr + eveningQtyStr + nightQtyStr) * (totalDrugGivenStr) * 30
                }
               
                self.frequencyNameStr = "\(daysqtyStr) - \(afternoonQtyStr) - \(eveningQtyStr) - \(nightQtyStr) X \(totalDrugGivenStr) \(dayWeekMonthStr!)"
                if(desc_tv.text! == "Add Special Condition"){
                    descStr = ""
                }else{
                    descStr = desc_tv.text!
                }
                
                   self.drugArrayData.append(DrugArrayData(drugName: drugnameArrow.currentTitle!,drugCode: self.drug_code,day: dayQty.text!,afternoon: afternoonQty.text!,evening: eveningQty.text!,night: nightQty.text!,totalDrugGiven: totalDrugGiven.text!,totalQty: totalQty,dayWeekMonthStr: dayWeekMonthStr, drugCodeValue: self.drug_code, desc: descStr, frequencyName: frequencyNameStr,expDate: self.expiry_date))
                myTableView.reloadData()
                nameArray = drugArrayData.map({ (list: DrugArrayData) -> String in
                    (list.drugName)!
               })
                
                self.defaultData()
              }
            }else{
                    self.showAlert(title: "Info", message: "Drug Days/Weeks/Months Required!")
                }
            } else {
                self.showAlert(title: "Info", message: "Quantity can not be 0!")
                }
            }else{
                self.showAlert(title: "Info", message: "Drug Required!")
            }
            
        }else{
            self.showAlert(title: "Info", message: "Please Select Drug")
        }
      
        
    }
    @IBAction func drugnameAction(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrugListStandardViewController")as? DrugListStandardViewController {
            vc.callBack = { (label: String,drug_code: String,qty: String,short_name: String,expiry_date: String) in
                self.drugnameArrow.setTitle(label, for: .normal)
                self.drug_code = drug_code
                self.shor_name_btn.setTitle(short_name, for: .normal)
                self.label_drugname_lbl.text! = label
                self.expiry_date = expiry_date
               // self.qtyLbl.text! = qty
                
                
                if(self.drugnameArrow.currentTitle != "Select Drug"){
                    self.shor_name_btn.isHidden = false
                    self.label_drugname_lbl.isHidden = false
                }else{
                    self.shor_name_btn.isHidden = true
                    self.label_drugname_lbl.isHidden = true
                }
                
                }
            vc.detpArrData = self.arrOpdDept
            vc.from = 1
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func drugList(hospCode:String){
           DispatchQueue.main.async {
               self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
           }
           let urlStr = "\(ServiceUrl.testurl)AppOpdService/drugListStandard?hosp_code=\(hospCode)"
         
           let url = URL(string: urlStr)

           print("DepartmentList---\(urlStr)")
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               guard let data = data else { return }
               do{
           
                   var json = try JSON(data:data)
                 //  print(url)
                  json=json["drug_list_standard"]
                   print(json)
                   if json.count == 0
                   {
                       DispatchQueue.main.async {
                          // self.showAlert(title: "Info", message: "No Record found")
                           self.view.activityStopAnimating()
                       }
                   }
                   else{
                   for arr in json.arrayValue{
                       self.arrOpdDept.append(DrugListStandardModel(json: arr))
                   }
//                       for i in 0 ..< self.arrOpdDept.count {
//                           self.arDrugCode.append(self.arrOpdDept[i].DRUG_CODE)
//                           self.arrShortType.append(self.arrOpdDept[i].ITEM_TYPE_SHORT_NAME)
//                           self.arrQty.append(self.arrOpdDept[i].QTY)
//                       }
                   DispatchQueue.main.async {
                       self.view.activityStopAnimating()
                   }
                       
                   }
                   
               }catch{
                   print("Error "+error.localizedDescription)
               }
               }.resume()
       }
    func showAlert(title:String,message:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
              //  self.navigationController?.popToRootViewController(animated: true)
                    //  self.dismiss(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
}

extension DrugsPrescribeViewController:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Range.length == 1 means,clicking backspace
        if textField != self.totalDrugGiven {
            if (range.length == 0){
                if textField == self.dayQty {
                    self.afternoonQty?.becomeFirstResponder()
                }
                if textField == self.afternoonQty {
                    self.eveningQty?.becomeFirstResponder()
                }
                if textField == self.eveningQty {
                    self.nightQty?.becomeFirstResponder()
                }
                if textField == self.nightQty {
                    self.totalDrugGiven?.becomeFirstResponder()
                }
                textField.text? = string
                return false
            }else if (range.length == 1) {
                if textField ==  self.nightQty {
                    self.eveningQty?.becomeFirstResponder()
                }
                if textField == self.eveningQty {
                    self.afternoonQty?.becomeFirstResponder()
                }
                if textField == self.afternoonQty {
                    self.dayQty?.becomeFirstResponder()
                }
                textField.text? = ""
                return false
            }
        }else{
            let maxLength = 3
               let currentString: NSString = (textField.text ?? "") as NSString
               let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString

               return newString.length <= maxLength
        }
        return true
       
    }

        
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drugArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrugPrescribeTableViewCell
        cell.drugNameLbl!.text = drugArrayData[indexPath.row].drugName
        cell.dayAfternoonEveningNightLbl?.text = "\(drugArrayData[indexPath.row].day!)-\(drugArrayData[indexPath.row].afternoon!)-\(drugArrayData[indexPath.row].evening!)-\(drugArrayData[indexPath.row].night!)x\(drugArrayData[indexPath.row].totalDrugGiven!) \(drugArrayData[indexPath.row].dayWeekMonthStr!)"
        
        cell.totalQtyLbl!.text = "QTY-\(String(drugArrayData[indexPath.row].totalQty!))"
        if(drugArrayData[indexPath.row].desc! == ""){
            cell.special_instruction_btn!.isHidden = true
        }else{
            cell.special_instruction_btn!.isHidden = false
        }
        cell.special_instruction_btn!.tag = indexPath.row
        cell.special_instruction_btn!.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        return cell
        
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
       
        self.showAlert(title: "Special Instruction", message: ""+drugArrayData[buttonTag].desc!)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")

        self.nameArray.remove(at: indexPath.row)
        self.drugArrayData.remove(at: indexPath.row)
          self.myTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
}
