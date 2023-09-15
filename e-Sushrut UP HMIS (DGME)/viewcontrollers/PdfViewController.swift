//
//  PdfViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//  Created by HICDAC on 13/07/22.
import UIKit
import WebKit
class PdfViewController: UIViewController ,WKUIDelegate, UIDocumentInteractionControllerDelegate{
    var arrRefData=ReferralModel()
    var arrData1=IPDListModel()
    var webView: WKWebView!
    var from: Int!
    var clickIndex:Int!
    var base64Send:String = ""
    var docsTitle:String = ""
    var docsType = ""
    var pdfString = ""

    
    //sick data
    var sickCertificateData = SickListModel()
    var transationModelData = TransactionModel()
    
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

        if(from == 1){
            if let decodeData = NSData(base64Encoded: base64Send, options: .ignoreUnknownCharacters) {
                DispatchQueue.main.async {
                    self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                }
            }
        }else if(from == 2){
           sickCertiPDF()
        }else if(from == 3){
            transationPdf()
         }else if(from == 4){
            transationPdf()
             self.title = "Referral Letter"
         }else if(from == 5){
             self.title = "Family member QR"
            transationPdf()
         }else{
             if(clickIndex == 0){
                 getAdmissionSlip()
                 self.title = "Admission Slip"
             }else{
              dischargeSummary()
                 self.title = "Discharge Slip"
             }
            
        }
        
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
    func getAdmissionSlip(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
          let  url2 = ServiceUrl.testurl + "admissionSlipService/Print?crNo=" + obj!.crno + "&admno=" + arrData1.adm_no
       
       print("uuurrl2 \(url2)")
        
        
        guard let url = URL(string: url2)
        else{
            return
        }
        URLSession.shared.dataTask(with: url){
            (data,responce,Error) in
            
            guard let okData = data
            else{
                return
            }
            do{
                let pdf=try JSONDecoder().decode(AddmissionPdf.self, from: okData)
                if let decodeData = NSData(base64Encoded: pdf.AdmissionSlipBase64, options: .ignoreUnknownCharacters) {
                    DispatchQueue.main.async {
                        self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                    }
                    self.pdfString = pdf.AdmissionSlipBase64

                }
            }catch{
                print("Error Occured")
            }
            DispatchQueue.main.async {
                self.view.activityStopAnimating()
                
            }
        }.resume()
    }
    func dischargeSummary(){
        DispatchQueue.main.async {
            
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        //let urlEncoded =  arrData1.entryDate.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
       // print(ServiceUrl.getPastWebPrescription+"hosp_code="+arrData.hospCode+"&Modval=5&CrNo="+obj!.crno+"&episodeCode="+arrData.episodeCode+"&visitNo="+arrData.visitNo+"&seatId=0&Entrydate=\(urlEncoded!)")
        
       let url2 =  ServiceUrl.downloadDischargeSlip + "patCrNo=" + obj!.crno + "&patAdmNo=" + arrData1.adm_no + "&hmode=VIEWDISCHARGESUMMARYPDF_MOBILEAPP"
        
        URLSession.shared.dataTask(with: URL(string: url2)!) { (data, response, error) in
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
    func sickCertiPDF(){
        let printArr:[String] = sickCertificateData.printStr.components(separatedBy: "#")
                let certno:String  = printArr[0]
                let slno = printArr[3]
                let reqno = printArr[4]
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")


        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }

        
        let url = "\(ServiceUrl.testurl)sickLeaveService/printSickDtl?hospcode=\(obj!.hospCode)&crno=\(obj!.crno)&certno=\(certno)&reqno=\(reqno)&slno=\(slno)"
        guard let url = URL(string:url )
       // guard let url = URL(string: url2)
        else{
            return
        }
        URLSession.shared.dataTask(with: url){
            (data,responce,Error) in
            guard let okData = data
            else{
                return
            }
            do{
                let pdf=try JSONDecoder().decode(SickPdfModel.self, from: okData)
                if let decodeData = NSData(base64Encoded: pdf.BillBase64, options: .ignoreUnknownCharacters) {
                    DispatchQueue.main.async {
                        self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                    }
                    self.pdfString = pdf.BillBase64

                }
            }catch{
                print("Error Occured")
            }
            DispatchQueue.main.async {
                self.view.activityStopAnimating()

            }
        }.resume()
    }
    func transationPdf(){

        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")


        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        var url=""
        if(from == 4){
            url =  "\(ServiceUrl.testurl)AppOpdService/viewReferralLetter?crNo=\(arrRefData.crno)&reqNo=\(arrRefData.req_no)&episodeCode=\(arrRefData.episode_code)&visitNo=\(arrRefData.visit_no)&hospCode=\(arrRefData.hosp_code)&seatId=\(arrRefData.seat_id)&admNo=\(arrRefData.adm_no)&reqSlNo=\(arrRefData.req_sl_no)"
        }else if(from == 5){
            url =  ServiceUrl.getFamilyQrPdf+obj!.mobileNo
        
        }else{
             url = "\(ServiceUrl.testurl)AppOpdService/showReciept?crNo=\(obj!.crno)&billNo=\(transationModelData.tran_no)&hospcode=\(transationModelData.hosp_code)&receiptNo=\(transationModelData.reciept_no)"
        }
    print("transaction: ",url)
        guard let url = URL(string:url )
       // guard let url = URL(string: url2)
        else{
            return
        }
        URLSession.shared.dataTask(with: url){
            (data,responce,Error) in
            guard let okData = data
            else{
                return
            }
            do{
                let pdf=try JSONDecoder().decode(SickPdfModel.self, from: okData)
                if let decodeData = NSData(base64Encoded: pdf.BillBase64, options: .ignoreUnknownCharacters) {
                    DispatchQueue.main.async {
                        self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                    }
                    self.pdfString = pdf.BillBase64
                }
            }catch{
                print("Error Occured")
            }
            DispatchQueue.main.async {
                self.view.activityStopAnimating()

            }
        }.resume()
    }

}
