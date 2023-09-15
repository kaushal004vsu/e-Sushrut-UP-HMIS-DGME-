//
//  PhrViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import iOSDropDown
class PhrViewController: UIViewController {
   

    @IBOutlet weak var weightTrend: UIButton!
    
    @IBOutlet weak var weightName: UILabel!
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var weightUnitLbl: UILabel!
    @IBOutlet weak var weightStepper: UIStepper!
    @IBOutlet weak var weightImageView: UIImageView!
    
    @IBOutlet weak var heightName: UILabel!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var heightUnitLbl: UILabel!
    @IBOutlet weak var heightStepper: UIStepper!
    @IBOutlet weak var heightImageView: UIImageView!
    
    @IBOutlet weak var bmiName: UILabel!
    @IBOutlet weak var bmiView: UIView!
    @IBOutlet weak var bmiLbl: UILabel!
    @IBOutlet weak var bmiUnitLbl: UILabel!
    @IBOutlet weak var bmiStepper: UIStepper!
    @IBOutlet weak var bmiStatus: UILabel!
    
    @IBOutlet weak var respRateName: UILabel!
    @IBOutlet weak var respRateView: UIView!
    @IBOutlet weak var respRateLbl: UILabel!
    @IBOutlet weak var respRateUnitLbl: UILabel!
    @IBOutlet weak var respRateStepper: UIStepper!
    @IBOutlet weak var respRateStatus: UILabel!
    
    @IBOutlet weak var o2Name: UILabel!
    @IBOutlet weak var o2View: UIView!
    @IBOutlet weak var o2Lbl: UILabel!
    @IBOutlet weak var o2UnitLbl: UILabel!
    @IBOutlet weak var o2Stepper: UIStepper!
    @IBOutlet weak var o2Status: UILabel!
    
    @IBOutlet weak var pulseRateName: UILabel!
    @IBOutlet weak var pulseRateView: UIView!
    @IBOutlet weak var pulseRateLbl: UILabel!
    @IBOutlet weak var pulseRateUnitLbl: UILabel!
    @IBOutlet weak var pulseRateStepper: UIStepper!
    @IBOutlet weak var pulseRateStatus: UILabel!
    
    @IBOutlet weak var bpSystolicName: UILabel!
    @IBOutlet weak var bpSystolicView: UIView!
    @IBOutlet weak var bpSystolicLbl: UILabel!
    @IBOutlet weak var bpSystolicUnitLbl: UILabel!
    @IBOutlet weak var bpSystolicStepper: UIStepper!
    @IBOutlet weak var bp_range: UILabel!
    
    @IBOutlet weak var bpDiastolicName: UILabel!
    @IBOutlet weak var bpDiastolicView: UIView!
    @IBOutlet weak var bpDiastolicLbl: UILabel!
    @IBOutlet weak var bpDiastolicUnitLbl: UILabel!
    @IBOutlet weak var bpDiastolicStepper: UIStepper!
    
    @IBOutlet weak var bloodGroupName: UILabel!
    @IBOutlet weak var bloodGroopView: UIView!
    @IBOutlet weak var bloodGroopImageView: UIImageView!
    
    @IBOutlet weak var bloodGroupDropDown: DropDown!
        
    @IBOutlet weak var save_btn: UIButton!
    var jsonArray: [[String: String]] = [[String: String]]()
   // var weightJson:([String : String]) = [String: String]()
    var weightJsonConvert :([String : String]) = [String: String]()
    var heightJsonConvert :([String : String]) = [String: String]()
    var respRateJsonConvert :([String : String]) = [String: String]()
    var pulseRateJsonConvert :([String : String]) = [String: String]()
    var systolicJsonConvert :([String : String]) = [String: String]()
    var dystolicJsonConvert :([String : String]) = [String: String]()
    var o2JsonConvert :([String : String]) = [String: String]()
    var bmiJsonConvert :([String : String]) = [String: String]()
    var bloodGroupJson :([String : String]) = [String: String]()
    //var bmi:String = "";

