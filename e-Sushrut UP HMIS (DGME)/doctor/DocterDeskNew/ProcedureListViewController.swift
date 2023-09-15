//
//  ProcedureListViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 27/07/23.
//

import UIKit

class ProcedureListViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var close_iv: UIImageView!
    let searchController=UISearchController(searchResultsController: nil)
    @IBOutlet weak var myTextField: UITextField!

    
    var callBack: ((_ serviceAreaName: String,_ proceduresName: String, _ serviceAreaCode: String, _ procedureCode: String)-> Void)?
    
    var arrProcedureFitlter = [ProcedureModel]()
    var arrProcedure = [ProcedureModel]()
    
    var from:Int = 0
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
        
    }
    
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func searchRecord(sender: UITextField){
        self.arrProcedureFitlter.removeAll()
        let searchData:Int = myTextField.text!.count
        if(searchData != 0){
            searching = true
            for department in arrProcedure{
                if let deptToSearch = myTextField.text{
                    let range = department.PROCEDURE_NAME.lowercased().range(of: deptToSearch,options: .caseInsensitive,range: nil,locale: nil)
                    if(range != nil){
                        self.arrProcedureFitlter.append(department)
                    }
                }
            }
        }else{
            arrProcedureFitlter = self.arrProcedure
            searching = false
        }
        tableView.reloadData()
        
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
extension ProcedureListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var arrCount:Int = 0
        if(self.from == 1){
            if(searching){
                arrCount = arrProcedureFitlter.count
            }else{
                arrCount = arrProcedure.count
            }
        }
       
        return arrCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           if(self.from == 1){
               if(searching){
                   cell.textLabel?.text = "  "+arrProcedureFitlter[indexPath.row].PROCEDURE_NAME

               }else{
                   cell.textLabel?.text = "  "+arrProcedure[indexPath.row].PROCEDURE_NAME
               }
            }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if(self.from == 1){
          if(searching){
              callBack?(arrProcedureFitlter[indexPath.row].SERVICE_AREA_NAME,arrProcedureFitlter[indexPath.row].PROCEDURE_NAME,arrProcedureFitlter[indexPath.row].SERVICE_AREA_CODE,arrProcedureFitlter[indexPath.row].PROCEDURE_DETAIL)
          }else{
              callBack?(arrProcedure[indexPath.row].SERVICE_AREA_NAME,arrProcedure[indexPath.row].PROCEDURE_NAME,arrProcedure[indexPath.row].SERVICE_AREA_CODE,arrProcedure[indexPath.row].PROCEDURE_DETAIL)
          }
          
         }
       
        self.dismiss(animated: true, completion: nil)
    }
}



