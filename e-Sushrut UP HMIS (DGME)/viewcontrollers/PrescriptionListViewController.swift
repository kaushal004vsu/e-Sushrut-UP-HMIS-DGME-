//
//  PrescriptionListViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 08/06/22.
//

import UIKit

class PrescriptionListViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate, UISearchResultsUpdating {
    
    
    
    
    
    @IBOutlet weak var PrescriptiontListTableView: UITableView!
    var crno=""
    var arrData=[PrescriptionListModel]()
    var allData=[PrescriptionListModel]()
  

    
    @IBOutlet var lblNoRecordsFound: UILabel!
    let searchController=UISearchController(searchResultsController: nil)
    var from:Int = 0
    override func viewDidLoad() {

        super.viewDidLoad()
        UserDefaults.standard.string(forKey:"udCrno")
        
        if UserDefaults.standard.object(forKey: "udCrno") != nil  {
            self.crno=(UserDefaults.standard.object(forKey: "udCrno") as! String)
        }else{
            let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
            self.crno=obj!.crno
        }
        searchBarSetup()
        DispatchQueue.main.async {
            
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        PrescriptiontListTableView.rowHeight = UITableView.automaticDimension
        PrescriptiontListTableView.estimatedRowHeight = 44
        jsonParsing(crno: self.crno)
        
    }
    
   
    func jsonParsing(crno:String){
   //URLSession(configuration: .default, delegate: self, delegateQueue: nil)
//        let url = URL(string: ServiceUrl.rxListurl+"\(self.crno)")
//        print("jsonParsing called")
        let url = URL(string: ServiceUrl.testurl+"railtelService/prescriptionList?crno=\(crno)&hosCode=0")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                
                
                var json = try JSON(data:data)
              //  print(url)
               json=json["pat_details"]
              //  print(json)
                if json.count == 0
                {
                    DispatchQueue.main.async {
                       
                    self.PrescriptiontListTableView.backgroundView=self.lblNoRecordsFound
                    self.PrescriptiontListTableView.separatorStyle = .none
                    self.PrescriptiontListTableView.reloadData()
                        
                    }

                }
                else{
                for arr in json.arrayValue{
                   //print(arr["GSTR_DEPT_NAME"].stringValue)
                    self.allData.append(PrescriptionListModel(json: arr))
                    self.arrData=self.allData
                    
                }

                DispatchQueue.main.async {
                    self.PrescriptiontListTableView.backgroundView=nil
                    self.PrescriptiontListTableView.separatorStyle = .singleLine
                    self.PrescriptiontListTableView.reloadData()
                    
                }
                    
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
            }catch{
                print("Sudeep"+error.localizedDescription)
            }
            }.resume()
    }
    
    
    private func searchBarSetup(){
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        
        //self.searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController=searchController
        } else {
            
            searchController.hidesNavigationBarDuringPresentation = true
            PrescriptiontListTableView.tableHeaderView = searchController.searchBar
        }
        
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.arrData=self.allData
        }
        else{
            arrData=allData
            arrData=arrData.filter{
                $0.deptName.lowercased().contains(searchText.lowercased())
            }
        }
        PrescriptiontListTableView.reloadData()
    }
}

extension PrescriptionListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PrescriptionListTableViewCell
        cell.lblDeptName.text = arrData[indexPath.row].deptName
        
        cell.lblVisitDate.text = "Visit Date: "+arrData[indexPath.row].visitDate
        
        
        cell.lblVisitNo.text = "Visit no: "+arrData[indexPath.row].visitNo
        cell.lblHospName.text = arrData[indexPath.row].hospName
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController:ViewRxViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewRxViewController") as! ViewRxViewController
        viewController.arrData=arrData[indexPath.row]
        viewController.from = self.from
        self.navigationController!.show(viewController, sender: self)
    }
    
    
}
