//
//  DrugAvaiabilityViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import iOSDropDown

class DrugAvaiabilityViewController: UIViewController {
    
    @IBOutlet var lblNoReportsFound: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var searchMedicineTable: UITableView!
    @IBOutlet weak var drugAvailabilityTable: UITableView!
    @IBOutlet weak var dropDown: DropDown!
   
  
    var medicineList=[MedicineModel]()
    var filterMedicineList = [MedicineModel]()
    var drugListModel=[DrugListModel]()
    
    var hospList=[HospListModel]()
    var arHospName = [String]();
    var arHospCode = [Int]();
    var hospCode:Int=0


    var searching = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        showAlert()
        
        dropDown.selectedRowColor = .systemBlue
        dropDown.listHeight = 300
        
        getHospital()
        
        //getBrandId()
        myTextField.addTarget(self, action: #selector(searchRecord), for: .editingChanged)
        myTextField.addTarget(self, action: #selector(TextBoxOn),for: .editingDidBegin)
        myTextField.delegate = self
        myTextField.clearButtonMode = .whileEditing
        
        searchMedicineTable.isHidden = true
        
       
        
        dropDown.didSelect { [self] selectedText, index, id in
            print("inside view did load  \(id)")
            self.hospCode=id
        }
       
        
    }

    
    @IBAction func searchDrugAction(_ sender: Any) {
    }
    @objc func TextBoxOn(sender: UITextField){
        if (dropDown.selectedIndex == nil) {
            showAlert(title: "Info", message: "Select Hospital")
        }
      
    }
    @objc func searchRecord(sender:UITextField){
        myTextField.isEnabled = true
        self.filterMedicineList.removeAll()
        let searchData:Int = myTextField.text!.count
        if searchData != 0{
            searchMedicineTable.isHidden = false
            drugAvailabilityTable.isHidden = true
            searching = true
            for list in medicineList {
                if let medicineToSearch = myTextField.text{
                    let range = list.brand_name.lowercased().range(of: medicineToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if(range != nil){
                        self.filterMedicineList.append(list)
                    }
                }
            }
        }else{
            filterMedicineList = medicineList
            searching = false
            searchMedicineTable.isHidden = true
            drugAvailabilityTable.isHidden = false
        }
        searchMedicineTable.reloadData()
        
    }

 
    
    func getHospital(){
        let url2 = ServiceUrl.teleconsultancyHospitalList

        let url = URL(string: url2)

       // print("url "+url2)
        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data else { return }
            do{
                var json = try JSON(data:data)
                if json.count == 0{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    self.searchMedicineTable.backgroundView=self.lblNoReportsFound
                    self.searchMedicineTable.separatorStyle = .none
                    self.searchMedicineTable.reloadData()
                    }
                }
                else{
                for arr in json.arrayValue{
                    self.hospList.append(HospListModel(json: arr))
                }
                    for i in 0 ..< self.hospList.count {
                        self.arHospName.append(self.hospList[i].hospName)
                        self.arHospCode.append(Int(self.hospList[i].hospCode)!)
                    }
                    dropDown.optionArray = self.arHospName
                    dropDown.optionIds = self.arHospCode
                
                    getBrandId()

                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                
            }catch{
                print("error"+error.localizedDescription)
            }
            }.resume()
    }
    
    func getBrandId(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let url2 = ServiceUrl.testurl+"railtelService/getItemBrand"

        let url = URL(string: url2)

       // print("url "+ServiceUrl.reportListUrl+"\(self.crno)&hosCode=0")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
        
                var json = try JSON(data:data)
              //  print(url)
               json=json["data"]
               // print(json)
                if json.count == 0
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    self.searchMedicineTable.backgroundView=self.lblNoReportsFound
                    self.searchMedicineTable.separatorStyle = .none
                    self.searchMedicineTable.reloadData()
                    }
                }
                else{
                for arr in json.arrayValue{
//                   print(arr["REPORTDATE"].stringValue)
                    self.medicineList.append(MedicineModel(json: arr))
                    
                }
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                DispatchQueue.main.async {
                    self.searchMedicineTable.backgroundView=nil
                    self.searchMedicineTable.separatorStyle = .singleLine
                    self.searchMedicineTable.reloadData()
                }
                    
                }
                
            }catch{
                print("error"+error.localizedDescription)
            }
            }.resume()
    }
    
    func getDrugAvailability(brandId:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let url2 = ServiceUrl.drugAvailabilty+"\(self.hospCode)&itemBrandId=\(brandId)"
        let url = URL(string: url2)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                var json = try JSON(data:data)
               json=json["data"]
                print(json)
              if json.count == 0
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.drugAvailabilityTable.backgroundView=self.lblNoReportsFound
                        self.drugAvailabilityTable.separatorStyle = .none
                        self.drugAvailabilityTable.reloadData()
                        self.showToast(message: "No Record found", font: .systemFont(ofSize: 12.0))
                    }
                  
              }
                else{
                for arr in json.arrayValue{
                   // self.drugListModel.removeAll()
                    self.drugListModel.append(DrugListModel(json: arr))
                    
                }
                   
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.drugAvailabilityTable.backgroundView=nil
                    self.drugAvailabilityTable.separatorStyle = .singleLine
                    self.drugAvailabilityTable.reloadData()
                    
                }
                    
                }
                
            }catch{
                print("error"+error.localizedDescription)
            }
            }.resume()
    }
    func showAlert(title:String,message:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                //self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
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

extension DrugAvaiabilityViewController: UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchMedicineTable{
            if searching{
                return filterMedicineList.count
            }else{
                return medicineList.count
            }
        }else{
            return drugListModel.count
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellToReturn = UITableViewCell()
        if tableView == self.searchMedicineTable{
            let cell = searchMedicineTable.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            if searching{
                cell.textLabel?.text  = filterMedicineList[indexPath.row].brand_name
            }else{
                cell.textLabel?.text  = medicineList[indexPath.row].brand_name
            }
            cellToReturn = cell
        }else if tableView == self.drugAvailabilityTable{
            let cell2 = drugAvailabilityTable.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell2.textLabel?.text  = drugListModel[indexPath.row].storen_ame
            cell2.detailTextLabel?.text  = drugListModel[indexPath.row].qty
            cellToReturn = cell2
        }
        
        return cellToReturn
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchMedicineTable.isHidden = false
        self.drugAvailabilityTable.isHidden = false
        if tableView == self.searchMedicineTable{
            self.drugListModel.removeAll()
            self.hideKeyboardWhenTappedAround()

            if searching{
                self.myTextField.text = filterMedicineList[indexPath.row].brand_name
                getDrugAvailability(brandId: filterMedicineList[indexPath.row].item_brand_id)
                
            }else{
                self.myTextField.text = medicineList[indexPath.row].brand_name
                getDrugAvailability(brandId: medicineList[indexPath.row].item_brand_id)

            }
        }
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        return true
    }
}
//extension DrugAvaiabilityViewController {
//
//func showToast(message : String, font: UIFont) {
//
//    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
//    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//    toastLabel.textColor = UIColor.white
//    toastLabel.font = font
//    toastLabel.textAlignment = .center;
//    toastLabel.text = message
//    toastLabel.alpha = 1.0
//    toastLabel.layer.cornerRadius = 10;
//    toastLabel.clipsToBounds  =  true
//    self.view.addSubview(toastLabel)
//    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
//         toastLabel.alpha = 0.0
//    }, completion: {(isCompleted) in
//        toastLabel.removeFromSuperview()
//    })
//} }

