//
//  PatientSearchViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import UIKit

class PatientSearchViewController: UIViewController , UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var close_iv: UIImageView!
    let searchController=UISearchController(searchResultsController: nil)
    
    var callBack: ((_ name: String, _ crStr: String, _ empId: String)-> Void)?
    
    
    var deptFilterData=[OPDLiteDepartmentModel]()
    var detpArrData = [OPDLiteDepartmentModel]()
    
    var arrPatientSearchModel = [PatientSearchModel]()
    
    var from:Int = 0
    var zoneId:String = ""
    var divisionId:String = ""
    var hospCode:String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()


        
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
        searchBarSetup()
        
    }
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    private func searchBarSetup(){
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        
        //self.searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 11.0, *) {
              navigationItem.searchController=searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            searchController.hidesNavigationBarDuringPresentation = true
            tableView.tableHeaderView = searchController.searchBar
        }
        
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
extension PatientSearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var arrCount:Int = 0
        if(self.from == 1){
            arrCount = arrPatientSearchModel.count
        }
        return arrCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          if(self.from == 1){
              
            
              let JSON = arrPatientSearchModel[indexPath.row].COLUMN
              let jsonData = JSON.data(using: .utf8)!
              // Convert the JSON object to a PatientParseModel object
              let patientParseModel: PatientParseModel = try! JSONDecoder().decode(PatientParseModel.self, from: jsonData)

              
              cell.textLabel?.text = "\n\(patientParseModel.patfirstname) \(patientParseModel.patmiddlename) \(patientParseModel.patlastname) \n\(patientParseModel.patCrNo)/\(patientParseModel.patIdno)\n"
              
              if (patientParseModel.patGenderCode == "M")
              {
                //  cell.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 205.0/255, alpha: 1.0)
                  cell.contentView.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 205.0/255, alpha: 1.0)

              }else
               {
               // cell.backgroundColor =  UIColor(red: 255.0/255, green: 105.0/255, blue: 180.0/255, alpha: 1.0)
                  cell.contentView.backgroundColor = UIColor(red: 255.0/255, green: 105.0/255, blue: 180.0/255, alpha: 1.0)
              }
              
              // add shadow on cell
//              cell.backgroundColor = .clear // very important
              cell.layer.masksToBounds = false
              cell.layer.shadowOpacity = 0.23
              cell.layer.shadowRadius = 0
              cell.layer.shadowOffset = CGSize(width: 0, height: 0)
              cell.layer.shadowColor = UIColor.black.cgColor

                  // add corner radius on `contentView`
              cell.contentView.layer.cornerRadius = 8
              let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
              cell.contentView.frame = cell.contentView.frame.inset(by: margins)
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if(self.from == 1){
           let JSON = arrPatientSearchModel[indexPath.row].COLUMN
           let jsonData = JSON.data(using: .utf8)!
           // Convert the JSON object to a PatientParseModel object
           let patientParseModel: PatientParseModel = try! JSONDecoder().decode(PatientParseModel.self, from: jsonData)
           callBack?(patientParseModel.patfirstname,patientParseModel.patCrNo,patientParseModel.patIdno)
        }
       
        self.dismiss(animated: true, completion: nil)
    }
}

extension PatientSearchViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if(self.from == 1){
            if searchText==""
            {
                self.detpArrData=self.deptFilterData
            }
            else{
                self.detpArrData=self.deptFilterData
                detpArrData=detpArrData.filter{
                    $0.UNITNAME.lowercased().contains(searchText.lowercased())
                }
            }
        }
        
        tableView.reloadData()
    }
}
