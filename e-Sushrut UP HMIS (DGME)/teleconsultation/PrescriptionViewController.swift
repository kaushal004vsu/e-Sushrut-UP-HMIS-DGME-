//
//  ViewPrescriptionViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 27/10/22.
//

import UIKit
import WebKit
class PrescriptionViewController: UIViewController, WKUIDelegate  {
    
    //var arrData : [UpcomingModel]
    var requestStatusCompleteMode = ""
    var entryDate = ""
    var hospCode = ""
    var episodecode = ""
    var visitNo = ""
    var CRNo = ""
    var requestID = ""
    var webView: WKWebView!
    override func loadView() {
        super.loadView()
//        webView.topAnchor.constraint(equalTo: "50")
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController!.hidesBarsOnSwipe = true
        if (requestStatusCompleteMode == "1"){
            getPastPrescription()
        }else{
            getPastWebPrescription()
        }
        
    }
    
    
    func getPastWebPrescription(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let urlEncoded =  entryDate.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
    
        let url = ServiceUrl.getPastWebPrescription+"hosp_code="+hospCode+"&Modval=5&CrNo="+obj!.crno+"&episodeCode="+episodecode+"&visitNo="+visitNo+"&seatId=0&Entrydate=%22%22"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else { return }
            do{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                if let decodeData = NSData(base64Encoded: data, options: .ignoreUnknownCharacters) {
                    DispatchQueue.main.async {
                        if(data.isEmpty){
                            self.alert(title: "", message: "Pdf not found!")
                        }
                       
                        self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                    }
                }
                
                
                
            }
//            catch{
//                DispatchQueue.main.async {
//                    self.view.activityStopAnimating()
//                }
//               print("Sudeep"+error.localizedDescription)
//            }
            }.resume()
    }
    func getPastPrescription(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
    
        let url2 = ServiceUrl.getPastPrescription+"&uhid=\(CRNo)&requestId=\(requestID)&deptcontextvisit=1"
        let url = URL(string: url2)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                do{

                    let str = String(data: data, encoding: .utf8)
                    if(str?.count == 0){
                        self.alert(title: "", message: "Pdf not found!")
                    }
                    
                                          
                    
                    
                    if let decodeData = NSData(base64Encoded: str!, options: .ignoreUnknownCharacters) {
                    DispatchQueue.main.async {
                        
                        self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                        
                  
                          self.view.activityStopAnimating()
                      
                    }
                }
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
