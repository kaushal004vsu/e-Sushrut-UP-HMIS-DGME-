//
//  TransactionViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 11/08/22.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet weak var transactionTableView: UITableView!
    var crno=""
    var hospCode = ""
    var arrData=[TransactionModel]()
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
        let url2 = ServiceUrl.testurl+"AppOpdService/combInvestigation?hosp_code=&crno="+crno

        let url = URL(string: url2)

        print("url "+ServiceUrl.reportListUrl+"\(self.crno)&hosCode=0")
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
                    self.transactionTableView.backgroundView=self.lblNoReportsFound
                    self.transactionTableView.separatorStyle = .none
                    self.transactionTableView.reloadData()
                    self.showToast(message: "No Record found", font: .systemFont(ofSize: 12.0))

                    }

                }
                else{
                for arr in json.arrayValue{
//                   print(arr["REPORTDATE"].stringValue)
                    self.arrData.append(TransactionModel(json: arr))
                    
                }

                DispatchQueue.main.async {
                    self.transactionTableView.backgroundView=nil
                    self.transactionTableView.separatorStyle = .singleLine
                    self.transactionTableView.reloadData()
                    
                }
                    
                }
                
            }catch{
                print("Error "+error.localizedDescription)
            }
            }.resume()
    }
    


}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource{
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionTableViewCell
        
         cell.billNo_lbl.text = "Bill No: "+arrData[indexPath.row].tran_no
        cell.transaction_date_lbl.text = arrData[indexPath.row].trans_date
        cell.amount_lbl.text = "₹ "+arrData[indexPath.row].deducted
        cell.hosp_name_lbl.text = arrData[indexPath.row].hosp_name
       
        return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
         vc.from=3
         vc.transationModelData = arrData[indexPath.row]
         self.navigationController!.pushViewController( vc, animated: true)

    }
   
}
