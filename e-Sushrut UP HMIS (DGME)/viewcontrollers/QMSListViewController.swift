//
//  QMSListViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 12/06/22.
//

import UIKit

class QMSListViewController:  UIViewController,UISearchBarDelegate,UISearchControllerDelegate {
    
    
    let searchController=UISearchController(searchResultsController: nil)

    
    var arrData = [QMSListModel]()
    var allData=[QMSListModel]()
    @IBOutlet weak var tableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Queue No. Slip"
        showAlert()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
       
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        jsonParsing()
        searchBarSetup()
       
        //self.enquiryTableView.rowHeight = 44.0
    }
    
    
    
    @IBAction func liveQueNoStatusBtn(_ sender: Any) {
        let vc = (UIStoryboard.init(name: "LiveQueNoStatus", bundle: Bundle.main).instantiateViewController(withIdentifier: "LiveQueueStatusViewController") as? LiveQueueStatusViewController)!
        self.navigationController!.pushViewController( vc, animated: true)
    }
    
    func jsonParsing(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        print("Server_url\(ServiceUrl.qmsListUrl+obj!.crno)")
        let url = URL(string: ServiceUrl.qmsListUrl+obj!.crno)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                
                
                print("count:: "+json["count"].stringValue)
                if (json["count"].stringValue != "0")
                {
                let jarr=json["episode_list"]
                print(jarr.stringValue)
                for arr in jarr.arrayValue{
                   if jarr.count==0
                   {
                       self.alert(title: "No Record Found!", message: "No Queue No. Slip found for the selected patient.")
                   }else{
                       self.arrData.append(QMSListModel(json: arr))
                       self.allData=self.arrData
                   }
                        
                    
                }
                }else
                {
                    self.alert(title: "No Record Found!", message: "No Queue No. Slip found for the selected patient.")
                }
               
                
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.tableView.reloadData()
                    
                }
                
            }catch{
                print("error:: "+error.localizedDescription)
            }
            }.resume()
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
extension QMSListViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.arrData=self.allData
        }
        else{
            self.arrData=self.allData
              arrData=arrData.filter{
                $0.deptname.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

extension QMSListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QMSListTableViewCell
        
        
        cell.lblDeptName.text = arrData[indexPath.row].deptunitname
        
        cell.lblVisitDate.text = "Visit Date : "+arrData[indexPath.row].episodestartdate
        cell.lblVisitNo.text = "Visit No : "+arrData[indexPath.row].visitno
        cell.lblHospitalName.text = arrData[indexPath.row].hospname
        cell.lblCrno.text="CRN. : "+arrData[indexPath.row].patcrno
        
       

        
//        print("days"+days)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController:QMSBarCodeViewController = self.storyboard!.instantiateViewController(withIdentifier: "QMSBarCodeViewController") as! QMSBarCodeViewController
        
        
        viewController.arrData=arrData[indexPath.row]
        self.navigationController!.show(viewController, sender: self)
    }
}
