//
//  ViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 04/06/22.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate{
  
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    
    @IBOutlet weak var lblPatName: UILabel!
    
    
    @IBOutlet weak var lblPatCrno: UILabel!
    var obj:PatientDetails!
    
    var timer = Timer()
    var counter = 0

//    var imgArr=[ UIImage(named:"abha_banner"),
//                    UIImage(named:"appoinment_banner") ,
//                    UIImage(named:"lab_report_banner") ,
//                    UIImage(named:"self_registration_banner") ,
//                 UIImage(named:"teleconsult_banner") ];
    
//    var imgArr=[
//
//        MenuDetails(labelName:"",iconName:"abha_banner",id:AppConstant.CREATE_ABHA),
//        MenuDetails(labelName:"",iconName:"appoinment_banner",id:AppConstant.APPOINTMENT),
//        MenuDetails(labelName:"",iconName:"lab_report_banner",id:AppConstant.LAB_REPORTS),
//        MenuDetails(labelName:"",iconName:"self_registration_banner",id:AppConstant.SELF_REG),
//        MenuDetails(labelName:"",iconName:"teleconsult_banner",id:AppConstant.TELECONSULTANCY_REQUEST),
//    ]
    var imgArr=[MenuDetails]();
    
    var menuArr=[MenuDetails]();
    var allData=[MenuDetails]();
    var arrFeatureId=[String]();
    
    let searchController=UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        checkVisibleModules()
        //populateMenuItems();
        //populateSlider()
     //   checkUpdate()
       
        self.navigationItem.title="Home";
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.action(sender:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Switch Patient", style: .plain, target: self, action: #selector(self.switchPatient(sender:)))
        
        //To retrieve the saved object
         obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        var empId:String=""
        if (obj!.umidNo != ""){
            empId = obj!.umidNo
        }
        
        lblPatName.text="Hi, "+obj!.firstName
        lblPatCrno.text="CR No. : \(obj!.crno) (\(empId))"
        
        
        
       
        
        searchBarSetup()
    }
    private func searchBarSetup(){
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        
        //self.searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController=searchController
        } else {
            
            searchController.hidesNavigationBarDuringPresentation = true
           // menuCollectionView.tableHeaderView = searchController.searchBar
        }
        
        
    }
    @objc func action(sender: UIBarButtonItem) {
 
        logout();
        
    }
    @objc func switchPatient(sender: UIBarButtonItem) {
 
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectCRViewController") as! SelectCRViewController
        
    }
    
    
    func logout()
    {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        sceneDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginMainScreenViewController") as! LoginMainScreenViewController
    }
    
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        sliderCollectionView.collectionViewLayout.invalidateLayout()
        menuCollectionView.collectionViewLayout.invalidateLayout()
    }
    
                func populateMenuItems()
                    {
                       // print("AppConstant.MY_CRN \(AppConstant.MY_CRN)");
                      
                        if(!self.arrFeatureId.contains(AppConstant.MY_CRN)){
                            self.menuArr.append(MenuDetails(labelName: "My CRN",iconName: "qr-codes",id: AppConstant.MY_CRN))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.APPOINTMENT)){
                            if(obj.patientCatCode != AppConstant.GENERAL_CATEGORY_CODE){
                                self.menuArr.append(MenuDetails(labelName: "Appointment",iconName: "appointment",id: AppConstant.APPOINTMENT))

                            }
                        }
                       
                        if(!self.arrFeatureId.contains(AppConstant.APPOINTMENT_STATUS)){
                            if(obj.patientCatCode != AppConstant.GENERAL_CATEGORY_CODE){
                                self.menuArr.append(MenuDetails(labelName: "Appointment Status",iconName: "prescription",id: AppConstant.APPOINTMENT_STATUS))
                            }
                            
                        }
                        if(!self.arrFeatureId.contains(AppConstant.RX_VIEW)){
                            self.menuArr.append(MenuDetails(labelName: "Rx View",iconName: "view-prescription",id: AppConstant.RX_VIEW))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.LAB_REPORTS)){
                            self.menuArr.append(MenuDetails(labelName: "Lab Reports",iconName: "lab-reports",id: AppConstant.LAB_REPORTS))
                        }
                       
                       
                        if(!self.arrFeatureId.contains(AppConstant.QUEUE_NO_SLIP)){
                            self.menuArr.append(MenuDetails(labelName: "Queue No. Slip",iconName: "queue",id: AppConstant.QUEUE_NO_SLIP))
                        }
                        
                        if(!self.arrFeatureId.contains(AppConstant.SELF_REG)){
                            self.menuArr.append(MenuDetails(labelName: "Self Registration",iconName: "self_registration",id: AppConstant.SELF_REG))
                        }
                       
                        if(!self.arrFeatureId.contains(AppConstant.TRANSACTION)){
                            self.menuArr.append(MenuDetails(labelName: "Transaction",iconName: "transaction_histry",id:AppConstant.TRANSACTION))
                        }
                        
                        if(!self.arrFeatureId.contains(AppConstant.IPD_DETAILS)){
                            self.menuArr.append(MenuDetails(labelName: "IPD Details",iconName: "ipd_details",id:AppConstant.IPD_DETAILS))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.LP_STATUS)){
                            self.menuArr.append(MenuDetails(labelName: "LP Status",iconName: "lp_status",id:AppConstant.LP_STATUS))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.OPD_ENQUARY)){
                            self.menuArr.append(MenuDetails(labelName: "OPD Enquiry",iconName: "opd-enquiry",id: AppConstant.OPD_ENQUARY))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.DRUG_AVAIABILITY)){
                            self.menuArr.append(MenuDetails(labelName: "Drug Availability",iconName: "drug_avalability",id:AppConstant.DRUG_AVAIABILITY))
                        }
                        
                        if(!self.arrFeatureId.contains(AppConstant.TARIFF_DETAILS)){
                            self.menuArr.append(MenuDetails(labelName: "Tariff Details",iconName: "tariff",id: AppConstant.TARIFF_DETAILS))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.LAB_ENQUARY)){
                            self.menuArr.append(MenuDetails(labelName: "Lab Enquiry",iconName: "lab-enquiry",id: AppConstant.LAB_ENQUARY))
                        }
                    //new menus
                        if(!self.arrFeatureId.contains(AppConstant.UPLOAD_DOCS)){
                            self.menuArr.append(MenuDetails(labelName: "Upload Document",iconName: "uploaddocument",id: AppConstant.UPLOAD_DOCS))
                        }
                
                        if(!self.arrFeatureId.contains(AppConstant.VIEW_DOCS)){
                            self.menuArr.append(MenuDetails(labelName: "View Document",iconName: "view_document",id: AppConstant.VIEW_DOCS))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.PROFILE)){
                            self.menuArr.append(MenuDetails(labelName: "Profile",iconName: "userproFile",id: AppConstant.PROFILE))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.ABOUT_US)){
                            self.menuArr.append(MenuDetails(labelName: "About Us",iconName: "about_us",id:AppConstant.ABOUT_US))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.SICK_CERTIFICATE)){
                            self.menuArr.append(MenuDetails(labelName: "Sick Certificate",iconName: "sick_certificate",id:AppConstant.SICK_CERTIFICATE))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.TOKEN_GENERATION)){
                            self.menuArr.append(MenuDetails(labelName: "Token Generation",iconName: "tokens",id:AppConstant.TOKEN_GENERATION))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.CREATE_ABHA)){
                            self.menuArr.append(MenuDetails(labelName: "Create Your ABHA",iconName: "create_abha",id:AppConstant.CREATE_ABHA))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.TELECONSULTANCY_REQUEST)){
                            self.menuArr.append(MenuDetails(labelName: "Teleconsultation",iconName: "teleconsultation",id:AppConstant.TELECONSULTANCY_REQUEST))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.REIMBURSEMENT_CLAIM)){
                            self.menuArr.append(MenuDetails(labelName: "Reimbursement Claim",iconName: "reimburshment",id:AppConstant.REIMBURSEMENT_CLAIM))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.PHR)){
                            self.menuArr.append(MenuDetails(labelName: "PHR",iconName: "phr",id:AppConstant.PHR))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.REQUEST_STATUS)){
                            self.menuArr.append(MenuDetails(labelName: "Request Status",iconName: "request_status",id:AppConstant.REQUEST_STATUS))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.FAMILY_MEMBER)){
                            self.menuArr.append(MenuDetails(labelName: "Family QR",iconName: "family_qr",id:AppConstant.FAMILY_MEMBER))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.DRUG_RX)){
                            self.menuArr.append(MenuDetails(labelName: "Medication (Rx)",iconName: "drugs_icon",id:AppConstant.DRUG_RX))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.ANNOUNCEMENT)){
                            self.menuArr.append(MenuDetails(labelName: "Announcement",iconName: "announcement_ic",id:AppConstant.ANNOUNCEMENT))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.FEEDBACK)){
                            self.menuArr.append(MenuDetails(labelName: "Feedback",iconName: "feedback",id:AppConstant.FEEDBACK))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.PHARMACY_Q_SLIP)){
                            self.menuArr.append(MenuDetails(labelName: "Pharmacy Q Slip",iconName: "pharmacy_q_ic",id:AppConstant.PHARMACY_Q_SLIP))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.REFERRAL_CERTIFICATE)){
                            self.menuArr.append(MenuDetails(labelName: "Referral Letters",iconName: "refer_certi_ic",id:AppConstant.REFERRAL_CERTIFICATE))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.REFERRAL_HOSP_INFO)){
                            self.menuArr.append(MenuDetails(labelName: "Referral Hospital Info",iconName: "ref_hosp_info_ic",id:AppConstant.REFERRAL_HOSP_INFO))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.EMEREGENCY_CONTACT)){
                            self.menuArr.append(MenuDetails(labelName: "Emergency Contacts",iconName: "emergency_ic",id:AppConstant.EMEREGENCY_CONTACT))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.HEALTH_INFO)){
                            self.menuArr.append(MenuDetails(labelName: "Health Information",iconName: "health_info_ic",id:AppConstant.HEALTH_INFO))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.HMIS_HELP_DESK)){
                            self.menuArr.append(MenuDetails(labelName: "HMIS Help Desk",iconName: "hmis_help_desk",id:AppConstant.HMIS_HELP_DESK))
                        }
                        if(!self.arrFeatureId.contains(AppConstant.USER_MANUALS)){
                            self.menuArr.append(MenuDetails(labelName: "User Manuals",iconName: "user_mannual_ic",id:AppConstant.USER_MANUALS))
                        }
                       
                        self.allData=self.menuArr
                        
                        DispatchQueue.main.async {
                            self.menuCollectionView.reloadData()

                        }
                        
                    }
    func populateSlider(){
       // print("feetured \(self.arrFeatureId)----\(AppConstant.CREATE_ABHA)")
        if(!self.arrFeatureId.contains(AppConstant.CREATE_ABHA)){
            self.imgArr.append(MenuDetails(labelName:"",iconName:"abha_banner",id:AppConstant.CREATE_ABHA))
        }
        if(!self.arrFeatureId.contains(AppConstant.APPOINTMENT)){
            if(obj.patientCatCode != AppConstant.GENERAL_CATEGORY_CODE){
                self.imgArr.append(MenuDetails(labelName:"",iconName:"appoinment_banner",id:AppConstant.APPOINTMENT))
            }
        }
        if(!self.arrFeatureId.contains(AppConstant.LAB_REPORTS)){
            self.imgArr.append(MenuDetails(labelName:"",iconName:"lab_report_banner",id:AppConstant.LAB_REPORTS))
        }
        if(!self.arrFeatureId.contains(AppConstant.SELF_REG)){
            self.imgArr.append(MenuDetails(labelName:"",iconName:"self_registration_banner",id:AppConstant.SELF_REG))
        }
        if(!self.arrFeatureId.contains(AppConstant.TELECONSULTANCY_REQUEST)){
            self.imgArr.append(MenuDetails(labelName:"",iconName:"teleconsult_banner",id:AppConstant.TELECONSULTANCY_REQUEST))
        }
        
        self.pageView.numberOfPages = self.imgArr.count
        self.pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            self.sliderCollectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView==self.sliderCollectionView)
        {
            return imgArr.count
        }else{
            return  menuArr.count
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.sliderCollectionView {
               //slider

         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
   
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.frame=CGRect(x:0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
            vc.image = UIImage(named:imgArr[indexPath.row].iconName)

        }
            return cell
        }
        
        else{
            
            //menu items
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patient_cell", for: indexPath) as! PatientMenuCell
    
            
            cell.menuIcon.image = UIImage(named: menuArr[indexPath.item].iconName)
            cell.lblIconName.text = menuArr[indexPath.item].labelName
//            cell.lblIconName.adjustsFontSizeToFitWidth = true
//            cell.lblIconName.minimumScaleFactor = 0.5
//            cell.lblIconName.sizeToFit()
//            cell.lblIconName.layoutIfNeeded()
            
            return cell
        
          
            
           // return cell
        }
       
    }
    
    @objc func changeImage() {

         if counter < imgArr.count {
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageView.currentPage = counter
               counter = 1
           }
      }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print("label name:::: "+menuArr[indexPath.row].labelName)
        //  print(indexPath.row)
        
        if(collectionView==self.sliderCollectionView)
        {
            if(imgArr[indexPath.row].id == AppConstant.APPOINTMENT)
            {
                let vc = (UIStoryboard.init(name: "Appointment", bundle: Bundle.main).instantiateViewController(withIdentifier: "OPDAppointmentViewController") as? OPDAppointmentViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
                //                AppUtilityFunctions.self.showAlertPopup(title: "Info", message: "This feature will be available soon.",self:self)
            }
            if(imgArr[indexPath.row].id == AppConstant.SELF_REG)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "EStampingViewController") as? EStampingViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            if(imgArr[indexPath.row].id == AppConstant.LAB_REPORTS)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "ReportListViewController") as? ReportListViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
        }
        else{
            if(menuArr[indexPath.row].id == AppConstant.MY_CRN)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "QRCodeViewController") as? QRCodeViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            
            if(menuArr[indexPath.row].id == AppConstant.APPOINTMENT)
            {
                let vc = (UIStoryboard.init(name: "Appointment", bundle: Bundle.main).instantiateViewController(withIdentifier: "OPDAppointmentViewController") as? OPDAppointmentViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
                // AppUtilityFunctions.self.showAlertPopup(title: "Info", message: "This feature will be available soon.",self:self)
            }
            if(menuArr[indexPath.row].id == AppConstant.APPOINTMENT_STATUS)
            {
                let vc = (UIStoryboard.init(name: "Appointment", bundle: Bundle.main).instantiateViewController(withIdentifier: "AppointmentStatusViewController") as? AppointmentStatusViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                // AppUtilityFunctions.self.showAlertPopup(title: "Info", message: "This feature will be available soon.",self:self)
            }
            
            if(menuArr[indexPath.row].id == AppConstant.TARIFF_DETAILS)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "TariffViewController") as? TariffViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            if(menuArr[indexPath.row].id == AppConstant.OPD_ENQUARY)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "EnquiryViewController") as? EnquiryViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            if(menuArr[indexPath.row].id == AppConstant.LAB_ENQUARY)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "LabEnquiryViewController") as? LabEnquiryViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            
            if(menuArr[indexPath.row].id == AppConstant.SELF_REG)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "EStampingViewController") as? EStampingViewController)!
                // self.navigationController!.pushViewController( vc, animated: true)
                self.present(vc, animated: true, completion: nil)
            }
            
            if(menuArr[indexPath.row].id == AppConstant.LAB_REPORTS)
            {
                
                let vc = (storyboard!.instantiateViewController(withIdentifier: "ReportListViewController") as? ReportListViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            
            if(menuArr[indexPath.row].id == AppConstant.RX_VIEW)
            {
                
                let vc = (storyboard!.instantiateViewController(withIdentifier: "PrescriptionListViewController") as? PrescriptionListViewController)!
                vc.from = 1
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            
            if(menuArr[indexPath.row].id == AppConstant.QUEUE_NO_SLIP)
            {
                
                let vc = (storyboard!.instantiateViewController(withIdentifier: "QMSListViewController") as? QMSListViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            
            
            //new menus
            if(menuArr[indexPath.row].id == AppConstant.IPD_DETAILS)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "IPDListViewController") as? IPDListViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                // AppUtilityFunctions.self.showAlertPopup(title: "Info", message: "This feature will be available soon.",self:self)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.UPLOAD_DOCS)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController)!
                vc.from = 3
                self.navigationController!.pushViewController( vc, animated: true)
            }
            if(menuArr[indexPath.row].id == AppConstant.VIEW_DOCS)
            {
                
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewDocumentViewController") as? ViewDocumentViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.PROFILE)
            {
                
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.ABOUT_US)
            {
                
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.SICK_CERTIFICATE)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "SickCertificateViewController") as? SickCertificateViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.TRANSACTION)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransactionViewController") as? TransactionViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
//            if(menuArr[indexPath.row].id == AppConstant.TOKEN_GENERATION)
//            {
//                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "TokenGenerationViewController") as? TokenGenerationViewController)!
//                self.navigationController!.pushViewController( vc, animated: true)
//
//            }
            if(menuArr[indexPath.row].id == AppConstant.LP_STATUS)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController)!
                vc.from = 1
                self.navigationController!.pushViewController( vc, animated: true)
                
                // AppUtilityFunctions.self.showAlertPopup(title: "Info", message: "This feature will be available soon.",self:self)
            }
            if(menuArr[indexPath.row].id == AppConstant.DRUG_AVAIABILITY)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "DrugAvaiabilityViewController") as? DrugAvaiabilityViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.CREATE_ABHA)
            {
                let vc = (UIStoryboard.init(name: "create_abha", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateAbhaViewController") as? CreateAbhaViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.TELECONSULTANCY_REQUEST)
            {
                
                let vc = (UIStoryboard.init(name: "teleconsultation", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeleconsultationViewController") as? TeleconsultationViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
                
            }
            
            if(menuArr[indexPath.row].id == AppConstant.REIMBURSEMENT_CLAIM)
            {
                
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReimbursementViewController") as? ReimbursementViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
                
            }
            if(menuArr[indexPath.row].id == AppConstant.PHR)
            {
                
                let vc = (UIStoryboard.init(name: "phr", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhrViewController") as? PhrViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
                
            }
            if(menuArr[indexPath.row].id == AppConstant.REQUEST_STATUS)
            {
                //                let vc = (storyboard!.instantiateViewController(withIdentifier: "StatusViewController") as? StatusViewController)!
                //            self.navigationController!.pushViewController( vc, animated: true)
                
                let vc = (UIStoryboard.init(name: "teleconsultation", bundle: Bundle.main).instantiateViewController(withIdentifier: "StatusViewController") as? StatusViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.FAMILY_MEMBER)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
                vc.from=5
                //vc.transationModelData = arrData[indexPath.row]
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.DRUG_RX)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "DrugRxViewController") as? DrugRxViewController)!
                //vc.transationModelData = arrData[indexPath.row]
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.ANNOUNCEMENT)
            {
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "AnnouncementViewController") as? AnnouncementViewController)!
                //vc.transationModelData = arrData[indexPath.row]
                self.navigationController!.pushViewController( vc, animated: true)
                
            }
            if(menuArr[indexPath.row].id == AppConstant.FEEDBACK)
            {
                askForAbhaOrFeedbackPop()
                
            }
            if(menuArr[indexPath.row].id == AppConstant.PHARMACY_Q_SLIP)
            {
                let vc = (storyboard!.instantiateViewController(withIdentifier: "PharmacyQSlipViewController") as? PharmacyQSlipViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            
            if(menuArr[indexPath.row].id == AppConstant.REFERRAL_CERTIFICATE)
            {
                let vc = (UIStoryboard.init(name: "referral", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReferralViewController") as? ReferralViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            
            if(menuArr[indexPath.row].id  == AppConstant.REFERRAL_HOSP_INFO){
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController)!
                vc.from = 5
                self.navigationController!.pushViewController( vc, animated: true)
            }
            if(menuArr[indexPath.row].id  == AppConstant.EMEREGENCY_CONTACT){
                let vc = (UIStoryboard.init(name: "emergency", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmergencyContactViewController") as? EmergencyContactViewController)!
                self.navigationController!.pushViewController( vc, animated: true)
            }
            if(menuArr[indexPath.row].id  == AppConstant.HEALTH_INFO){
                let vc = (UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController)!
                vc.from = 6
                self.navigationController!.pushViewController( vc, animated: true)
            }
            if(menuArr[indexPath.row].id  == AppConstant.HMIS_HELP_DESK){
                let loginVC = UIStoryboard(name: "user_support", bundle: nil).instantiateViewController(withIdentifier: "HmisHelpDeskViewController") as! HmisHelpDeskViewController
                loginVC.from = 1
                self.present(loginVC, animated: true, completion: nil)
            }
            if(menuArr[indexPath.row].id  == AppConstant.USER_MANUALS){
                let loginVC = UIStoryboard(name: "user_support", bundle: nil).instantiateViewController(withIdentifier: "HmisHelpDeskViewController") as! HmisHelpDeskViewController
                loginVC.from = 2
                self.present(loginVC, animated: true, completion: nil)
            }
        }
    }

    func checkVisibleModules(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let url = URL(string: ServiceUrl.checkUpdateurl+"p")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
            
                let appVersion=json["appVersion"].stringValue
                print("appVersion \(appVersion)")
                let forceUpdate=json["forceUpdate"].stringValue
                let arr=json["features"].arrayValue
                for a in arr
                {
                   // print(a["featureId"].stringValue)
                    self.arrFeatureId.append(a["featureId"].stringValue);
                }
               // print(" self.arrFeatureId  \( self.arrFeatureId)");
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.populateSlider()
                    self.populateMenuItems()
                    print("UIApplication.version) \(UIApplication.version))");
                    if(appVersion != UIApplication.version){
                        if(forceUpdate == "1"){
                            let update_conti = "A new update of \(Bundle.main.displayName!) is available.Please update to continue using application."
                            self.showUpdateAlertAction(title: "New Update Available", message: update_conti, btn: "Exit")
                        }else{
                            let update_google_play_store = "A new update of \(Bundle.main.displayName!) is available.Tap Update Now to download the latest version from App Store."
                            self.showUpdateAlertAction(title: "New Update Available", message: update_google_play_store, btn: "Skip")
                        }
                        
                    }
                   
                }
               
               
                
            }catch{
                print("error:: "+error.localizedDescription)
            }
            }.resume()
    }
    func askForAbhaOrFeedbackPop(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let crno = obj!.crno
        let hospCode = obj!.hospCode
        let mobileNo = obj!.mobileNo
        
      //  let umidNo=UserDefaults.standard.string(forKey: "udUmidNo")!
        let url = URL(string: ServiceUrl.FeedbackUrl)
            var request = URLRequest(url: url!)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "userId": "",
                "empNo" : "",
                "crno" : crno,
                "mobileNo" : mobileNo,
                "umidNo" : "",
                "raiting" : "0",
                "hospcode" : hospCode,
                "entrySource" : "2",
                "remarks" : "",
                "userType" : "1",
                "modeval" : "2",
            ]
        print("parameters- \(parameters)")
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
                                loginVC.userType = "1"
                                self.present(loginVC, animated: true, completion: nil)
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.showAlert(message: "Feedback already given.")
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.showAlert(message: "Something went wrong!.")
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
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id6444206953") {
                UIApplication.shared.open(url)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateTo(storyboardName:String,storyboardId:String,viewController:UIViewController)
    {
//        let vc = (UIStoryboard.init(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboardId) as? viewController)!
//        self.navigationController!.pushViewController( vc, animated: true)
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
//        if(collectionView==self.sliderCollectionView)
//        {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }else{
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView==self.sliderCollectionView)
        {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
        }else{
            let columns:CGFloat=4;
            let spacing:CGFloat=8
            let totalHorizontalSpacing=(columns-1) * spacing
            let itemWidth=(menuCollectionView.bounds.width-totalHorizontalSpacing)/columns
            let itemSize=CGSize(width: itemWidth, height: itemWidth * 1.2)
        return itemSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView==self.sliderCollectionView
        {
        return 0.0
        }
            else{
            return 8.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView==self.sliderCollectionView
        {
            return 0.0
        }
        else{
        return 5.0
    }
    }
    
}

extension ViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.menuArr=self.allData
        }
        else{
            menuArr=allData
            menuArr=menuArr.filter{
                $0.labelName.lowercased().contains(searchText.lowercased())
            }
        }
        menuCollectionView.reloadData()
    }
}