    override func viewDidLoad() {
      super.viewDidLoad()
        self.showInternetAlert()
        navigationItem.titleView?.tintColor = .white

        // The list of array to display. Can be changed dynamically
        bloodGroupDropDown.optionArray = ["Select blood group","Unknown","A+","A-","A+","B+","B-","AB+","AB-","O+","O-"]
        bloodGroupDropDown.isSearchEnable = false
        bloodGroupDropDown.cornerRadius = 360
        bloodGroupDropDown.selectedRowColor = .systemPink
       
        bloodGroupDropDown.arrowColor = .blue
        
        let bloodGroup = UserDefaults.standard.string(forKey: "bloodGroupUd")
        if bloodGroup?.isEmpty ?? true {
            print("str is nil or empty")
           // bloodGroupDropDown.isEnabled = true
            
        }else{
            bloodGroupDropDown.text =  bloodGroup
            //bloodGroupDropDown.isEnabled = false
        }
        bloodGroupDropDown.didSelect{ [self](selectedText , index ,id) in
       print("Selected String: \(selectedText) \n index: \(index)")
            createJsonArray(id: AppConstant.BLOOD_GROUP_ID, name: bloodGroupName.text!, value: selectedText, unit: "")
            
            UserDefaults.standard.set(selectedText, forKey: "bloodGroupUd")
        }
        weightImageView.image =  UIImage(named: "weight")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        heightImageView.image =  UIImage(named: "height")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        bloodGroopImageView.image =  UIImage(named: "blooddrop")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)

