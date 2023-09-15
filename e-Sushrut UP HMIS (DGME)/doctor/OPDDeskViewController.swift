//
//  OPDDeskViewController.swift
//  AIIMS Bhubaneswar Swasthya
//
//  Created by sudeep rai on 21/08/20.
//  Copyright © 2020 sudeep rai. All rights reserved.
//

import UIKit
import WebKit
class OPDDeskViewController: UIViewController, WKUIDelegate,WKNavigationDelegate {
    
    

    @IBOutlet weak var webview: WKWebView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.webview.uiDelegate = self
        
        
        let userId:String=UserDefaults.standard.string(forKey: "udUserId")!
        let hospCode=UserDefaults.standard.string(forKey: "udHospCode")!
         let userDisplayName=UserDefaults.standard.string(forKey: "udUserdisplayname")!
        
        
            let escapedString = userDisplayName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let opdLiteUrl=ServiceUrl.opdLiteUrl+"\(userId)&hospCode=\(hospCode)&user_name=\(escapedString)&modeFlag=M"

        let url = URL (string: opdLiteUrl)
        print(url!)
        
        
        
//       webview.navigationDelegate = self
        let requestObj = URLRequest(url: url!)
        webview.load(requestObj)

    }
 
//    func webView(_ webView: WKWebView,
//        didReceive challenge: URLAuthenticationChallenge,
//        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
//    {
//        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
//        {
//            let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, cred)
//        }
//        else
//        {
//            completionHandler(.performDefaultHandling, nil)
//        }
//    }
    
    func printCurrentPage() {
        let printController = UIPrintInteractionController.shared
        let printFormatter = self.webview.viewPrintFormatter()
        printController.printFormatter = printFormatter

        let completionHandler: UIPrintInteractionController.CompletionHandler = { (printController, completed, error) in
            if !completed {
                if let e = error {
                    print("[PRINT] Failed: )\(e)")
                } else {
                    print("[PRINT] Canceled ")
                }
            }
        }

        //if let controller = printController {
            if UIDevice.current.userInterfaceIdiom == .pad {
               // controller.presentFromBarButtonItem(someBarButtonItem, animated: true, completionHandler: completionHandler)
                printController.present(animated: true, completionHandler: completionHandler)
            } else {
                print("else")
                printController.present(animated: true, completionHandler: completionHandler)
            }
        //}
    }
}


extension WKWebView {

    // Call this function when WKWebView finish loading
    func exportAsPdfFromWebView() -> String {
        let pdfData = createPdfFile(printFormatter: self.viewPrintFormatter())
        return self.saveWebViewPdf(data: pdfData)
    }

    func createPdfFile(printFormatter: UIViewPrintFormatter) -> NSMutableData {
        let originalBounds = self.bounds
        self.bounds = CGRect(x: originalBounds.origin.x,
                             y: bounds.origin.y,
                             width: self.bounds.size.width,
                             height: self.scrollView.contentSize.height)
        let pdfPageFrame = CGRect(x: 0, y: 0, width: self.bounds.size.width,
                                  height: self.scrollView.contentSize.height)
        let printPageRenderer = UIPrintPageRenderer()
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        printPageRenderer.setValue(NSValue(cgRect: UIScreen.main.bounds), forKey: "paperRect")
        printPageRenderer.setValue(NSValue(cgRect: pdfPageFrame), forKey: "printableRect")
        self.bounds = originalBounds
        print(" s \(printPageRenderer.generatePdfData())")
        return printPageRenderer.generatePdfData()
    }

    // Save pdf file in document directory
    func saveWebViewPdf(data: NSMutableData) -> String {

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("webViewPdf.pdf")
        if data.write(to: pdfPath, atomically: true) {
            print("pdf path \(pdfPath)")
            
           
            
            return pdfPath.path
        } else {
             print("empty path")
            return ""
        }
    }
}
extension UIPrintPageRenderer {

    func generatePdfData() -> NSMutableData {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil)
        self.prepare(forDrawingPages: NSMakeRange(0, self.numberOfPages))
        let printRect = UIGraphicsGetPDFContextBounds()
        for pdfPage in 0..<self.numberOfPages {
            UIGraphicsBeginPDFPage()
            self.drawPage(at: pdfPage, in: printRect)
        }
        UIGraphicsEndPDFContext();
        return pdfData
    }
}
