//
//  SickCertificateViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 05/08/22.
//

import UIKit

class SickCertificateViewController: UIViewController {
    
    @IBOutlet weak var sickListTableView: UITableView!
    var crno=""
    var hospCode = ""
    var arrData=[SickListModel]()
    @IBOutlet var lblNoReportsFound: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
            let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
            self.crno=obj!.crno
            self.hospCode=obj!.hospCode
            print("crno"+crno)
            jsonParsing()
    }

    func jsonParsing(){
   //URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        

        let url = URL(string: ServiceUrl.sickCertificate+hospCode+"&crno=\(self.crno)")

        print("url "+ServiceUrl.sickCertificate+hospCode+"&crno=\(self.crno)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                var json = try JSON(data:data)
              //  print(url)
               json=json["data"]
                print(json)
                if json.count == 0
                {
                    DispatchQueue.main.async {
                    self.sickListTableView.backgroundView=self.lblNoReportsFound
                    self.sickListTableView.separatorStyle = .none
                    self.sickListTableView.reloadData()
                        self.alert(title: "No Record Found!", message: "No Sick Certificate found for the selected patient.")
                    }
                }
                else{
                for arr in json.arrayValue{
                    self.arrData.append(SickListModel(json: arr))
                    
                }

                DispatchQueue.main.async {
                    self.sickListTableView.backgroundView=nil
                    self.sickListTableView.separatorStyle = .singleLine
                    self.sickListTableView.reloadData()
                    
                }
                    
                }
                
            }catch{
                print("error "+error.localizedDescription)
            }
            }.resume()
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

extension SickCertificateViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SickCertificatetableViewCell
        
        print(arrData[indexPath.row].categoryStr)
        cell.lblTestNAme.text = "Sick Type: "+arrData[indexPath.row].sick_type
        cell.category_lbl.text = "Category: "+arrData[indexPath.row].categoryStr
        cell.lblReqNumber.text = "Sick Period From:   "
        cell.lblReportDate.text = arrData[indexPath.row].sick_start+"  To  "+arrData[indexPath.row].sick_end
        cell.department_lbl.text = arrData[indexPath.row].deparment
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController:PdfViewController = self.storyboard!.instantiateViewController(withIdentifier: "PdfViewController") as! PdfViewController
        let printArr = arrData[indexPath.row]
        viewController.from = 2
        viewController.sickCertificateData=printArr
        self.navigationController!.show(viewController, sender: self)
    }
    
    
}
