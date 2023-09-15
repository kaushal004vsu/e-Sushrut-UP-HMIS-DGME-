//
//  ReferralViewController.swift
//  Railways-HMIS
//
//  Created by HICDAC on 20/12/22.
//

import UIKit
import PDFKit

class ReferralViewController: UIViewController, TableViewNew {
    private var pdfView:PDFDocument!
    
    var arrData = [ReferralModel]()
    var allData=[ReferralModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.navigationItem.title = "Referral Letters"
        showAlert()
       
        super.viewDidLoad()
        jsonParsing()
    }
    func jsonParsing(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let strUrl = "\(ServiceUrl.ip)eSushrutEMRServices/service/ehr/get/patient/refCert/all?crNo=\(obj!.crno)"
           let url = URL(string: strUrl)
        print("sttr--\(strUrl)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                print(json)
                if json["list"].array?.count == 0{
                    self.alert(title: "No Record Found!", message: "No Referral Letters found for the selected patient.")
                }
                print("count:: "+json["count"].stringValue)
                if (json["count"].stringValue != "0"){
                let jarr=json["list"]
                print(jarr.stringValue)
                for arr in jarr.arrayValue{
                   if jarr.count==0
                   {
                       self.alert(title: "No Record Found!", message: "No Referral Letters found for the selected patient.")
                   }else{
                       self.arrData.append(ReferralModel(json: arr))
                       self.allData=self.arrData
                   }
                }
                }else
                {
                    self.alert(title: "No Record Found!", message: "No Referral Letters found for the selected patient.")
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
    
    
    
}
extension ReferralViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReferralTableViewCell
      
        
        cell.MyImage.image=UIImage.init(named: "referral_cert")
        cell.hosp_name_lbl.text = arrData[indexPath.row].fromHospital
        cell.from_dept_lbl.text = "From Department/Unit : "+arrData[indexPath.row].from_department_unit
        cell.to_dept_lbl.text = "Refer To Department : "+arrData[indexPath.row].toDepartment
        cell.status_lbl.text = "Status : "+arrData[indexPath.row].status
        cell.refer_date_lbl.text = "Refer Date : "+arrData[indexPath.row].refer_date
       
        if(arrData[indexPath.row].isPublished == "1"){
            cell.dowload_referal_btn.isHidden = false
        }else{
            cell.dowload_referal_btn.isHidden = true
        }
        cell.cellDelegate=self
        cell.index=indexPath


        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    

}

extension ReferralViewController: ReferralClick{
    func onClickCell(index: Int,clickIndex: Int) {
//
//        let viewController:PdfViewController = self.storyboard!.instantiateViewController(withIdentifier: "PdfViewController") as! PdfViewController
//                viewController.arrData1=arrData[index]
//                self.navigationController!.show(viewController, sender: self)
//
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
                vc.arrRefData=arrData[index]
        vc.clickIndex = clickIndex
        vc.from = 4
                self.navigationController!.pushViewController( vc, animated: true)
        print("admi_discharge \(index)")
    }
}
