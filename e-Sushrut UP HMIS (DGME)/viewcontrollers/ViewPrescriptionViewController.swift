//
//  ViewPrescriptionViewController.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 08/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit
import WebKit
class ViewPrescriptionViewController: UIViewController , WKUIDelegate{
   var arrData=PatientRequestDetails()
      var webView: WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if arrData.requestStatusCompleteMode=="1" {
            jsonParsing()
            
        }else{
let urlString=ServiceUrl.printWebPrescription+arrData.CRNo+"&episodecode="+arrData.episodeCode+"&deptunitcode&="+arrData.deptUnitCode+"&hospcode="+arrData.hospCode+"&entryDate=%22"+arrData.requestStatusCompleteDate+"%22&VisiNo="+arrData.episodeVisitNo
            print(urlString)
            getWebPrescription(urlData: urlString )
            
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .plain, target: self, action: #selector(self.action(sender:)))
//            
           
        }
  
    }
    @objc func action(sender: UIBarButtonItem) {
    
        presentPrintControllerForWebView(self.webView)
           
       }
    func getWebPrescription(urlData:String)
{
    print(urlData)
//    let link = URL (string: urlData)!
    
    if let encodedURL = urlData.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
       let url = URL(string: encodedURL) {
          webView.load(URLRequest(url: url))
    }
    }
    func presentPrintControllerForWebView(_ webView: WKWebView)
    {
            guard let urlCheck = webView.url
                else {return}

            let pi = UIPrintInfo.printInfo()
            pi.outputType = .general
            pi.jobName = urlCheck.absoluteString
            pi.orientation = .portrait
            pi.duplex = .longEdge

            let printController = UIPrintInteractionController.shared
            printController.printInfo = pi
//            printController.showsPageRange = true
            printController.printFormatter = webView.viewPrintFormatter()
            printController.present(animated: true, completionHandler: nil)
    }
    
    
    
    
    override func loadView() {
            super.loadView()
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
    
    
    }
    func jsonParsing(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let url = URL(string: ServiceUrl.getPastPrescription+"&uhid=\(arrData.CRNo)&requestId=\(arrData.requestID)&deptcontextvisit=1")
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                do{

                    let str = String(data: data, encoding: .utf8)
                    
//                    print(str)
                                          
                    
                    
                    if let decodeData = NSData(base64Encoded: str!, options: .ignoreUnknownCharacters) {
                    DispatchQueue.main.async {
                        
                        self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                        
                  
                          self.view.activityStopAnimating()
                      
                    }
                }
                }
                }.resume()
        }
    
    
}