        weightFunc()
        heightFunc()
        bmiFunc()
        resprateFunc()
        o2Func()
        pulseRateFunc()
        bpSystolicFunc()
        bpDiastolicFunc()
        bloodGroupFunc()
       
        
        let bmi = calculateBmi(weight: weightLbl.text!, height: heightLbl.text!)
        bmiStatus.text = bmi
        bpCalc(temp: Float(bpSystolicLbl.text!)! , temp1: Float(bpDiastolicLbl.text!)!)
        respRateCalc(temp: Float(respRateLbl.text!)!)
        o2Level(temp: Float(o2Lbl.text!)!)
        
        
    }

    @IBAction func weigtStepperAction(_ sender: UIStepper) {
        weightLbl.text = sender.value.description

       let bmi = calculateBmi(weight: weightLbl.text!, height: heightLbl.text!)
        bmiStatus.text = bmi
        print("bmiiiii \(bmi)")
        createJsonArray(id: AppConstant.WEIGHT_ID, name: weightName.text!, value: weightLbl.text!, unit: weightUnitLbl.text!)
        
    }
    @IBAction func heigtStepperAction(_ sender: UIStepper) {
        heightLbl.text = sender.value.description
        
        let bmi = calculateBmi(weight: weightLbl.text!, height: heightLbl.text!)
        bmiStatus.text = bmi
        createJsonArray(id: AppConstant.HEIGHT_ID, name: heightName.text!, value: heightLbl.text!, unit: heightUnitLbl.text!)
    }
    @IBAction func bmiStepperAction(_ sender: UIStepper) {
        bmiLbl.text = sender.value.description
        createJsonArray(id: AppConstant.BMI_ID, name: bmiName.text!, value: bmiLbl.text!, unit: bmiUnitLbl.text!)
    }
    @IBAction func respRateStepperAction(_ sender: UIStepper) {
        respRateLbl.text = sender.value.description
        respRateCalc(temp: Float(respRateLbl.text!)!)
        createJsonArray(id: AppConstant.RESP_RATE_ID, name: respRateName.text!, value: respRateLbl.text!, unit: respRateUnitLbl.text!)
    }
    @IBAction func o2StepperAction(_ sender: UIStepper) {
        o2Lbl.text = sender.value.description
        o2Level(temp: Float(o2Lbl.text!)!)
        createJsonArray(id: AppConstant.O2_ID, name: o2Name.text!, value: o2Lbl.text!, unit: o2UnitLbl.text!)
    }
    @IBAction func pulseRateStepperAction(_ sender: UIStepper) {
        pulseRateLbl.text = sender.value.description
        createJsonArray(id: AppConstant.PULSE_RATE_ID, name: pulseRateName.text!, value: pulseRateLbl.text!, unit: pulseRateUnitLbl.text!)
    }
    @IBAction func bpSysStepperAction(_ sender: UIStepper) {
        bpSystolicLbl.text = sender.value.description
        bpCalc(temp: Float(bpSystolicLbl.text!)! , temp1: Float(bpDiastolicLbl.text!)!)
        createJsonArray(id: AppConstant.BLOOD_SYSTOLIC_ID, name: bpSystolicName.text!, value: bpSystolicLbl.text!, unit: bpSystolicUnitLbl.text!)
    }
    @IBAction func bpDistolicAction(_ sender: UIStepper) {
        bpDiastolicLbl.text = sender.value.description
        bpCalc(temp: Float(bpSystolicLbl.text!)! , temp1: Float(bpDiastolicLbl.text!)!)
        createJsonArray(id: AppConstant.BLOOD_DYSTOLIC_ID, name: bpDiastolicName.text!, value: bpDiastolicLbl.text!, unit: bpDiastolicUnitLbl.text!)
    }
    @IBAction func bloodGroupAction(_ sender: Any) {
        //createJsonArray(id: AppConstant.BLOOD_GROUP_ID, name: bloodGroupName.text!, value: bloodGroupDropDown.text!, unit: "")
    }
    
    @IBAction func weightTrend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.WEIGHT_ID, name:weightName.text!)
    }
    @IBAction func heightTrend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.HEIGHT_ID, name:heightName.text!)
    }
    @IBAction func bmiTrend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.BMI_ID, name:bmiName.text!)
    }
    @IBAction func respRateTrend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.RESP_RATE_ID, name:respRateName.text!)
    }
    @IBAction func o2Trend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.O2_ID, name:o2Name.text!)
    }
    @IBAction func pulseRateTrend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.PULSE_RATE_ID, name:pulseRateName.text!)
    }
    @IBAction func bpSysTrend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.BLOOD_SYSTOLIC_ID, name:bpSystolicName.text!)
    }
    @IBAction func bpDistolicTrend(_ sender: Any) {
        toNextViewConroler(vital_id: AppConstant.BLOOD_DYSTOLIC_ID, name:bpDiastolicName.text!)
    }
    @IBAction func saveApi(_ sender: Any) {
        
        if weightJsonConvert.count != 0{
            jsonArray.append(weightJsonConvert )
        }
        if heightJsonConvert.count != 0{
            jsonArray.append(heightJsonConvert )
        }
        if bmiJsonConvert.count != 0{
            jsonArray.append( bmiJsonConvert )
        }
        if respRateJsonConvert.count != 0{
            jsonArray.append( respRateJsonConvert )
        }
        if pulseRateJsonConvert.count != 0{
            jsonArray.append(pulseRateJsonConvert )
        }
        if systolicJsonConvert.count != 0{
            jsonArray.append( systolicJsonConvert )
        }
        if dystolicJsonConvert.count != 0{
            jsonArray.append( dystolicJsonConvert )
        }
        if o2JsonConvert.count != 0{
            jsonArray.append( o2JsonConvert )
        }
        if bloodGroupJson.count != 0{
            jsonArray.append( bloodGroupJson )
        }
       print("jsonArray2 \(jsonArray)")
        if jsonArray.isEmpty {
            alert(title: "", message: "Make some changes before saving data !")
        }else{
            saveApi()
        }
        
    }
    
    func toNextViewConroler(vital_id:String,name:String){
        
    let viewController:StatsViewController = (UIStoryboard.init(name: "phr", bundle: Bundle.main).instantiateViewController(withIdentifier: "StatsViewController") as? StatsViewController)!
       viewController.name = name
       viewController.vital_id = vital_id
       self.navigationController!.show(viewController, sender: self)
}
    
    func createJsonArray(id:String,name:String,value:String,unit:String){
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self.self, fromKey: "patientDetails")
           let crno = obj!.crno
           if(id == AppConstant.WEIGHT_ID){
               let  weightJson = ([
                   "crno": crno,
                   "recordDate": "",
                   "vitalName": name,
                   "vitalId": id,
                   "vitalValue": value,
                   "vitalUnit": unit,
                   "docName": "",
                   "imageData": ""])
               
               if let json = try? JSONSerialization.data(withJSONObject: weightJson, options: []) {
                              if let content = String(data: json, encoding: String.Encoding.utf8) {
                                  // here `content` is the JSON dictionary containing the String
                                  print("content \(content)")
                                  let jsonData = content.data(using: .utf8)!
                                  weightJsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                                  
                              }
                          }
               
              
              // jsonArray.append(weightJson as! [String : String])
               
          }else if(id == AppConstant.HEIGHT_ID){
              let heightJson = ([
              "crno": crno,
              "recordDate": "",
              "vitalName": name,
              "vitalId": id,
              "vitalValue": value,
              "vitalUnit": unit,
              "docName": "",
              "imageData": ""])
              if let json = try? JSONSerialization.data(withJSONObject: heightJson, options: []) {
                             if let content = String(data: json, encoding: String.Encoding.utf8) {
                                 // here `content` is the JSON dictionary containing the String
                                 print("content \(content)")
                                 let jsonData = content.data(using: .utf8)!
                                  heightJsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                                // jsonArray.append(json as! [String : String])
                             }
                         }
              // jsonArray.append(heightJson as! [String : String])
         }else if(id == AppConstant.RESP_RATE_ID){
             let respRateJson = ([
             "crno": crno,
             "recordDate": "",
             "vitalName": name,
             "vitalId": id,
             "vitalValue": value,
             "vitalUnit": unit,
             "docName": "",
             "imageData": ""])
             if let json = try? JSONSerialization.data(withJSONObject: respRateJson, options: []) {
                            if let content = String(data: json, encoding: String.Encoding.utf8) {
                                // here `content` is the JSON dictionary containing the String
                                print("content \(content)")
                                let jsonData = content.data(using: .utf8)!
                                 respRateJsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                              //  jsonArray.append(json as! [String : String])
                            }
                        }
             // jsonArray.append(respRateJson as! [String : String])
        }else if(id == AppConstant.PULSE_RATE_ID){
            let pulseRateJson = ([
            "crno": crno,
            "recordDate": "",
            "vitalName": name,
            "vitalId": id,
            "vitalValue": value,
            "vitalUnit": unit,
            "docName": "",
            "imageData": ""])
            if let json = try? JSONSerialization.data(withJSONObject: pulseRateJson, options: []) {
                           if let content = String(data: json, encoding: String.Encoding.utf8) {
                               // here `content` is the JSON dictionary containing the String
                               print("content \(content)")
                               let jsonData = content.data(using: .utf8)!
                                pulseRateJsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                               //jsonArray.append(json as! [String : String])
                           }
                       }
            // jsonArray.append(pulseRateJson as! [String : String])
       }else if(id == AppConstant.BLOOD_SYSTOLIC_ID){
           let systolicJson = ([
           "crno": crno,
           "recordDate": "",
           "vitalName": name,
           "vitalId": id,
           "vitalValue": value,
           "vitalUnit": unit,
           "docName": "",
           "imageData": ""])
           if let json = try? JSONSerialization.data(withJSONObject: systolicJson, options: []) {
                          if let content = String(data: json, encoding: String.Encoding.utf8) {
                              // here `content` is the JSON dictionary containing the String
                              print("content \(content)")
                              let jsonData = content.data(using: .utf8)!
                               systolicJsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                              //jsonArray.append(json as! [String : String])
                          }
                      }
           // jsonArray.append(systolicJson as! [String : String])
       }else if(id == AppConstant.BLOOD_DYSTOLIC_ID){
          let dystolicJson = ([
          "crno": crno,
          "recordDate": "",
          "vitalName": name,
          "vitalId": id,
          "vitalValue": value,
          "vitalUnit": unit,
          "docName": "",
          "imageData": ""])
           if let json = try? JSONSerialization.data(withJSONObject: dystolicJson, options: []) {
                          if let content = String(data: json, encoding: String.Encoding.utf8) {
                              // here `content` is the JSON dictionary containing the String
                              print("content \(content)")
                              let jsonData = content.data(using: .utf8)!
                               dystolicJsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                              //jsonArray.append(json as! [String : String])
                          }
                      }
           //jsonArray.append(dystolicJson as! [String : String])
        }else if(id == AppConstant.O2_ID){
         let o2Json = ([
         "crno": crno,
         "recordDate": "",
         "vitalName": name,
         "vitalId": id,
         "vitalValue": value,
         "vitalUnit": unit,
         "docName": "",
         "imageData": ""])
            if let json = try? JSONSerialization.data(withJSONObject: o2Json, options: []) {
                           if let content = String(data: json, encoding: String.Encoding.utf8) {
                               // here `content` is the JSON dictionary containing the String
                               print("content \(content)")
                               let jsonData = content.data(using: .utf8)!
                                o2JsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                               //jsonArray.append(json as! [String : String])
                           }
                       }
         // jsonArray.append(o2Json as! [String : String])
       }else if(id == AppConstant.BMI_ID){
        let bmiJson = ([
        "crno": crno,
        "recordDate": "",
        "vitalName": name,
        "vitalId": id,
        "vitalValue": value,
        "vitalUnit": unit,
        "docName": "",
        "imageData": ""])
           if let json = try? JSONSerialization.data(withJSONObject: bmiJson, options: []) {
                          if let content = String(data: json, encoding: String.Encoding.utf8) {
                              // here `content` is the JSON dictionary containing the String
                              print("content \(content)")
                              let jsonData = content.data(using: .utf8)!
                               bmiJsonConvert = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                             // jsonArray.append(json as! [String : String])
                          }
                      }
        // jsonArray.append(bmiJson as! [String : String])
       }else if(id == AppConstant.BLOOD_GROUP_ID){
        let bloodGroupJson = ([
        "crno": crno,
        "recordDate": "",
        "vitalName": name,
        "vitalId": id,
        "vitalValue": value,
        "vitalUnit": "",
        "docName": "",
        "imageData": ""])
           if let json = try? JSONSerialization.data(withJSONObject: bloodGroupJson, options: []) {
                          if let content = String(data: json, encoding: String.Encoding.utf8) {
                              // here `content` is the JSON dictionary containing the String
                              print("content \(content)")
                              let jsonData = content.data(using: .utf8)!
                              self.bloodGroupJson = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : String]
                             // jsonArray.append(json as! [String : String])
                          }
                      }
          
        //jsonArray.append(bloodGroupJson as! [String : String])
      }
        print("jsonArray \(jsonArray)")
       }
    
   
    func weightFunc() {
        weightStepper.autorepeat = true
        weightStepper.isContinuous = true
        weightLbl.text = weightStepper.value.description
       
        weightStepper.minimumValue = 1.0
        weightStepper.maximumValue = 250.0
        weightStepper.value = 60.0
        weightView.layer.cornerRadius = 10
        weightLbl.text =  String(weightStepper.value)
    }
    func heightFunc() {
        heightStepper.autorepeat = true
        heightStepper.isContinuous = true
        heightLbl.text = heightStepper.value.description
       
        heightStepper.minimumValue = 30.0
        heightStepper.maximumValue = 250.0
        heightStepper.value = 170.0
        heightView.layer.cornerRadius = 10
        heightLbl.text =  String(heightStepper.value)
    }
    func bmiFunc() {
        bmiStepper.isHidden = true
        bmiStepper.autorepeat = true
        bmiStepper.isContinuous = true
        bmiLbl.text = bmiStepper.value.description
       
        bmiStepper.minimumValue = 1.0
        bmiStepper.maximumValue = 99.0
        bmiStepper.value = 60.0
        bmiView.layer.cornerRadius = 10
        bmiLbl.text =  String(bmiStepper.value)
    }
    func resprateFunc() {
        respRateStepper.autorepeat = true
        respRateStepper.isContinuous = true
        respRateLbl.text = respRateStepper.value.description
       
        respRateStepper.minimumValue = 1.0
        respRateStepper.maximumValue = 99.0
        respRateStepper.value = 12.0
        respRateView.layer.cornerRadius = 10
        respRateLbl.text =  String(respRateStepper.value)
    }
    func o2Func() {
        o2Stepper.autorepeat = true
        o2Stepper.isContinuous = true
        o2Lbl.text = o2Stepper.value.description
       
        o2Stepper.minimumValue = 1.0
        o2Stepper.maximumValue = 100.0
        o2Stepper.value = 99.0
        o2View.layer.cornerRadius = 10
        o2Lbl.text =  String(o2Stepper.value)
    }
    func pulseRateFunc() {
        pulseRateStepper.autorepeat = true
        pulseRateStepper.isContinuous = true
        pulseRateLbl.text = pulseRateStepper.value.description
       
        pulseRateStepper.minimumValue = 1.0
        pulseRateStepper.maximumValue = 250.0
        pulseRateStepper.value = 72.0
        pulseRateView.layer.cornerRadius = 10
        pulseRateLbl.text =  String(pulseRateStepper.value)
    }
    func bpSystolicFunc() {
        bpSystolicStepper.autorepeat = true
        bpSystolicStepper.isContinuous = true
        bpSystolicLbl.text = bpSystolicStepper.value.description
       
        bpSystolicStepper.minimumValue = 1.0
        bpSystolicStepper.maximumValue = 250.0
        bpSystolicStepper.value = 120.0
        bpSystolicView.layer.cornerRadius = 10
        bpSystolicLbl.text =  String(bpSystolicStepper.value)
    }
    func bpDiastolicFunc() {
        bpDiastolicStepper.autorepeat = true
        bpDiastolicStepper.isContinuous = true
        bpDiastolicLbl.text = bpDiastolicStepper.value.description
       
        bpDiastolicStepper.minimumValue = 1.0
        bpDiastolicStepper.maximumValue = 250.0
        bpDiastolicStepper.value = 80.0
        bpDiastolicView.layer.cornerRadius = 10
        bpDiastolicLbl.text =  String(bpDiastolicStepper.value)
    }
    func bloodGroupFunc() {
        bloodGroopView.layer.cornerRadius = 10
    }
    private func showAlert(message:String)  {
        DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Info!", message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func calculateBmi( weight:String,height:String) -> String {
        
        if (weight.isEmpty && height.isEmpty) {
            showAlert(message: "Weight and Height can't be empty")
        }else{
            let temp = Float(height)! / 100;
            let bmi = Float(weight)! / (temp * temp);
            bmiLbl.text = String(bmi)
           // createJsonArray(BMI_ID, name3.getText().toString(), integer_number3.getText().toString(), measure3.getText().toString());
            if (bmi > 30) {
                return "Obese";
            } else if (bmi < 18.5) {
                return "Underweight";
            } else if (bmi >= 18.5 && bmi <= 24.9) {
                return "Normal";
            } else if (bmi >= 25.0 && bmi <= 29.9) {
                return "Overweight";
            } else {
                return "";
            }
        }
        return "";
        }
    
    func respRateCalc(temp:Float) {
    if (temp == 0) {
        respRateStatus.text = "Respiratory Rate cannot be 0."
    } else if (temp > 0 && temp < 9) {
        respRateStatus.text = "Low RR"
    } else if (temp > 20) {
        respRateStatus.text = "High RR"
    } else {
        respRateStatus.text = "Normal"
    }
    }
    
    func  o2Level(temp:Float) {
    if (temp == 0) {
    o2Status.text = "O2 cannot be 0."
    } else if (temp > 95 && temp < 100) {
        o2Status.text = "Normal"
    } else if (temp > 90 && temp < 95) {
        o2Status.text = "Concerning"
    } else if (temp<=90){
        o2Status.text = "Critical"
    }
    }
    func bpCalc(temp:Float,temp1:Float) {
           if (temp != 0 && temp1 != 0) {
               bp_range.isHidden = false
               if ((temp <= 60) && (temp1 <= 90)) {
                   bp_range.text = "Low BP"
               }
               if ((temp <= 60) && (temp1 > 90)) {
                   bp_range.text = "Ideal BP"
               } else if ((temp > 60 && temp <= 80) && (temp1 > 90 && temp1 <= 120)) {
                   bp_range.text = "Ideal BP"
               } else if ((temp > 60 && temp <= 80) && (temp1 > 120 && temp1 <= 140)) {
                   bp_range.text = "Hypertension Stage 1"
               } else if ((temp > 80 && temp <= 90) && (temp1 > 120 && temp1 <= 140)) {
                   bp_range.text = "Hypertension Stage 1"
               } else if ((temp > 80 && temp <= 90) && temp1 > 140) {
                   bp_range.text = "Hypertension Stage 2"
               } else if (temp > 90 && temp1 > 140) {
                   bp_range.text = "Hypertension Stage 2"
               } else if (temp1 == 0) {
                   bp_range.text = "Systolic cannot be 0."
               } else {
                  // bp_range.isHidden = true
                   bp_range.text = "Normal"

               }
           } else {
               bp_range.text = "Systolic cannot be 0."
           }
       }
    
    
    private func saveApi(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let url = URL(string: ServiceUrl.savePhrUrl)
       print(ServiceUrl.savePhrUrl)
       

        let jsonData = try? JSONSerialization.data(withJSONObject: jsonArray)

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
                
                let status:String = responseJSON["status"] as! String
                let message:String = (responseJSON["msg"]) as! String
               // let crno = (responseJSON["CrNo"])
                print("Status \(status)")
                
                if (status == "1")
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.successAlert(title: "", message:message)
                        self.jsonArray.removeAll()
                    }
                                       
                }else{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.alert(title: "", message:message)
                    }
                  
                }
            }
        }

        task.resume()
    }
    
    func alert(title:String,message:String)  {
        DispatchQueue.main.async {
           
        let alertController = UIAlertController(title: title, message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            let attributedString = NSAttributedString(string: message, attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                        NSAttributedString.Key.foregroundColor : UIColor.red
                    ])
            alertController.setValue(attributedString, forKey: "attributedMessage")
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func successAlert(title:String,message:String)  {
        DispatchQueue.main.async {
            //1. Create the alert controller.
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            //alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Home", style: .default, handler: { [self, weak alert] (_) in
                let sceneDelegate = UIApplication.shared.connectedScenes
                    .first!.delegate as! SceneDelegate
                sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientNavigationController") as! UINavigationController
            }
            ))
                        let attributedString = NSAttributedString(string: message, attributes: [
                                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                                    NSAttributedString.Key.foregroundColor : UIColor.systemGreen
                                ])
                 alert.setValue(attributedString, forKey: "attributedMessage")
               
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
     
        }
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
