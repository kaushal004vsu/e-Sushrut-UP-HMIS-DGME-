//  DoctorHomeViewController.swift
//  IGHCare
//
//  Created by sudeep rai on 21/08/20.
//  Copyright © 2020 sudeep rai. All rights reserved.
//

import UIKit
import SystemConfiguration
class DoctorHomeViewController: UIViewController, URLSessionDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var lblShowDetails: UILabel!
    @IBOutlet weak var dashboardDataRef: UIStackView!
    @IBOutlet weak var lblTodayTotal: UILabel!
    @IBOutlet weak var lblUpcomingTotal: UILabel!
    @IBOutlet weak var lblPastTotal: UILabel!
    @IBOutlet weak var lblTodayUnattended: UILabel!
    @IBOutlet weak var lblTodayApproved: UILabel!
    @IBOutlet weak var lblTodayCompleted: UILabel!
    @IBOutlet weak var lblTodayRejected: UILabel!
    @IBOutlet weak var lblUpcomingUnattended: UILabel!
    @IBOutlet weak var lblUpcomingRejected: UILabel!
    @IBOutlet weak var lblPastCompleted: UILabel!
    @IBOutlet weak var lblPastRejected: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dashboardRef: UIView!
    var allData=[DoctorHomeDetails]()
    var arFeaturId = [String]();
    var hospName:String!
    var hospId:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        hospName =  UserDefaults.standard.string(forKey: "udHospName")
        hospId =  UserDefaults.standard.string(forKey: "udHospCode")
        self.navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.action(sender:)))

        showAlert()
        checkUpdate()
        getDashboardData()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.btnDashboard))
        self.dashboardRef.addGestureRecognizer(gesture)
        
    }
    @IBAction func btnLogout(_ sender: Any) {
    logout()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return allData.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//    cell.clipsToBounds=true
//        for object in cell.contentView.subviews
//        {
//            object.removeFromSuperview();
//        }
//         if cell.viewWithTag(1234) == nil {
//
//    let lbl = UILabel(frame: CGRect(x: 0, y: 120, width: 150, height: 20))
//    lbl.text = allData[indexPath.row].labelName
//    let img = UIImageView(frame: CGRect(x:25, y: 20, width: 100, height: 100))
//    img.image = UIImage(named: allData[indexPath.row].iconName)
//    lbl.textAlignment = .center
//
//    cell.addSubview(img)
//    cell.addSubview(lbl)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doctor_cell", for: indexPath) as! DoctorMenuCell
    cell.menuIcon.image = UIImage(named: allData[indexPath.item].iconName)
    cell.lblIconName.text = allData[indexPath.item].labelName
    return cell
}
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(allData[indexPath.row].labelName)
    print(indexPath.row)
    if(allData[indexPath.row].id == "TR"){
        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TariffViewController") as? TariffViewController)!
    self.navigationController!.pushViewController( vc, animated: true)
    }
    if(allData[indexPath.row].id == "DD"){
//        let vc = (UIStoryboard.init(name: "Doctor", bundle: Bundle.main).instantiateViewController(withIdentifier: "OPDDeskViewController") as? OPDDeskViewController)!
//    self.navigationController!.pushViewController( vc, animated: true)
        
        let vc = (UIStoryboard.init(name: "doctor_desk", bundle: Bundle.main).instantiateViewController(withIdentifier: "DeskListViewController") as? DeskListViewController)!
    self.navigationController!.pushViewController( vc, animated: true)
    }
    if(allData[indexPath.row].id == "LE"){
        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LabEnquiryViewController") as? LabEnquiryViewController)!
        self.navigationController!.pushViewController( vc, animated: true)
    }
    if(allData[indexPath.row].id == "EM"){
        if (UserDefaults.standard.string(forKey:"udCrno") == nil){
            let vc = (UIStoryboard.init(name: "Doctor", bundle: Bundle.main).instantiateViewController(withIdentifier: "EnterCrViewController") as? EnterCrViewController)!
            self.navigationController!.pushViewController( vc, animated: true)
        }else{
            //call lp status webviev here
            let vc = (UIStoryboard.init(name: "Doctor", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmrViewController") as? EmrViewController)!
            vc.from = 8
            self.navigationController!.pushViewController( vc, animated: true)
        }
    }
    if(allData[indexPath.row].id == "OE"){
        
        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EnquiryViewController") as? EnquiryViewController)!
               self.navigationController!.pushViewController( vc, animated: true)
    }
   
   
    if(allData[indexPath.row].id == "EC"){
        let vc = (UIStoryboard.init(name: "Doctor", bundle: Bundle.main).instantiateViewController(withIdentifier: "DoctorListViewController") as? DoctorListViewController)!
    self.navigationController!.pushViewController( vc, animated: true)
    }
    if(allData[indexPath.row].id == "IV"){
        if (UserDefaults.standard.string(forKey:"udCrno") == nil){
            let vc = (UIStoryboard.init(name: "Doctor", bundle: Bundle.main).instantiateViewController(withIdentifier: "EnterCrViewController") as? EnterCrViewController)!
            self.navigationController!.pushViewController( vc, animated: true)
        }else{
            let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportListViewController") as? ReportListViewController)!
        self.navigationController!.pushViewController( vc, animated: true)
//      presentModal()
        }
       
    }
    if(allData[indexPath.row].id == "DA"){
        let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "DrugAvaiabilityViewController") as? DrugAvaiabilityViewController)!
        self.navigationController!.pushViewController( vc, animated: true)
        
    }
    if(allData[indexPath.row].id == "RX"){
        if (UserDefaults.standard.string(forKey:"udCrno") == nil){
            let vc = (UIStoryboard.init(name: "Doctor", bundle: Bundle.main).instantiateViewController(withIdentifier: "EnterCrViewController") as? EnterCrViewController)!
            self.navigationController!.pushViewController( vc, animated: true)
        }else{
            let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PrescriptionListViewController") as? PrescriptionListViewController)!
            vc.from = 2
        self.navigationController!.pushViewController( vc, animated: true)
            
        }
    }
    if(allData[indexPath.row].id == AppConstant.FEEDBACK)
    {
        askForAbhaOrFeedbackPop()

    }
    
}
    private func presentModal() {
        let detailViewController = EnterCrViewController()
        let nav = UINavigationController(rootViewController: detailViewController)
        // 1
        nav.modalPresentationStyle = .pageSheet
        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                // 3
                sheet.detents = [.medium(), .large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4
        present(nav, animated: true, completion: nil)
    }
    @IBAction func btnRefreshDahboard(_ sender: Any) {
        getDashboardData()
    }
    @objc func action(sender: UIBarButtonItem) {
        logout();
    }
    
    @objc func btnDashboard(sender: UIView) {
    
          print("dashboard clicked")
        if dashboardDataRef.isHidden==true
        {
            dashboardDataRef.isHidden=false
            collectionView.isHidden=true
            
            lblShowDetails.text="Hide Details"
        }
        else{
            dashboardDataRef.isHidden=true
            collectionView.isHidden=false
            
            lblShowDetails.text="Show Details"
        }
       }
    func logout()
    {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
      
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginMainScreenViewController") as! LoginMainScreenViewController
    }
    
    func showAlert() {
        if !self.isInternetAvailable() {
            let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func isInternetAvailable() -> Bool
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
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        get{
//            return .portrait
//        }
//    }
    
    func checkUpdate(){
        DispatchQueue.main.async {
                self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            }
        let url = URL(string: ServiceUrl.checkUpdate+"d" )
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else {
                    return }
                do{
                    let json = try JSON(data:data)
                    let appVersion=json["appVersion"].stringValue
                    let forceUpdate=json["forceUpdate"].stringValue
                    let jsonArray=json["features"].array;
        
                    print("appVersion-\(appVersion)")
                    if jsonArray==nil
                    {
                        print("nil json array");
                    }else
                    {
                        let jsonn = JSON(jsonArray as Any)
                        for arr in jsonn.arrayValue{
                        let featureId = arr["featureId"].stringValue
                        self.arFeaturId.append(featureId);
                            print(featureId)
                     }
                    }
                    if !self.arFeaturId.contains("EC") {
                    self.allData.append(DoctorHomeDetails(labelName: "Teleconsultancy",iconName: "teleconsultation",id: "EC"))
                    }
                    if !self.arFeaturId.contains("DD") {
//                          self.allData.append(DoctorHomeDetails(labelName: "OPD Desk",iconName: "doctor_desk",id: "DD"))
                          self.allData.append(DoctorHomeDetails(labelName: "OPD Desk",iconName: "doctor_ic",id: "DD"))
                    }
                    if !self.arFeaturId.contains("IV") {
                           self.allData.append(DoctorHomeDetails(labelName: "Lab Reports",iconName: "lab-reports",id: "IV"))
                    }
                    if !self.arFeaturId.contains("EM") {
                           self.allData.append(DoctorHomeDetails(labelName: "EMR",iconName: "emr_ic",id: "EM"))
                    }
                    if !self.arFeaturId.contains("PS") {
                           self.allData.append(DoctorHomeDetails(labelName: "RX Scan",iconName: "scanning",id: "PS"))
                    }
                    if !self.arFeaturId.contains("PV") {
                           self.allData.append(DoctorHomeDetails(labelName: "Scanned View",iconName: "view_prescription",id: "PV"))
                    }
                    if !self.arFeaturId.contains("OE") {
                           self.allData.append(DoctorHomeDetails(labelName: "OPD Enquiry",iconName: "opd-enquiry",id: "OE"))
                    }
                    if !self.arFeaturId.contains("TR") {
                          self.allData.append(DoctorHomeDetails(labelName: "Tariff Details",iconName: "tariff",id: "TR"))
                    }
                    if !self.arFeaturId.contains("LE") {
                           self.allData.append(DoctorHomeDetails(labelName: "Lab Enquiry",iconName: "lab-enquiry",id: "LE"))
                    }
                    if !self.arFeaturId.contains("DA") {
                           self.allData.append(DoctorHomeDetails(labelName: "Drug Availability",iconName: "drug_avalability",id: "DA"))
                    }
                    if !self.arFeaturId.contains("BS") {
                           self.allData.append(DoctorHomeDetails(labelName: "Blood Stock",iconName: "bloodstock",id: "BS"))
                    }
                    if !self.arFeaturId.contains("RX") {
                           self.allData.append(DoctorHomeDetails(labelName: "RX View",iconName: "view-prescription",id: "RX"))
                    }
                    if !self.arFeaturId.contains("FD") {
                           self.allData.append(DoctorHomeDetails(labelName: "Feedback",iconName: "feedback",id: "FD"))
                    }
                    if (!self.arFeaturId.contains("DB")) {
                        DispatchQueue.main.async {
                            self.dashboardRef.isHidden = false
                        }
                    }
                  
                    DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.collectionView.reloadData()
                        print("version -\(appVersion)--\(UIApplication.version)")
                         if(appVersion != UIApplication.version){
                             if(forceUpdate == "1"){
                                 let update_conti = "A new update of \(Bundle.main.displayName!) is available.Please update to continue using application."
                                 self.showUpdateAlertAction(title: "New Update Available", message: update_conti, btn: "Exit")
                             }else{
                                 let update_google_play_store = "A new update of \(Bundle.main.displayName!) is available.Tap Update Now to download the latest version from Apple Store."
                                 self.showUpdateAlertAction(title: "New Update Available", message: update_google_play_store, btn: "Skip")
                             }
                             
                         }else{
                             //self.askForAbhaOrFeedbackPop()
                         }
                    }
                }catch{
                    print("error")
                    print(error.localizedDescription)
                }
            }.resume()
        }
    
    func showUpdateAlertAction(title: String, message: String,btn:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btn, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            if(btn == "Skip"){
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            }else{
                exit(0)
            }
        }))
        alert.addAction(UIAlertAction(title: "Update Now", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            print("Action")
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id1567158984") {
                UIApplication.shared.open(url)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func getDashboardData(){
        //print("getDashboardData")
        var todayTotal=0
        var todayUnattended=0
        var todayApproved=0
        var todayCompleted=0
        var TodayRejected=0
        var upcomingTotal=0
        var upcomingUnattended=0
        var UpcomingRejected=0
        var pastTotal=0
        var pastCompleted=0
        var PastRejcted=0
        DispatchQueue.main.async {
                self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            }
        let url = URL(string: ServiceUrl.viewRequestListByEmployeeCode+UserDefaults.standard.string(forKey:"udEmpcode")! + "&hospCode=" + UserDefaults.standard.string(forKey:"udHospCode")!)
        print("hello"+ServiceUrl.viewRequestListByEmployeeCode+UserDefaults.standard.string(forKey:"udEmpcode")! + "&hospCode=" + UserDefaults.standard.string(forKey:"udHospCode")!)
          URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        let json = try JSON(data:data)
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                        }
                       if json["Data"].count != 0
                       {
                        for arr in json["Data"].arrayValue{
                            let today = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            let todaysDateString = formatter.string(from: today)
                            //Ref date
                             let dateFormatter = DateFormatter()
                             dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.s"
                             let someDate = dateFormatter.date(from: arr["apptDate"].stringValue)
                             dateFormatter.dateFormat = "yyyy-MM-dd"
                             let somedateString = dateFormatter.string(from: someDate!)
                            
                         /** Today's Data* */
                            if todaysDateString == somedateString  {
                            //todays total array
                                todayTotal=todayTotal+1
                                if arr["requestStatus"].stringValue=="0"
                                    {
                                        //todays unattended
                                        todayUnattended=todayUnattended+1
                                    }
                                else if arr["requestStatus"].stringValue=="1"
                                  {
                                      //todays approved
                                    todayApproved=todayApproved+1
                                  }
                                else if arr["requestStatus"].stringValue=="2"
                                {
                                    //todays completed
                                    todayCompleted=todayCompleted+1
                                }
                                 else if arr["requestStatus"].stringValue=="4"
                               {
                                     //todays rejected
                                TodayRejected=TodayRejected+1
                               }
                            }
                              /**Past Data**/
                                       if todaysDateString > somedateString  {
                                        if arr["requestStatus"].stringValue=="2" || arr["requestStatus"].stringValue=="4"
                                        {
                                            //past total array
                                            pastTotal=pastTotal+1
                                        }
                                       if arr["requestStatus"].stringValue=="2"
                                       {
                                           //past completed
                                        pastCompleted=pastCompleted+1
                                       }
                                        if arr["requestStatus"].stringValue=="4"
                                        {
                                            //past rejected
                                            PastRejcted=PastRejcted+1
                                        }
                            }
                            /** Upcoming Data* */
                            if todaysDateString < somedateString  {
                              if arr["requestStatus"].stringValue=="0" || arr["requestStatus"].stringValue=="4"
                                 {
                                    //upcoming total
                                    upcomingTotal=upcomingTotal+1
                                  }
                              if arr["requestStatus"].stringValue=="0"
                                 {
                                  //upcoming unattended
                                  upcomingUnattended=upcomingUnattended+1
                                 } else if arr["requestStatus"].stringValue=="4"{
                                  //upcoming rejected
                                   UpcomingRejected=UpcomingRejected+1
                                  }
                                 print("total isssss")
                                  }
                        }
                        
                        DispatchQueue.main.async {
                            self.view.activityStopAnimating()
                        
                                print("total is")
                                print("today total \(todayTotal)")
                        self.lblTodayTotal.text=String(todayTotal)
                                self.lblTodayUnattended.text=String (todayUnattended)
                        self.lblTodayApproved.text=String (todayApproved)
                        self.lblTodayCompleted.text=String (todayCompleted)
                        self.lblTodayRejected.text=String (TodayRejected)
                            
                        self.lblUpcomingTotal.text=String (upcomingTotal)
                        self.lblUpcomingUnattended.text=String (upcomingUnattended)
                        self.lblTodayRejected.text=String (UpcomingRejected)
                        
                        self.lblPastTotal.text=String(pastTotal)
                        self.lblPastCompleted.text=String (pastCompleted)
                        self.lblPastRejected.text=String (PastRejcted)
                            print("jksjkjskw");
                        }
                    }
                    }catch{
                        
                        DispatchQueue.main.async {
                            
                            self.view.activityStopAnimating()
                        }
                        
                        
                        print("aa"+error.localizedDescription)
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
    func askForAbhaOrFeedbackPop(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
//        let obj = UserDefaults.standard.retrieve(object: RegisteredPatientDetails.self, fromKey: "patientDetails")
//        let hospCode = obj!.hospCode
//        let mobileNo = obj!.mobileNo
           
        let userId =  UserDefaults.standard.string(forKey:"udUserId");
        let mobileNo =  UserDefaults.standard.string(forKey:"udMobileNo");
        let hospCode =  UserDefaults.standard.string(forKey:"udHospCode");
        let hospName =  UserDefaults.standard.string(forKey:"udHospName");
        let employeeCode =  UserDefaults.standard.string(forKey:"udEmpcode");
        
        var actualEmployeeCode =  UserDefaults.standard.string(forKey:"udEmployeeCode");
        if(actualEmployeeCode == nil){
            actualEmployeeCode = ""
        }
        let url = URL(string: ServiceUrl.FeedbackUrl)
            var request = URLRequest(url: url!)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "userId": userId!,
                "empNo" : actualEmployeeCode!,
                "crno" : "",
                "mobileNo" : mobileNo!,
                "umidNo" : "",
                "raiting" : "0",
                "hospcode" : hospCode!,
                "entrySource" : "2",
                "remarks" : "",
                "userType" : "2",
                "modeval" : "2",
            ]
        print("parameters--\(parameters)")
     request.httpBody = parameters.percentEncoded()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let json = try JSON(data:data)
                    let status = json["status"].stringValue
                    let msg = json["msg"].stringValue
                   
                    //change by kk 0 plz 1
                    if status=="1"{
                        if msg=="1"{
                            DispatchQueue.main.async {
                                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
                                loginVC.isModalInPresentation = false
                                loginVC.userType = "2"
                                self.present(loginVC, animated: true, completion: nil)
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.showAlert(message: " Could not save data.Please try again.")
                        }
                    }
                   
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                }catch{
                    print("sudeep"+error.localizedDescription)
                }
                }.resume()
        }
    private func showAlert(message:String)  {
        let refreshAlert = UIAlertController(title: "Info!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {(action: UIAlertAction!) in
            //showMobileLayout()
        }))
        present(refreshAlert, animated: true, completion: nil)

    }
}
extension DoctorHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            let columns:CGFloat=4;
            let spacing:CGFloat=8
            let totalHorizontalSpacing=(columns-1) * spacing
            let itemWidth=(collectionView.bounds.width-totalHorizontalSpacing)/columns
            let itemSize=CGSize(width: itemWidth, height: itemWidth * 1.2)
        return itemSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}


