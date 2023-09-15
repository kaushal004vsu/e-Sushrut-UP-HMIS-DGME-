

import UIKit

class ReportListViewController: UIViewController {

    @IBOutlet weak var ReportListTableView: UITableView!
    var crno=""
    var arrData=[reportListModel]()
    
    @IBOutlet var lblNoReportsFound: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "udCrno") != nil  {
            self.crno=(UserDefaults.standard.object(forKey: "udCrno") as! String)
        }else{
            let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
            self.crno=obj!.crno
        }
            
            print("crno"+crno)
        
        
        ReportListTableView.rowHeight = UITableView.automaticDimension
        ReportListTableView.estimatedRowHeight = 44
jsonParsing()
        
    }
    
    func jsonParsing(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
   //URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let url = URL(string: ServiceUrl.reportListUrl+"\(self.crno)&hosCode=0")
        print("url "+ServiceUrl.reportListUrl+"\(self.crno)&hosCode=0")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                
                
                var json = try JSON(data:data)
              //  print(url)
               json=json["report_details"]
                print(json)
                if json.count == 0
                {
                    DispatchQueue.main.async {
                       
                    self.ReportListTableView.backgroundView=self.lblNoReportsFound
                    self.ReportListTableView.separatorStyle = .none
                    self.ReportListTableView.reloadData()
                        
                    }

                }
                else{
                for arr in json.arrayValue{
//                   print(arr["REPORTDATE"].stringValue)
                    self.arrData.append(reportListModel(json: arr))
                    
                }

                DispatchQueue.main.async {
                    self.ReportListTableView.backgroundView=nil
                    self.ReportListTableView.separatorStyle = .singleLine
                    self.ReportListTableView.reloadData()
                    
                }
                    
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
                }
            }catch{
                print("Sudeep"+error.localizedDescription)
            }
            }.resume()
    }
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            // Inform the user that the user name and password are incorrect
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Within your authentication handler delegate method, you should check to see if the challenge protection space has an authentication type of NSURLAuthenticationMethodServerTrust
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
            // and if so, obtain the serverTrust information from that protection space.
            && challenge.protectionSpace.serverTrust != nil
            && challenge.protectionSpace.host == ServiceUrl.hostName {
            let proposedCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, proposedCredential)
        }
    }

}


extension ReportListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportListableViewCell
        
        
        cell.lblTestNAme.text = "Test Name: "+arrData[indexPath.row].testName
        
        cell.lblReqNumber.text = "Req Number:   "+arrData[indexPath.row].reqNumber
        
        
        cell.lblReportDate.text = "Report Date: "+arrData[indexPath.row].reportDate
        
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController:ViewReportViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewReportViewController") as! ViewReportViewController
        viewController.arrData=arrData[indexPath.row]
        self.navigationController!.show(viewController, sender: self)
    }
    
    
}
