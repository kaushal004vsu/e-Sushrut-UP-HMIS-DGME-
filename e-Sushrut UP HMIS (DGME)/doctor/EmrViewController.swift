//
//  WebViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import WebKit

class EmrViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    
   
    @IBOutlet var webload: WKWebView!
    var from: Int!
    
    private var observation: NSKeyValueObservation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showInternetAlert()
        let newBackButton = UIBarButtonItem(title: "Home", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
                    self.navigationItem.leftBarButtonItem = newBackButton
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        var url:String = ""
         if(from == 8) {
            self.title = "EMR"
            url = "\(ServiceUrl.emrDesk)\(UserDefaults.standard.string(forKey:"udCrno")!)"
        }
        print(url)
        let web_url = URL(string:url)!
        let web_request = URLRequest(url: web_url)
        
        webload.uiDelegate = self
        webload.navigationDelegate = self
        webload.configuration.preferences.javaScriptEnabled=true
        webload.load(web_request)
       
      
  }
        @objc func back(sender: UIBarButtonItem) {
        navigationController!.navigationBar.barTintColor = .black
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
         _ = navigationController?.popViewController(animated: true)
           // AppUtilityFunctions.lockOrientation(.landscape, andRotateTo: .landscapeLeft)

      }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       // AppUtilityFunctions.lockOrientation(.landscape)
       // Or to rotate and lock
      //  AppUtilityFunctions.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       //AppUtilityFunctions.lockOrientation(.portrait)
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
 



