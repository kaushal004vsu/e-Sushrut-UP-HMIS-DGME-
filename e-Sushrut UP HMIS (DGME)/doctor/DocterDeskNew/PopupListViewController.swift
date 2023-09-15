//
//  PopupListViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 18/07/23.
//

import UIKit

class PopupListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var close_iv: UIImageView!
    let searchController=UISearchController(searchResultsController: nil)
    
    var callBack: ((_ id: String, _ name: String, _ age: String)-> Void)?
    
    @IBOutlet weak var myTextField: UITextField!
    
    var detpArrData = [OPDLiteDepartmentModel]()
    var deptFilterData=[OPDLiteDepartmentModel]()
    
    var arrInvestigation = [InvestigationModel]()
    var investigationFilterData = [InvestigationModel]()

     var arrHospList = [HospListModel]()
    var arrHospListFilterData = [HospListModel]()

    
    var from:Int = 0
    var zoneId:String = ""
    var divisionId:String = ""
    var hospCode:String = ""
    var arrCount:Int = 0
    var searching = false
    

    @IBOutlet weak var search_tf: UITextField!
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
     //   self.navigationItem.title = "Select Item"

        
    }
   
    @objc func searchRecord(sender: UITextField){
        self.deptFilterData.removeAll()
        let searchData:Int = myTextField.text!.count
        if(searchData != 0){
            searching = true
            for department in detpArrData{
                if let deptToSearch = myTextField.text{
                    let range = department.UNITNAME.lowercased().range(of: deptToSearch,options: .caseInsensitive,range: nil,locale: nil)
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
extension PopupListViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching){
            if(self.from == 1){
                arrCount = deptFilterData.count
            }else if(self.from == 2){
                arrCount = investigationFilterData.count
            }else if(self.from == 3){
                arrCount = arrHospListFilterData.count
            }
        }else{
            if(self.from == 1){
                arrCount = detpArrData.count
            }else if(self.from == 2){
                arrCount = arrInvestigation.count
            }else if(self.from == 3){
                arrCount = arrHospList.count
            }
        }
       
        return arrCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searching){
            if(self.from == 1){
                cell.textLabel?.text = "  "+deptFilterData[indexPath.row].UNITNAME
             }else  if(self.from == 2){
                 cell.textLabel?.text = "  "+investigationFilterData[indexPath.row].TEST_NAME
              }else  if(self.from == 3){
                  cell.textLabel?.text = "  "+arrHospListFilterData[indexPath.row].hospName
              }
        }else{
            if(self.from == 1){
                cell.textLabel?.text = "  "+detpArrData[indexPath.row].UNITNAME
             }else  if(self.from == 2){
                 cell.textLabel?.text = "  "+arrInvestigation[indexPath.row].TEST_NAME
              }else  if(self.from == 3){
                 cell.textLabel?.text = "  "+arrHospList[indexPath.row].hospName
              }
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searching){
            if(self.from == 1){
                callBack?(deptFilterData[indexPath.row].COLUMN,deptFilterData[indexPath.row].UNITNAME,deptFilterData[indexPath.row].HGSTR_UNITNAME)
             }else if(self.from == 2){
                 callBack?(investigationFilterData[indexPath.row].SAMPLECODE,investigationFilterData[indexPath.row].TEST_NAME,investigationFilterData[indexPath.row].TARIFF)
              }else if(self.from == 3){
                  callBack?(arrHospListFilterData[indexPath.row].hospCode,arrHospListFilterData[indexPath.row].hospName,arrHospListFilterData[indexPath.row].hospPhone)
              }
        }else{
            if(self.from == 1){
                callBack?(detpArrData[indexPath.row].COLUMN,detpArrData[indexPath.row].UNITNAME,detpArrData[indexPath.row].HGSTR_UNITNAME)
             }else if(self.from == 2){
                 callBack?(arrInvestigation[indexPath.row].SAMPLECODE,arrInvestigation[indexPath.row].TEST_NAME,arrInvestigation[indexPath.row].TARIFF)
              }else if(self.from == 3){
                 callBack?(arrHospList[indexPath.row].hospCode,arrHospList[indexPath.row].hospName,arrHospList[indexPath.row].hospPhone)
              }
        }
        self.dismiss(animated: true, completion: nil)
    }
}


