//
//  AppUtilityFunctions.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 05/06/22.
//

import Foundation
import UIKit
import SystemConfiguration
import WebKit
class AppUtilityFunctions{
    
    
    static func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    static func printContent(webView:WKWebView,navigationItem:UINavigationItem) {
        
        let printController = UIPrintInteractionController.shared

        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.jobName = (webView.url?.absoluteString)!
        printInfo.duplex = UIPrintInfo.Duplex.none
        printInfo.orientation = UIPrintInfo.Orientation.portrait

          let renderer: UIPrintPageRenderer = UIPrintPageRenderer()
          webView.viewPrintFormatter().printPageRenderer?.headerHeight = 30.0
          webView.viewPrintFormatter().printPageRenderer?.footerHeight = 30.0
        webView.viewPrintFormatter().contentInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
          webView.viewPrintFormatter().startPage = 0
          
        renderer.addPrintFormatter(webView.viewPrintFormatter(), startingAtPageAt: 0)
          
          printController.printPageRenderer = renderer
          
          
          printController.printInfo = printInfo
          printController.showsPageRange = true
          printController.showsNumberOfCopies = true
        
        printController.present(from: navigationItem.rightBarButtonItem!, animated: true, completionHandler: nil)

    }
    static func showAlertPopup(title:String,message:String,self:ViewController) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
   
  
}
