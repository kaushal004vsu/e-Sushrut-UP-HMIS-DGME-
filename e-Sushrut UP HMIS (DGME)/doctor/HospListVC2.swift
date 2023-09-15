//
//  HospListVC2.swift
//  e-Sushrut UP HMIS (DGME)
//
//  Created by HICDAC on 13/09/23.
//

import UIKit

class HospListVC2: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var close_iv: UIImageView!
    let searchController=UISearchController(searchResultsController: nil)
    
    var callBack: ((_ id: String, _ name: String, _ age: String)-> Void)?
    
    @IBOutlet weak var myTextField: UITextField!
    

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
        self.arrHospListFilterData.removeAll()
        let searchData:Int = myTextField.text!.count
        if(searchData != 0){
            searching = true
            for department in arrHospList{
                if let deptToSearch = myTextField.text{
                    let range = department.hospName.lowercased().range(of: deptToSearch,options: .caseInsensitive,range: nil,locale: nil)
                    if(range != nil){
                        self.arrHospListFilterData.append(department)
                    }
                }
            }
        }else{
            arrHospListFilterData = self.arrHospList
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
extension HospListVC2: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching){
        arrCount = arrHospListFilterData.count
        }else{
        arrCount = arrHospList.count
        }
        return arrCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searching){
        cell.textLabel?.text = ""+arrHospListFilterData[indexPath.row].hospName
        }else{
        cell.textLabel?.text = ""+arrHospList[indexPath.row].hospName
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searching){
         callBack?(arrHospListFilterData[indexPath.row].hospCode,arrHospListFilterData[indexPath.row].hospName,arrHospListFilterData[indexPath.row].hospPhone)
        }else{
         callBack?(arrHospList[indexPath.row].hospCode,arrHospList[indexPath.row].hospName,arrHospList[indexPath.row].hospPhone)
              
        }
        self.dismiss(animated: true, completion: nil)
    }
}


