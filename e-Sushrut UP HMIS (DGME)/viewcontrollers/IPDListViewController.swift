//
//  IPDListViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 07/07/22.
//

import UIKit
import PDFKit

class IPDListViewController: UIViewController {
    private var pdfView:PDFDocument!
    
    var arrData = [IPDListModel]()
    var allData=[IPDListModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()  {
        self.navigationItem.title = "IPD Details"
        showAlert()
        
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 44
        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        super.viewDidLoad()
         jsonParsing()
    }
    func jsonParsing(){
      //  let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        
        let url = URL(string: ServiceUrl.admissionSlip+obj!.crno)
   print("url \(url)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                print(json)
                if json["data"].array?.count == 0{
                    self.alert(title: "No Record Found!", message: "No IPD Details found for the selected patient.")
                }
                print("count:: "+json["count"].stringValue)
                if (json["count"].stringValue != "0"){
                let jarr=json["data"]
                print(jarr.stringValue)
                for arr in jarr.arrayValue{
                   if jarr.count==0
                   {
                       self.alert(title: "No Record Found!", message: "No IPD Details found for the selected patient.")
                   }else{
                       self.arrData.append(IPDListModel(json: arr))
                       self.allData=self.arrData
                   }
                }
                }else
                {
                    self.alert(title: "No Record Found!", message: "No IPD Details found for the selected patient.")
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
extension IPDListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IPDListTableViewCell
        
        cell.MyImage.image=UIImage.init(named: "ic_admission_slip")
        cell.tv_dept_name.text = arrData[indexPath.row].deptname
        cell.tv_unit_name.text = arrData[indexPath.row].unitName
        cell.tv_room_name.text = arrData[indexPath.row].roomname
        cell.tv_admission_no.text = arrData[indexPath.row].adm_no
        cell.tv_hospital_name.text = arrData[indexPath.row].hospname
        print("profileId \(arrData[indexPath.row].profileId)")
        if(arrData[indexPath.row].profileId == "0"){
            cell.tv_download_discharge_slip.isHidden = true
        }else{
            cell.tv_download_discharge_slip.isHidden = false
        }
        cell.cellDelegate=self
        cell.index=indexPath


        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    

}

extension IPDListViewController: TableViewNew{
    func onClickCell(index: Int,clickIndex: Int) {
//        
//        let viewController:PdfViewController = self.storyboard!.instantiateViewController(withIdentifier: "PdfViewController") as! PdfViewController
//                viewController.arrData1=arrData[index]
//                self.navigationController!.show(viewController, sender: self)
//        
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
                vc.arrData1=arrData[index]
        vc.clickIndex = clickIndex
                self.navigationController!.pushViewController( vc, animated: true)
        print("admi_discharge \(index)")
    }
    
    
}
