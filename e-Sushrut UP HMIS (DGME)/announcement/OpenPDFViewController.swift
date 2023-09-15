//
//  OpenPDFViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 09/05/23.
//

import UIKit
import WebKit
class OpenPDFViewController: UIViewController,WKUIDelegate, UIDocumentInteractionControllerDelegate {
    
      var webView: WKWebView!
    var arrData1=AnnouncementModel()
    var clickIndex:Int!
      override func loadView() {
          let webConfiguration = WKWebViewConfiguration()
          webView = WKWebView(frame: .zero, configuration: webConfiguration)
          webView.uiDelegate = self
          view = webView
      }

      override func viewDidLoad() {
          super.viewDidLoad()
          announcementPdf()
//          let myURL = URL(string:url)
//          let myRequest = URLRequest(url: myURL!)
//          webView.load(myRequest)
          
//          let url2 = URL(string: url)
//          FileDownloader.loadFileAsync(url: url2!) { (path, error) in
//              print("PDF File downloaded to : \(path!)")
//              self.showFileWithPath(path: path!)
//
//          }
      }
//    func showFileWithPath(path: String){
//           let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
//           if isFileFound == true{
//               let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
//               viewer.delegate = self
//               viewer.presentPreview(animated: true)
//           }
//
//       }
    
    func announcementPdf(){
        DispatchQueue.main.async {
            
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
      
        let url = ServiceUrl.downloadDocument + arrData1.document_file;
        let urlEncoded =  url.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else { return }
            do{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                if let decodeData = NSData(base64Encoded: data, options: .ignoreUnknownCharacters) {
                    DispatchQueue.main.async {
                        self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                    }
                   // self.pdfString = decodeData.base64EncodedString()
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
    
}
