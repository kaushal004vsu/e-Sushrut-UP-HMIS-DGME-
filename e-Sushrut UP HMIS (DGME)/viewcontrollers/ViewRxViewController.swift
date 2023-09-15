//
//  ViewRxViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 08/06/22.
//

import UIKit
import WebKit
class ViewRxViewController: UIViewController, WKUIDelegate  {
    
    var arrData=PrescriptionListModel()
    var arrData2=OPDPatientDetails()
    var webView: WKWebView!
    var pdfString = ""
    var from:Int = 0

    var patientDetail=PatientDetails()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))

//        self.navigationController!.hidesBarsOnSwipe = true
        jsonParsing()
        
        
    }
    
    
    @objc func share(sender:UIView){
       // AppUtilityFunctions.printContent(webView: webView, navigationItem: navigationItem)
        do {
               try savePdf()
               loadPDFAndShare()
           } catch  {
               print("failed to save pdf")
           }
       }
    
    func savePdf() throws {
        let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let pdfDocURL = documentsURL.appendingPathComponent("document.pdf")
        let pdfData = Data(base64Encoded: pdfString)
        try pdfData!.write(to: pdfDocURL)
    }

    func loadPDFAndShare(){
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let pdfDocURL = documentsURL.appendingPathComponent("document.pdf")

            let document = NSData(contentsOf: pdfDocURL)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [document!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            present(activityViewController, animated: true, completion: nil)
            print("document was not found")
        } catch  {
            print("document was not found")
        }
      }
    
    func jsonParsing(){
        DispatchQueue.main.async {
            
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let urlEncoded =  arrData.entryDate.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        var url:String = ""
        if(from == 2){
            var udCrno:String =  UserDefaults.standard.string(forKey:"udCrno")!
             url = ServiceUrl.getPastWebPrescription+"hosp_code="+arrData.hospCode+"&Modval=5&CrNo="+udCrno+"&episodeCode="+arrData.episodeCode+"&visitNo="+arrData.visitNo+"&seatId=0&Entrydate=\(urlEncoded!)";

        }else if(from == 100){
            url = ServiceUrl.getPastWebPrescription+"hosp_code="+arrData2.gnumHospitalCode+"&Modval=5&CrNo="+arrData2.patcrno+"&episodeCode="+arrData2.episodecode+"&visitNo="+arrData2.visitNo+"&seatId=0&Entrydate=\(urlEncoded!)";

        }else{
             url = ServiceUrl.getPastWebPrescription+"hosp_code="+arrData.hospCode+"&Modval=5&CrNo="+obj!.crno+"&episodeCode="+arrData.episodeCode+"&visitNo="+arrData.visitNo+"&seatId=0&Entrydate=\(urlEncoded!)";

        }
        
        print("kaushal-\(url)")
        
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
                    self.pdfString = decodeData.base64EncodedString()
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




