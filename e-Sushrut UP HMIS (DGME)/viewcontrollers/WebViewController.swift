//
//  WebViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    
   
    @IBOutlet var webload: WKWebView!
    var from: Int!
    var hospCode = ""
    private var observation: NSKeyValueObservation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showInternetAlert()
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        var url:String = ""
        if(from == 1){
             self.title = "LP Status"
             url = ServiceUrl.ip+"HISServices/jsp/lpStatus.jsp?crno=\(obj!.crno)&hospCode="
        }else if(from == 2)
        {
             url = ServiceUrl.ip+"HISServices/jsp/FileUpload.jsp?crno=\(obj!.crno)&hospCode=";
            self.title = "Upload Document"
        }
        else if(from == 3)
        {
            self.title = "Upload Document"
             url = ServiceUrl.ip+"HISServices/jsp/FileUploads.jsp?crno=\(obj!.crno)&hospCode=";
        }
        else if(from == 4)
        {
            self.title = "Live Queue Status"
            url = ServiceUrl.ip+"HISServices/jsp/PharmacyMobileTokenDisplay.jsp?hosp_code=\(self.hospCode)"
        }
        else if(from == 5)
        {
            self.title = "Referral Hospital Info"
            url="https://indianrailways.gov.in/railwayboard/hospital_list.jsp";
        }
        else if(from == 6)
        {
            self.title = "Health Information"
            url=ServiceUrl.generalInfoResource
        }
        else if(from == 7)
        {
            self.title = "Videos"
            url=ServiceUrl.ip+"HISServices/jsp/RailtelVideos.jsp"
           // url=ServiceUrl.RailtelVideos
        }
       
      
             print(url)
   
        let web_url = URL(string:url)!
        let web_request = URLRequest(url: web_url)
        
        webload.uiDelegate = self
        webload.navigationDelegate = self
        webload.configuration.preferences.javaScriptEnabled=true
        webload.load(web_request)
       
      
  }
    override var shouldAutorotate: Bool {
        return true
    }

    func webView(_ webView: WKWebView,
                  runJavaScriptAlertPanelWithMessage message: String,
                  initiatedByFrame frame: WKFrameInfo,
                  completionHandler: @escaping () -> Void) {

         let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
         let title = NSLocalizedString("OK", comment: "OK Button")
         let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
             alert.dismiss(animated: true, completion: nil)
         }
         alert.addAction(ok)
        completionHandler()
         present(alert, animated: true)

     }

     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       //  webload.evaluateJavaScript("alert('Hello from evaluateJavascript()')", completionHandler: nil)
         webload.evaluateJavaScript("", completionHandler: nil)
         DispatchQueue.main.async {
             self.view.activityStopAnimating()
         }
     }
    func showInternetAlert() {
           if !AppUtilityFunctions.isInternetAvailable() {
               self.inernetAlert(title: "Warning",message: "The Internet is not available")
           }
       }

   func inernetAlert(title:String,message:String)
       {
           DispatchQueue.main.async {
              
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
               self.navigationController?.popToRootViewController(animated: true)
           })
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
               
           }
       }
}
 
