//
//  DrugRxViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 01/05/23.
//

import UIKit

class DrugModel{
    var drugHeading:String?
    var drugList:[MedicationsModel]?
    
    init(drugHeading:String,drugList:[MedicationsModel]){
        self.drugHeading = drugHeading
        self.drugList = drugList
    }
}

class DrugRxViewController: UIViewController {
    var drugModel = [DrugModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()  {
        self.tableView.estimatedRowHeight = 20
          self.tableView.rowHeight = UITableView.automaticDimension
//
//          self.tableView.sectionHeaderHeight =  UITableView.automaticDimension
//          self.tableView.estimatedSectionHeaderHeight = 25;
        
        //tableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationItem.title = "Medication Against Rx"
        jsonParsing()
    }
    
    func jsonParsing(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
           let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
           let url = URL(string: "\(ServiceUrl.ip+"eSushrutEMRServices/service/ehr/get/patient/medication/all?crNo=")\(obj!.crno)")!
           print("url \(url)")
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard let data = data else { return }
               do{
                   let json = try JSON(data:data)
                   let medication_detail = json["medication_detail"]
                  let all_data = medication_detail["all_data"]
                   if all_data.count == 0{
                       self.alert(title: "No Record Found!", message: "No Medication found for the selected patient.")
                   }else{
                       for arr in all_data.arrayValue{
                           let encounter_detail = arr["encounter_detail"]
                           
                          let unit = encounter_detail["unit"]
                          let department = encounter_detail["department"]
                          let hospital_name = encounter_detail["hospital_name"]
                          let visit_type = encounter_detail["encounter_type"]
                          let visit_date = encounter_detail["visit_date"]
                           print("hellllllo---\(unit)")

                           var arrData=[MedicationsModel]()

                           for arr2 in arr["medications"].arrayValue{
                               arrData.append(MedicationsModel(json: arr2))
                           }
                           
                           print("\(arrData)");
                           self.drugModel.append(DrugModel.init(drugHeading:"\(department) (\(unit)) \(hospital_name) Visit Type: \(visit_type) Visit Date: \(visit_date)",drugList:arrData))
                }
            }
                //   print("arrDataarrData-\(self.arrData)")
                   DispatchQueue.main.async {
                       self.view.activityStopAnimating()
                       self.tableView.reloadData()
                       
                   }
                   
               }catch{
                   print("error:: "+error.localizedDescription)
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

extension DrugRxViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
       return drugModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  drugModel[section].drugList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:DrugRXTableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DrugRXTableViewCell
        cell!.lbl_drug.text = drugModel[indexPath.section].drugList?[indexPath.row].drug_name
        cell!.lbl_adviced_date.text = drugModel[indexPath.section].drugList?[indexPath.row].advise_date
        cell!.lbl_adviced_qty.text = drugModel[indexPath.section].drugList?[indexPath.row].adviced_qty
        cell!.lbl_issued_qty.text = drugModel[indexPath.section].drugList?[indexPath.row].issue_qty
      
        return cell!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return drugModel[section].drugHeading
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 120))

            let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
//            label.frame = CGRect.init(x: 2, y: 0, width: headerView.frame.width-10, height: headerView.frame.height/2)
        label.frame = CGRect.init(x: 2, y: 0, width: headerView.frame.width, height: 80)
            label.text = "\(drugModel[section].drugHeading!)"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .blue
        
        let subHeadingView = UIView()
//        subHeadingView.frame = CGRect.init(x: 2, y: headerView.frame.height/2, width: headerView.frame.width-10, height: headerView.frame.height/3)
        subHeadingView.frame = CGRect.init(x: 2, y: 80, width: headerView.frame.width-10, height: 40)
        
        label.backgroundColor=UIColor(red: 224/255, green: 244/255, blue: 253/255, alpha: 1.0)
        
        
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        label1.font = .systemFont(ofSize: 14,weight: .semibold )
        label2.font = .systemFont(ofSize: 12,weight: .semibold )
        label3.font = .systemFont(ofSize: 12,weight: .semibold )
        label4.font = .systemFont(ofSize: 12,weight: .semibold )
        
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.numberOfLines = 0
        
        label2.lineBreakMode = NSLineBreakMode.byWordWrapping
        label2.numberOfLines = 0
        
        label3.lineBreakMode = NSLineBreakMode.byWordWrapping
        label3.numberOfLines = 0
        
        label4.lineBreakMode = NSLineBreakMode.byWordWrapping
        label4.numberOfLines = 0
        
        label1.text = "Drug"
        label2.text = "Adviced \nDate"
        label3.text = "Adviced \nQTY"
        label4.text = "Issued \nQTY"
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
        label4.translatesAutoresizingMaskIntoConstraints = false
        subHeadingView.addConstraint(NSLayoutConstraint(item: label1, attribute: .leading, relatedBy: .equal, toItem: subHeadingView, attribute: .leading, multiplier: 1, constant: 2))

        subHeadingView.addConstraint(NSLayoutConstraint(item: label1, attribute: .trailing, relatedBy: .equal, toItem: label2, attribute: .leading, multiplier: 1, constant: 0))
        
   
        subHeadingView.addConstraint(NSLayoutConstraint(item: label1, attribute: .top, relatedBy: .equal, toItem: subHeadingView, attribute: .top, multiplier: 1, constant: 0))

        
        
//        subHeadingView.addConstraint(NSLayoutConstraint(item: label2, attribute: .leading, relatedBy: .equal, toItem: label1, attribute: .leading, multiplier: 1, constant: 2))
//        subHeadingView.addConstraint(NSLayoutConstraint(item: label2, attribute: .top, relatedBy: .equal, toItem: subHeadingView, attribute: .top, multiplier: 1, constant: 0))
//
        subHeadingView.addConstraint(NSLayoutConstraint(item: label2, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 80))
        subHeadingView.addConstraint(NSLayoutConstraint(item: label3, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 60))
        subHeadingView.addConstraint(NSLayoutConstraint(item: label4, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 60))

        
        subHeadingView.addConstraint(NSLayoutConstraint(item: label3, attribute: .leading, relatedBy: .equal, toItem: label2, attribute: .trailing, multiplier: 1, constant: 2))
        subHeadingView.addConstraint(NSLayoutConstraint(item: label3, attribute: .trailing, relatedBy: .equal, toItem: label4, attribute: .leading, multiplier: 1, constant: 2))
        
        subHeadingView.addConstraint(NSLayoutConstraint(item: label4, attribute: .leading, relatedBy: .equal, toItem: label3, attribute: .trailing, multiplier: 1, constant: 2))
        subHeadingView.addConstraint(NSLayoutConstraint(item: label4, attribute: .trailing, relatedBy: .equal, toItem: subHeadingView, attribute: .trailing, multiplier: 1, constant: 2))
        subHeadingView.addSubview(label1)
        subHeadingView.addSubview(label2)
        subHeadingView.addSubview(label3)
        subHeadingView.addSubview(label4)
        
        
        headerView.addSubview(label)
        headerView.addSubview(subHeadingView)
        
        
        
            return headerView
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

