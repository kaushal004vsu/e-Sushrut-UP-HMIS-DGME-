
import UIKit
import WebKit
class ViewReportViewController: UIViewController, WKUIDelegate  {
    
    var arrData=reportListModel()
    var webView: WKWebView!
    var pdfString = ""
    override func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))

//        webView.topAnchor.constraint(equalTo: "50")
      
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let crno:String;
        if UserDefaults.standard.object(forKey: "udCrno") != nil  {
            crno=(UserDefaults.standard.object(forKey: "udCrno") as! String)
        }else{
            let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
             crno=obj!.crno
        }
        let url = URL(string: ServiceUrl.viewPdf+crno+"&reqDNo=\(arrData.reqNumber)&hosCode="+arrData.hospCode)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                let json = try JSON(data:data)
             //   print("url \(url)")
          
                for arr in json.arrayValue{
                    //                    print(arr["PDFDATA"].stringValue)
                    let baseData = arr["PDFDATA"].stringValue
                    if let decodeData = NSData(base64Encoded: baseData, options: .ignoreUnknownCharacters) {
                        DispatchQueue.main.async {
                            self.webView.load(decodeData as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
                        }
                        self.pdfString = baseData
                    }
                }
                
                
                
            }catch{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
               print("Sudeep"+error.localizedDescription)
            }
            }.resume()
    }
    
    
}




