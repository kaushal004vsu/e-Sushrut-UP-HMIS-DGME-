//
//  LiveQueueStatusViewController.swift
//  Railways-HMIS
//
//  Created by HICDAC on 02/03/23.
//

import UIKit

class LiveQueueStatusViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var liveQueNoLbl: UILabel!
    
    @IBOutlet weak var hospNameLbl: UILabel!
    
    @IBOutlet weak var deptNameLbl: UILabel!
    @IBOutlet weak var refresh_iv: UIImageView!
    
    @IBOutlet weak var waitingTimeLbl: UILabel!
    
    @IBOutlet weak var deptSpinner: UIButton!
    
    var arrData = [LiveQueModel]()
    
    let uiPicker = UIPickerView()
    var arrDeptUnit = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn()
       circleLabel()
       jsonParsing(row: 0)
        
        self.deptSpinner.setTitle("", for: .normal)
        deptSpinner.backgroundColor = .clear
        deptSpinner.layer.cornerRadius = 5
        deptSpinner.layer.borderWidth = 1
        deptSpinner.layer.borderColor = UIColor.blue.cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        refresh_iv.isUserInteractionEnabled = true
        refresh_iv.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        jsonParsing(row: 0)
    }
    func backBtn(){
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    func circleLabel(){
        liveQueNoLbl.text = "0"
        let size:CGFloat = 150.0
        liveQueNoLbl.textColor = UIColor.white
        liveQueNoLbl.textAlignment = .center
        liveQueNoLbl.font = UIFont.systemFont(ofSize: 50.0)
        liveQueNoLbl.frame = CGRect(x : 150.0,y : 150.0,width : size, height :  size)
        liveQueNoLbl.layer.cornerRadius = size / 2
        liveQueNoLbl.layer.borderWidth = 3.0
        liveQueNoLbl.layer.backgroundColor = UIColor.orange.cgColor
        liveQueNoLbl.layer.borderColor = UIColor.orange.cgColor
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
      }
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return arrDeptUnit.count
      }
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          let rowTitle = self.arrDeptUnit[row]
          self.deptSpinner.setTitle(rowTitle, for: .normal)
         return rowTitle
      }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(arrDeptUnit[row]) on \(row) index")
     
//        self.deptSpinner.setTitle(arrDeptUnit[row], for: .normal)
//        self.liveQueNoLbl.text = self.arrData[row].liveQueno
//        self.hospNameLbl.text = self.arrData[row].hosp_name
//        self.deptNameLbl.text = self.arrData[row].dept_name
//
//          self.waitingTimeLbl.text = "Average per person waiting time is: \(self.arrData[row].waitingTime) minutes(s)"
        jsonParsing(row: row)
        uiPicker.removeFromSuperview()
        uiPicker.resignFirstResponder()
    }
    @IBAction func deptSpineerBtn(_ sender: Any) {
        
        uiPicker.delegate = self as UIPickerViewDelegate
        uiPicker.dataSource = self as UIPickerViewDataSource
             self.view.addSubview(uiPicker)
        uiPicker.center = self.view.center
        uiPicker.backgroundColor = .white
     
    
    }

    func jsonParsing(row:Int){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }

        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let url = URL(string: ServiceUrl.testurl+"genericAppointment/getQNoStatus/3?hospCode=0&patCrNo="+obj!.crno)
        print("qnodata----\(url!)")
        
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let json = try JSON(data:data)
                   let jsonValue = json.arrayValue
                    let json2 = jsonValue[0]
                    let json3 = json2["qnodata"]
                    let str = String(json3.stringValue)
                    let ggg = str.replacingOccurrences(of: "\\", with: "")
                    
                    let res = try! JSONSerialization.jsonObject(with: ggg.data(using:.utf8)!, options: []) as! [[String:Any]]
                    //let resStr = "\(res)"
                    
                    let resJson = JSON(res)
                    let json4 = resJson.arrayValue
                    print("qnodata----\(json4)")
                    self.arrData.removeAll()
                    if (json4.count != 0){
                       for arr in json4{
                           self.arrData.append(LiveQueModel(json: arr))
                       }
                        DispatchQueue.main.async {
                        self.arrDeptUnit.removeAll()
                        for i in 0 ..< self.arrData.count {
                      
                                self.arrDeptUnit.append(self.arrData[i].unit_name)
                                self.view.activityStopAnimating()
                            }
                           
                      
                        self.liveQueNoLbl.text = self.arrData[row].liveQueno
                        self.hospNameLbl.text = self.arrData[row].hosp_name
                        self.deptNameLbl.text = self.arrData[row].dept_name
                        self.waitingTimeLbl.text = "Average per person waiting time is: \(self.arrData[row].waitingTime) minutes(s)"
                        self.deptSpinner.setTitle(self.arrData[row].unit_name, for: .normal)
                            if(self.arrDeptUnit.count == 1){
                                self.deptSpinner.isUserInteractionEnabled = false
                            }else{
                                self.deptSpinner.isUserInteractionEnabled = true
                            }
                        }
                        
                   }else{
                       DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                          // self.navigationController?.popToRootViewController(animated: true)
                           self.alert(title: "No Record Found!", message: "Live Queue No. not found for the selected patient.")
                       }
                   }
                }catch{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    print("aa"+error.localizedDescription)
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
}
