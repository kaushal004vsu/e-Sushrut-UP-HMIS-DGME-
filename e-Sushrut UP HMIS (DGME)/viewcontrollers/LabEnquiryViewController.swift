

import UIKit
import Foundation
class LabEnquiryViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate {
   
    
    let searchController=UISearchController(searchResultsController: nil)

    
    var arrData = [LabEnquiryModel]()
    var allData=[LabEnquiryModel]()
    @IBOutlet weak var LabEnquiryTableView: UITableView!
    
    @IBOutlet weak var deptList_btn: UIButton!
    
    var hospCode:String!
    var arHospList=[HospListModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        deptList_btn.layer.cornerRadius = 8.0
        deptList_btn.layer.borderWidth = 1.5
        deptList_btn.layer.borderColor = UIColor.systemBlue.cgColor
        self.navigationItem.title = "Lab Enquiry"
        showAlert()
        
        LabEnquiryTableView.rowHeight = UITableView.automaticDimension
        LabEnquiryTableView.estimatedRowHeight = 44
        
        getHospital()
        searchBarSetup()
       
    }
    @IBAction func deptAction_arrow(_ sender: Any) {
               
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HospListVC3")as? HospListVC3 {
                        vc.callBack = { (id: String,unit_name: String,hgstr_unit_name: String) in
                            self.hospCode = id
                            self.deptList_btn.setTitle(unit_name, for: .normal)
                            if(self.deptList_btn.title(for: .normal) != "Select Hospital"){
                                self.jsonParsing(hospCode: id)
                            }
                        }
                        vc.arrHospList = self.arHospList
                        vc.modalPresentationStyle = .automatic
                        self.present(vc, animated: true, completion: nil)
                     }
        
                }
    func getHospital(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let url2 = ServiceUrl.teleconsultancyHospitalList

        let url = URL(string: url2)

       // print("url "+url2)
        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                if json.count == 0{
                    self.alert(title: "Info",message: "Hospital not found!")
                }
                else{
                for arr in json.arrayValue{
                    self.arHospList.append(HospListModel(json: arr))
                }
                    

                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.deptList_btn.setTitle(self.arHospList[0].hospName, for: .normal)
                    self.jsonParsing(hospCode: self.arHospList[0].hospCode)
                }
                
            }catch{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("error"+error.localizedDescription)
            }
            }.resume()
    }
    func jsonParsing(hospCode:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        self.arrData.removeAll()
        let url = URL(string: "\(ServiceUrl.labEnquiryUrl)\(hospCode)&labCode=0")
   print(url!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                print(data)
//                                print(data)
                //                let results = json["results"]
                if json.array?.count == 0{
                    self.alert(title: "No Record Found!", message: "No Record Found for the selected Hospital.")
                }
                
                for arr in json.arrayValue{
                   if arr.count==1
                   {
                    continue
                    }
                        self.arrData.append(LabEnquiryModel(json: arr))
                    
                }
                self.allData=self.arrData
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                DispatchQueue.main.async {
                    self.LabEnquiryTableView.reloadData()
                    
                }
                
            }catch{
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    
    func alert(title:String,message:String)
    {
        DispatchQueue.main.async {
           
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
            //                print("Handle Ok logic here")
          //  self.navigationController?.popToRootViewController(animated: true)
          
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
            
        }
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
    
    

    
    private func searchBarSetup(){
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        
        //self.searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 11.0, *) {
              navigationItem.searchController=searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            searchController.hidesNavigationBarDuringPresentation = true
            LabEnquiryTableView.tableHeaderView = searchController.searchBar
        }
        
    }
    
    
    
    
    
}
extension LabEnquiryViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.arrData=self.allData
        }
        else{
            self.arrData=self.allData
            arrData=arrData.filter{
                $0.testName.lowercased().contains(searchText.lowercased()) ||
                $0.labName.lowercased().contains(searchText.lowercased())
                
            }
        }
        LabEnquiryTableView.reloadData()
    }
}

extension LabEnquiryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LabEnquiryTableViewCell
        
        
        cell.lblTestName.text = arrData[indexPath.row].testName
        
        cell.lblLabName.text = "Lab Name :  "+arrData[indexPath.row].labName
        
        if arrData[indexPath.row].testPrice=="0"
        {
            cell.lblTestPrice.text = "₹ NA"
        }
        else
        {
            cell.lblTestPrice.text = "₹  "+arrData[indexPath.row].testPrice
        }
        
//        cell.lblIsApptBased.text = "Rs.  "+arrData[indexPath.row].isApptMandatory

        let isApptMandatory = arrData[indexPath.row].isApptMandatory
        if isApptMandatory=="1"
        {
            cell.isApptMandatory.text="*Appointment Mandatory."
        }
        else{
            cell.isApptMandatory.text=""

        }
//        print("days"+days)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
