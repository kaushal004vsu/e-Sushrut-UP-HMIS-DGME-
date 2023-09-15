//
//  AnnouncementViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 08/05/23.
//

import UIKit
import PDFKit

class AnnouncementViewController: UIViewController {

    private var pdfView:PDFDocument!
    
    var arrData = [AnnouncementModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()  {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        self.navigationItem.title = "Announcement"
        tableView.layoutMargins = .init(top: 0.0, left: 23.5, bottom: 0.0, right: 23.5)
            // if you want the separator lines to follow the content width
            tableView.separatorInset = tableView.layoutMargins
        showAlert()
        self.tableView.reloadData()

        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
         jsonParsing()
    }
    func jsonParsing(){
        self.arrData.removeAll()
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let url = URL(string: ServiceUrl.announcement+obj!.hospCode)
        print("url \(String(describing: url))")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{

                let json = try JSON(data:data)
                let jarr=json["data"]
                if jarr.array?.count == 0{
                    self.alert(title: "No Record Found!", message: "No Announcement found.")
                }else{
                    for arr in jarr.arrayValue{
                        print("arr--\(arr)")
                        self.arrData.append(AnnouncementModel(json: arr))
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
extension AnnouncementViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnnouncementTableViewCell
            cell.tv_s_no.text = "\((indexPath.row+1))."
            cell.tv_date.text = " \(arrData[indexPath.row].publish_date)"
            cell.tv_topic.text = "\(arrData[indexPath.row].subject.uppercased())"
        
        if(arrData[indexPath.row].isNew == "1"){
            cell.iv_new.isHidden = false
            UIView.animate(withDuration: 0.5,delay: 0,options: [.repeat, .autoreverse],animations: {  cell.iv_new.alpha = 0 })
        }else{
            cell.iv_new.isHidden = true
        }
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AnnouncementViewController.tapLabelFunction))
        cell.tv_topic.isUserInteractionEnabled = true
           cell.tv_topic.tag = indexPath.row
           cell.tv_topic.addGestureRecognizer(tap)
        
       


        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "OpenPDFViewController") as? OpenPDFViewController)!
        vc.arrData1=arrData[indexPath.row]
        vc.clickIndex = indexPath.row
        self.navigationController!.pushViewController( vc, animated: true)
    }
    
    @objc func tapLabelFunction(sender:UITapGestureRecognizer) {

        print("label tapped",sender.view!.tag); // for tag
        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "OpenPDFViewController") as? OpenPDFViewController)!
                vc.arrData1=arrData[sender.view!.tag]
        vc.clickIndex = sender.view!.tag
        self.navigationController!.pushViewController( vc, animated: true)

    }
    
    func atributeLabel(label:UILabel,value:CGFloat){
        label.shadowColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: value)
        label.font = UIFont.boldSystemFont(ofSize: value)
        }
   
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        print(buttonTag)
        
        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "OpenPDFViewController") as? OpenPDFViewController)!
                vc.arrData1=arrData[buttonTag]
        vc.clickIndex = buttonTag
        self.navigationController!.pushViewController( vc, animated: true)
    }
}

