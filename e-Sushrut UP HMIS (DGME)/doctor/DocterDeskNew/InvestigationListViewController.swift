//
//  InvestigationListViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 25/07/23.
//

import UIKit

class InvestigationListViewController: UIViewController{
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var close_iv: UIImageView!
    let searchController=UISearchController(searchResultsController: nil)
    
    var callBack: ((_ title: String, _ titleID: String, _ isConsentStr: String,  _ testDetail:String,  _ visitDate:String, _ testName:String)-> Void)?
    
    var investigationFilterData = [InvestigationModel]()
    var arrInvestigation = [InvestigationModel]()
    
    var from:Int = 0
    var searching = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    @objc func searchRecord(sender: UITextField){
        self.investigationFilterData.removeAll()
        let searchData:Int = myTextField.text!.count
        if(searchData != 0){
            searching = true
            for department in arrInvestigation{
                if let deptToSearch = myTextField.text{
                    let range = department.TEST_NAME.lowercased().range(of: deptToSearch,options: .caseInsensitive,range: nil,locale: nil)
                    if(range != nil){
                        self.investigationFilterData.append(department)
                    }
                }
            }
        }else{
            investigationFilterData = self.arrInvestigation
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
extension InvestigationListViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var arrCount:Int = 0
        if(searching){
            if(self.from == 1){
               arrCount = investigationFilterData.count
           }
        }else{
            if(self.from == 1){
               arrCount = arrInvestigation.count
           }
        }
        
        return arrCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searching){
            if(self.from == 1){
                cell.textLabel?.text = "  "+investigationFilterData[indexPath.row].TEST_NAME
             }
        }else{
            if(self.from == 1){
                cell.textLabel?.text = "  "+arrInvestigation[indexPath.row].TEST_NAME
             }
        }
          
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searching){
            if(self.from == 1){
                callBack?(investigationFilterData[indexPath.row].TEST_NAME,investigationFilterData[indexPath.row].SAMPLECODE,investigationFilterData[indexPath.row].ISCONSENTREQUIRED,investigationFilterData[indexPath.row].TEST_DETAIL,investigationFilterData[indexPath.row].VISIT_DATE,investigationFilterData[indexPath.row].TEST_NAME)
               }
        }else{
            if(self.from == 1){
                callBack?(arrInvestigation[indexPath.row].TEST_NAME,arrInvestigation[indexPath.row].SAMPLECODE,arrInvestigation[indexPath.row].ISCONSENTREQUIRED,arrInvestigation[indexPath.row].TEST_DETAIL,arrInvestigation[indexPath.row].VISIT_DATE,arrInvestigation[indexPath.row].TEST_NAME)
               }
        }
     
       
        self.dismiss(animated: true, completion: nil)
    }
}



