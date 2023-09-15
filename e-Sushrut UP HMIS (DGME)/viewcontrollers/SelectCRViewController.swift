//
//  SelectCRViewController.swift
//  AIIMS Gorakhpur Swasthya
//
//  Created by sudeep rai on 18/11/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class SelectCRViewController: UIViewController,URLSessionDelegate {
    
    @IBOutlet weak var selectCrTableview: UITableView!
    
    
 //   @IBOutlet weak var btnRegisterPatient: UIView!
    
    
    var arRegisteredPatients=[PatientDetails]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.btnRegisterTap))
       // self.btnRegisterPatient.addGestureRecognizer(gesture)
        if arRegisteredPatients.count==0 {
            
            let mobileNo =  UserDefaults.standard.string(forKey:"udMobileNo");
          //  let mobileNo =  obj!.mobileNo
              getRegisteredPatients(mobileNo: mobileNo!)
        }
        DispatchQueue.main.async {
            print(self.arRegisteredPatients)
            self.selectCrTableview.reloadData();
            
            
            
        //    let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
//            if obj==nil{
//                self.btnRegisterPatient.isHidden=true
//            }
//            else
//            {
//                self.btnRegisterPatient.isHidden=false
//            }
        }
    }
    
    
    
  /*  @objc func btnRegisterTap(sender : UITapGestureRecognizer) {
        DispatchQueue.main.async {
            if self.navigationController != nil
            {
            let vc = (self.storyboard!.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController)!
        self.navigationController!.pushViewController( vc, animated: true)
            }else{
            
        var rootVC : UIViewController?
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
              appDelegate.window?.rootViewController = rootVC
            }
        }
    } */
    

    
    
    
    func getRegisteredPatients(mobileNo:String){
        arRegisteredPatients.removeAll();
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
                    let url = URL(string: ServiceUrl.getPatDtlsFromcrno+mobileNo )

            
            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                   

        urlSession.dataTask(with: url!) { (data, response, error) in
                guard let data = data else {
                    return }
                do{
                    let json = try JSON(data:data)
       
                    let jsonArray=json["data"].array;
                    if jsonArray==nil
                    {
                        print("nil json array");
                        let alert = UIAlertController(title: "Info", message: "TNo registered patient found!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                            //                print("Handle Ok logic here")
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                       
                    }else
                    {
                        let jsonn =   JSON(jsonArray!)
                    
                        if jsonArray!.count < 1 {
                           
                        }else{
                     for arr in jsonn.arrayValue{
                        
                        self.arRegisteredPatients.append(PatientDetails(json: arr))
                    }
                            
                            DispatchQueue.main.async {
                                print(self.arRegisteredPatients)
                                self.selectCrTableview.reloadData();
                            }
                        }
                        
                    }
                
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                }catch{
                    print("error")
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        
                    }
                }
                }.resume()
        }
    
    
}
    
extension SelectCRViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arRegisteredPatients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectCRTableViewCell
        
        
        cell.lblPatientName.text = arRegisteredPatients[indexPath.row].firstName
        
        cell.lblPatientCrno.text = "CR NO. : "+arRegisteredPatients[indexPath.row].crno
        
              return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  print("didSelectRowAt")
        
        //To save the object
        UserDefaults.standard.save(customObject: arRegisteredPatients[indexPath.row], inKey: "patientDetails")
        
        UserDefaults.standard.set("patient", forKey: "udWhichModuleToLogin")
        
        
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientNavigationController") as! UINavigationController

    }
      }
}
