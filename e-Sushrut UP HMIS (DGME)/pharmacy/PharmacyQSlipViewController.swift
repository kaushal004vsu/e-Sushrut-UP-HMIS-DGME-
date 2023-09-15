//
//  PharmacyQSlipViewController.swift
//  Railways-HMIS
//
//  Created by HICDAC on 10/01/23.
//

import UIKit
import PDFKit

class PharmacyQSlipViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate {
    
    
    let searchController=UISearchController(searchResultsController: nil)

    
    var arrData = [PharmacyQSlipModel]()
    var allData=[PharmacyQSlipModel]()
    @IBOutlet weak var tableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pharmacy Q Slip"
        showInernetAlert()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 440
        
       
        jsonParsing()
        searchBarSetup()
       
        //self.enquiryTableView.rowHeight = 44.0
    }
    func jsonParsing(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let url = URL(string: ServiceUrl.testurl+"QmsService/getPharmacyQueueCrnoWise?crno="+obj!.crno)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                let jarr=json["data"]

                if (jarr.count != 0){
                for arr in jarr.arrayValue{
                           self.arrData.append(PharmacyQSlipModel(json: arr))
                           self.allData=self.arrData
                       }
                }else {
                    self.alert(title: "No Record Found!", message: "No Pharmacy Q Slip found for the selected patient.")
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.tableView.reloadData()
                    
                }
                
            }catch{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.tableView.reloadData()
                    
                }
                print("error:: "+error.localizedDescription)
            }
            }.resume()
    }
    
    func showInernetAlert() {
        if !AppUtilityFunctions.isInternetAvailable() {
            alert(title: "Warning",message: "The Internet is not available")
        }
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
}
extension PharmacyQSlipViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.arrData=self.allData
        }
        else{
            self.arrData=self.allData
              arrData=arrData.filter{
                  $0.hosp_name.lowercased().contains(searchText.lowercased())
                 || $0.dept_unit_name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

extension PharmacyQSlipViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PharmacyQSlipTableViewCell
        
        
        cell.que_no_title.text = "Queue No."
        cell.que_no_lbl.text = arrData[indexPath.row].que_no
        
        cell.lblDeptName.text = arrData[indexPath.row].dept_unit_name
        cell.statusLbl.text = "Status : "+arrData[indexPath.row].token_status
        cell.lblHospitalName.text = arrData[indexPath.row].hosp_name
        
        cell.que_no_lbl.layer.masksToBounds = true
        cell.que_no_lbl.layer.cornerRadius = 5
        cell.que_no_lbl.layer.borderWidth = 1
        cell.que_no_lbl.layer.borderColor = UIColor.black.cgColor
        
        cell.liveQueueStatusBtn.tag = indexPath.row
        cell.liveQueueStatusBtn.addTarget(self, action: #selector(liveStatus(sender:)), for: .touchUpInside)
//        print("days"+days)
        return cell
    }
    @objc func liveStatus(sender: UIButton){
        let buttonTag = sender.tag
        print("buttonTag \(buttonTag)")
        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController)!
        vc.from = 4
        vc.hospCode = arrData[buttonTag].hosp_code
        self.navigationController!.pushViewController( vc, animated: true)
       
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController)!
        vc.hospCode = arrData[indexPath.row].hosp_code
        vc.from = 4
        self.navigationController!.pushViewController( vc, animated: true)
    }
}
