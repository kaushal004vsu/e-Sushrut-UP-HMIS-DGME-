//
//  DrugListStandardViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 28/07/23.
//

import UIKit

class DrugListStandardViewController: UIViewController , UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var close_iv: UIImageView!
    let searchController=UISearchController(searchResultsController: nil)
    
    var callBack: ((_ id: String, _ name: String, _ age: String, _ shot_name: String,_ arrayList: String)-> Void)?
    @IBOutlet weak var myTextField: UITextField!

    
    var deptFilterData=[DrugListStandardModel]()
    var detpArrData = [DrugListStandardModel]()
    
    
    var from:Int = 0
    var zoneId:String = ""
    var divisionId:String = ""
    var hospCode:String = ""
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.delegate = self
        myTextField.addTarget(self, action: #selector(searchRecord), for: .editingChanged)
        
        close_iv.layer.cornerRadius = close_iv.frame.height / 2
        close_iv.clipsToBounds = true
        showAlert()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:)))
        close_iv.isUserInteractionEnabled = true
        close_iv.addGestureRecognizer(tapGestureRecognizer)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Select Item"
        tableView.reloadData()
//        DispatchQueue.main.async {
//            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
//        }
       // getZoneList()
        
    }
    @objc func searchRecord(sender: UITextField){
        self.deptFilterData.removeAll()
        let searchData:Int = myTextField.text!.count
        if(searchData != 0){
            searching = true
            for department in detpArrData{
                if let deptToSearch = myTextField.text{
                    let range = department.LABEL.lowercased().range(of: deptToSearch,options: .caseInsensitive,range: nil,locale: nil)
                    if(range != nil){
                        self.deptFilterData.append(department)
                    }
                }
            }
        }else{
            deptFilterData = self.detpArrData
            searching = false
        }
        tableView.reloadData()
        
    }
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
 
    func showAlert() {
        if !AppUtilityFunctions.isInternetAvailable() {
            alert(title: "Warning",message: "The Internet is not available")
        }
    }
    func alert(title:String,message:String)
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
@available(iOS 13.0, *)
extension DrugListStandardViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var arrCount:Int = 0
        if(searching){
            if(self.from == 1){
                arrCount = deptFilterData.count
            }
        }else{
            if(self.from == 1){
                arrCount = detpArrData.count
            }
        }
       
        return arrCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrugStandurdTableViewCell
        if(searching){
            if(self.from == 1){
                let qtyStr =  deptFilterData[indexPath.row].QTY.slice(from: "(", to: ")")!

                cell.short_type_btn.setTitle(deptFilterData[indexPath.row].ITEM_TYPE_SHORT_NAME, for: .normal)
                cell.label_lbl?.text = "  "+deptFilterData[indexPath.row].LABEL
                cell.qty_lbl?.text = qtyStr
             }
        }else{
            if(self.from == 1){
                let qtyStr =  detpArrData[indexPath.row].QTY.slice(from: "(", to: ")")!

                cell.short_type_btn.setTitle(detpArrData[indexPath.row].ITEM_TYPE_SHORT_NAME, for: .normal)
                cell.label_lbl?.text = detpArrData[indexPath.row].LABEL
                cell.qty_lbl?.text = qtyStr
             }
        }
         
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searching){
            if(self.from == 1){
               let qtyStr =  deptFilterData[indexPath.row].QTY.slice(from: "(", to: ")")!
                callBack?(deptFilterData[indexPath.row].LABEL,deptFilterData[indexPath.row].VALUE,qtyStr,deptFilterData[indexPath.row].ITEM_TYPE_SHORT_NAME,deptFilterData[indexPath.row].EXPDATE)
             }
        }else{
            if(self.from == 1){
                let qtyStr =  detpArrData[indexPath.row].QTY.slice(from: "(", to: ")")!
                callBack?(detpArrData[indexPath.row].LABEL,detpArrData[indexPath.row].VALUE,qtyStr,detpArrData[indexPath.row].ITEM_TYPE_SHORT_NAME,detpArrData[indexPath.row].EXPDATE)
             }
        }
       
        self.dismiss(animated: true, completion: nil)
    }
}


