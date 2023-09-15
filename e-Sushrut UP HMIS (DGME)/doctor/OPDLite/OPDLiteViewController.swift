//
//  OPDLiteViewController.swift
//  SAIL Rourkela
//
//  Created by HICDAC on 24/05/23.
//

import UIKit
import PDFKit
import iOSDropDown

class OPDLiteViewController: UIViewController {

    @IBOutlet weak var selectDepartment: DropDown!
    @IBOutlet weak var transactionTableView: UITableView!
    var crno=""
    var hospCode = ""
    var arrData=[OPDLiteModel]()
    var arrData2=[OPDLiteDepartmentModel]()
    @IBOutlet var lblNoReportsFound: UILabel!
    
    var arDeptCode = [String]();
    var arDeptName = [String]();
    var arUnitName = [String]();
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId:String=UserDefaults.standard.string(forKey: "udUserId")!
        let hospCode=UserDefaults.standard.string(forKey: "udHospCode")!
         let userDisplayName=UserDefaults.standard.string(forKey: "udUserdisplayname")!
         let udSeatId=UserDefaults.standard.string(forKey: "udEmpcode")!
        getDepartment(hospCode: hospCode, seatId: udSeatId)
        selectDepartment.selectedRowColor = .systemBlue
        selectDepartment.listHeight = 300
        selectDepartment.didSelect { [self] selectedText, index, id in
            print("\(selectedText) inside view did load  \(id)")
            
            let deptCode = arDeptCode[index]
            let finalDepartmentId:String = deptCode.slice(from: "#", to: "#")!
            print("deptCode---\(finalDepartmentId)")
            jsonParsing(hospCode: hospCode, seatId: udSeatId, deptcode: finalDepartmentId)
//            self.hospCode=id
//            let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
//            getDepartments(hospCode: String(self.hospCode))
//            self.hospName = selectedText
//            if(selectedText == ""){
//
//            }
        }
        
          //  jsonParsing()
    }
    
    func getDepartment(hospCode:String,seatId:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let urlStr = "\(ServiceUrl.opdLiteDeptList)\(hospCode)&seatId=\(seatId)&deptcode=&roomNo="
        let url = URL(string: urlStr)

        print("DepartmentList---\(urlStr)")
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
                        self.alert(title: "Info", message: "No Record found")
                        self.view.activityStopAnimating()
                    }
                }
                else{
                for arr in json.arrayValue{
                    self.arrData2.append(OPDLiteDepartmentModel(json: arr))
                }
                    for i in 0 ..< self.arrData2.count {
                        self.arDeptCode.append(self.arrData2[i].COLUMN)
                        self.arDeptName.append(self.arrData2[i].UNITNAME)
                        self.arUnitName.append(self.arrData2[i].HGSTR_UNITNAME)
                    }
                    self.selectDepartment.optionArray = self.arDeptName
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                    
                }
                
            }catch{
                print("Error "+error.localizedDescription)
            }
            }.resume()
    }

    func jsonParsing(hospCode:String,seatId:String,deptcode:String){
        self.arrData.removeAll()
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let urlStr = "\(ServiceUrl.opdLiteDeptCodeWise)\(hospCode)&seatId=\(seatId)&deptcode=\(deptcode)&roomNo=0"
        let url = URL(string: urlStr)

       print("url----\(urlStr)")
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
                        self.view.activityStopAnimating()
                    }

                }
                else{
                for arr in json.arrayValue{
//                   print(arr["REPORTDATE"].stringValue)
                    self.arrData.append(OPDLiteModel(json: arr))
                    
                }

                DispatchQueue.main.async {
                    self.transactionTableView.backgroundView=nil
                    self.transactionTableView.separatorStyle = .singleLine
                    self.transactionTableView.reloadData()
                    self.view.activityStopAnimating()
                }
                    
                }
                
            }catch{
                print("Error "+error.localizedDescription)
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

extension OPDLiteViewController: UITableViewDelegate, UITableViewDataSource{
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OPDLiteTableViewCell
        
         cell.billNo_lbl.text = "Bill No: "+arrData[indexPath.row].PATNAME
        cell.transaction_date_lbl.text = "\(arrData[indexPath.row].GENDERAGE)/\(arrData[indexPath.row].PATPRIMARYCAT)/\(arrData[indexPath.row].MOBILENO)"
       // cell.amount_lbl.text = "₹ "+arrData[indexPath.row].GET_UMID_NO_FROM_PATIENT_DTL
        cell.hosp_name_lbl.text = arrData[indexPath.row].GET_UMID_NO_FROM_PATIENT_DTL
       
        return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
//         let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
//         vc.from=3
//         vc.transationModelData = arrData[indexPath.row]
//         self.navigationController!.pushViewController( vc, animated: true)

    }
   

}
