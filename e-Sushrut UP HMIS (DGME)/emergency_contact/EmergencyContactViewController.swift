//
//  EmergencyContactViewController.swift
//  Railways-HMIS
//
//  Created by HICDAC on 21/12/22.
//

import UIKit

class EmergencyContactViewController: UIViewController, TableViewNew,UISearchControllerDelegate, UISearchBarDelegate  {
    let searchController=UISearchController(searchResultsController: nil)
    
    var filterData=[EmeregencyContactModel]()
    var arrData = [EmeregencyContactModel]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.navigationItem.title = "Emergency Contacts"
        showInernetAlert()
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        super.viewDidLoad()
        jsonParsing()
        searchBarSetup()
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
    
    func jsonParsing(){
      //  let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
       // let strUrl = "\(ServiceUrl.ip)eSushrutEMRServices/service/ehr/get/patient/refCert/all?crNo=\(obj!.crno)"
        let strUrl = ServiceUrl.divisionAndZoneWiseHospitalList+"?zoneId=0&divisionId=0"
        print("Emergency Contact-\(strUrl)")
        let url = URL(string: strUrl)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                print(json)
        
            var status = json["status"].stringValue
                if (status == "1"){
                    
                let jarr=json["hospital_details"]
                for arr in jarr.arrayValue{
                   if jarr.count==0
                   {
                       self.alert(title: "No Record Found!", message: "No Emergency Contacts found for the selected patient.")
                   }else{
                       print("arr--- "+arr["PHONE"].stringValue)
                       let trimmedPhone = arr["PHONE"].stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
                       if(trimmedPhone.count != 0){
                           self.arrData.append(EmeregencyContactModel(json: arr))
                           self.filterData = self.arrData
                       }
                   }
                }
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
    
    
    
}
extension EmergencyContactViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmeregencyContactTableViewCell
      
       // cell.MyImage.image=UIImage.init(named: "referral_cert")
      //  cell.phone_iv.image =  UIImage(named: "call")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        
        let trimmedPhone = arrData[indexPath.row].phone.trimmingCharacters(in: .whitespacesAndNewlines)
        if(trimmedPhone.count != 0){
            cell.hospital_name.text = "  "+arrData[indexPath.row].name
            cell.phone_no.setTitle(arrData[indexPath.row].phone, for: .normal)
            cell.email.setTitle(arrData[indexPath.row].email, for: .normal)
            
            cell.stackView1.isHidden = false
            cell.hospital_name.isHidden = false
            cell.email_iv.isHidden = false
            cell.email.isHidden = false
            let trimmedEmail = arrData[indexPath.row].email.trimmingCharacters(in: .whitespacesAndNewlines)
            if(trimmedEmail.count != 0){
                cell.email_iv.isHidden = false
                cell.email.isHidden = false
                cell.email.setTitle(arrData[indexPath.row].email, for: .normal)
                
            }else{
                cell.email_iv.isHidden = true
                cell.email.isHidden = true
            }
        }else{
            cell.stackView1.isHidden = true
            cell.hospital_name.isHidden = true
            cell.email_iv.isHidden = true
            cell.email.isHidden = true
            
        }
        
       
     
        
        cell.cellDelegate=self
        cell.index=indexPath

        cell.phone_no.tag = indexPath.row
        cell.phone_no.addTarget(self, action: #selector(mobileConnected(sender:)), for: .touchUpInside)
        
        cell.email.tag = indexPath.row
        cell.email.addTarget(self, action: #selector(emailConnected(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected cell \(indexPath.row)")
    }
    @objc func mobileConnected(sender: UIButton){
        let buttonTag = sender.tag
        print("buttonTag \(buttonTag)")
        guard let url = URL(string: "telprompt://\(arrData[buttonTag].phone)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @objc func emailConnected(sender: UIButton){
        let buttonTag = sender.tag
        print("buttonTag \(buttonTag)")
     
        
        let email = arrData[buttonTag].email
        if let url = URL(string: "mailto:\(email)") {
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    

}

extension EmergencyContactViewController: EmeregencyContactClick{
    func onClickCell(index: Int,clickIndex: Int) {


//        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
//        vc.clickIndex = clickIndex
//        vc.from = 4
//                self.navigationController!.pushViewController( vc, animated: true)
//        print("admi_discharge \(index)")
        
        if(clickIndex == 0){
                guard let url = URL(string: "telprompt://\(arrData[index].phone)"),
                    UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }else{
            
        }
    }
}
extension EmergencyContactViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.arrData=self.filterData
        }
        else{
            self.arrData=self.filterData
              arrData=arrData.filter{
                  $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
