//
//  OPDLiteVController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 20/07/23.
//
import UIKit
import iOSDropDown
class OPDLiteVController: UITableViewController,UIAlertViewDelegate,UITextFieldDelegate, URLSessionDelegate {
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var patient_name_lbl: UILabel!
    @IBOutlet weak var crno_lbl: UILabel!
    
    @IBOutlet var myTableview: UITableView!
    
    @IBOutlet weak var investigationLbl: UILabel!
    
    @IBOutlet weak var procedureLbl: UILabel!
    
    
    @IBOutlet weak var drugsLbl: UILabel!
    
    @IBOutlet weak var rxLbl: UILabel!
    @IBOutlet weak var close_iv: UIImageView!
    
    @IBOutlet weak var patient_header_stk: UIStackView!
    var obj:PatientDetails!
    var opdPatientDetails=OPDPatientDetails()
    var callBack: ((_ param1: String, _ param2: String, _ param3: String)-> Void)?
    
    var investigationArrayData = [InvestigationArrayData]()
    var arrProcedureData = [ProcedureArrayData]()
    var arrDrugArrayData = [DrugArrayData]()
    var emrJSON=EmrJSON()
    
    
    var status = "", Pat_details = "",customUnit = "",designation = "",fatherName = "",umid_no = "", catName = ""
    override func viewDidLoad() {
        patient_header_stk.layer.cornerRadius = 10
        patient_header_stk.clipsToBounds = true
        
        self.getPatDetail()
        self.showInternetAlert()
        myTableview.delegate = self
        myTableview.dataSource = self
        myTableview.clipsToBounds = true

        
        hideKeyboardWhenTappedAround()
        patient_name_lbl.text! = "\(opdPatientDetails.patname)"
        crno_lbl.text! = "\(opdPatientDetails.patcrno)"
        
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:)))
        //               close_iv.isUserInteractionEnabled = true
        //               close_iv.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func investigationBtn(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InvestigationViewController")as? InvestigationViewController {
            vc.callBack = { (param1: [InvestigationArrayData],param2: String,param3: String) in
                //                self.investigationLbl.text! = "\(param1[0].title!)"
                self.investigationArrayData = param1
                var reportSummary:String="";
                for i in param1
                {
                    reportSummary = reportSummary.appending("\(i.TestName!),\n ")
                }
                self.investigationLbl.text! = reportSummary;

            }
            vc.investigationArrayData =  self.investigationArrayData
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func procedureBtn(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProceduresViewController")as? ProceduresViewController {
            vc.callBack = { (param1: [ProcedureArrayData],param2: String,param3: String) in
                //  self.procedureLbl.text! = "\(param1)"
                //                self.procedureLbl.text! = "\(param1[0].title!)"
                self.arrProcedureData = param1
                var reportSummary:String="";
                for i in param1
                {
                    reportSummary = reportSummary.appending("\(i.ProceduresName!),\n")
                }
                self.procedureLbl.text! = reportSummary;
            }
            vc.procedureArrayData =  self.arrProcedureData
            self.present(vc, animated: true, completion: nil)
        }
    }
   
    @IBAction func drugBtn(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrugsPrescribeViewController")as? DrugsPrescribeViewController {
            vc.callBack = { (param1: [DrugArrayData],param2: String,param3: String) in
                self.arrDrugArrayData = param1
                var reportSummary:String="";
                for i in param1
                {
                    reportSummary = reportSummary.appending("\(i.drugName!),\n")
                }
                self.drugsLbl.text! = reportSummary;
            }
            vc.drugArrayData =  self.arrDrugArrayData
            self.present(vc, animated: true, completion: nil)
            //            self.navigationController!.pushViewController( vc, animated: true)
        }
        
    }
    
    @IBAction func rxBtn(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RxPrescribeViewController")as? RxPrescribeViewController {
            vc.callBack = { (param1: String,param2: String,param3: String) in
                self.rxLbl.text! = param1
            }
            //            vc.detpArrData = self.arrOpdDept
            vc.rxStr = self.rxLbl.text!
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func back_btn(_ sender: Any) {
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func SaveBtn(_ sender: Any) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Confirm", message: "Do you want to save Prescrition?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self, weak alert] (_) in
            DispatchQueue.main.async {
                self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            }
            saveEhrJsonDataNew()
            saveEmrJsonDataNew()
            callBack?("save","param2","param3")

        }
        ))
            
           
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        
     
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
    func showAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
            //                print("Handle Ok logic here")
            //  self.navigationController?.popToRootViewController(animated: true)
            self.dismiss(animated: true)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    //Mark:-Save Emr JSON
    private func saveEmrJsonDataNew(){
        //        let clinicalProcedureJSONArray=ClinicalProcedureJSONArrayEmr()
        
        
        let emrJson=EmrJSON()
        
        emrJson.admissionadviceDeptName = ""
        emrJson.admissionadviceNotes = ""
        emrJson.admissionadviceWardName = ""
        emrJson.crNo=opdPatientDetails.patcrno
        emrJson.chronicDiseaseArray=[ChronicDiseaseArray]()

        // MARK: - Procedure
        emrJson.clinicalProcedureJSONArray=[ClinicalProcedureJSONArrayEmr]()
        for i in arrProcedureData
        {
            emrJson.clinicalProcedureJSONArray.append(contentsOf: [ClinicalProcedureJSONArrayEmr(isExternal: "0", procedureCode: i.ProcedureCode, procedureSideCode: self.getSideCode(sideCode: i.ProcedureSideName), procedureSideName: i.ProcedureSideName, procedureSideRemarks: i.ProcedureSideRemarks, proceduresName: i.ProceduresName, serviceAreaCode: i.ServiceAreaCode, serviceAreaName: i.ServiceAreaName, strSittingJSON: "")])
            
          //  emrJson.clinicalProcedureJSONArray=[ClinicalProcedureJSONArrayEmr(isExternal: "0", procedureCode: i.ProcedureCode, procedureSideCode: "0", procedureSideName: i.ProcedureSideName, procedureSideRemarks: i.ProcedureSideRemarks, proceduresName: i.ProceduresName, serviceAreaCode: i.ServiceAreaCode, serviceAreaName: i.ServiceAreaName, strSittingJSON: "")]
            
        }
        
        emrJson.completeHistoryJaonArray = CompleteHistoryJaonArrayEmr(strfamilyHistory: "", strpastHistory: "", strpersonalHistory: "", strsurgicalHistory: "", strtreatmentHistory: "")
        
        emrJson.consultantName = UserDefaults.standard.string(forKey: "udUserdisplayname")!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/yyyy"
        let dateObj = dateFormatter.date(from: opdPatientDetails.episodedate)
        emrJson.currentVisitDate = dateFormatter.string(from:dateObj!)
        
        emrJson.diagnosisJSONArray=[DiagnosisJsonArray]()
        emrJson.diagnosisNote = ""
        // MARK: - Drug
        emrJson.drugJSONArray=[DrugJSONArray]()
        for i in arrDrugArrayData
        {
            emrJson.drugJSONArray.append(contentsOf: [DrugJSONArray(mode: "NEW", doaseCode: "0", doaseName: "--", drugCode: i.drugCode, drugDays: i.totalDrugGiven, drugInstruction: i.desc, drugName: i.drugName, drugQuantity: String(i.totalQty), episodeCode: opdPatientDetails.episodecode, frequencyCode: "0", frequencyName: i.frequencyName, isExterNal: "0", startDate: Date.getCurrentDate(), visitNo: opdPatientDetails.visitNo)])
        }
        
        emrJson.episodeCode = opdPatientDetails.episodecode
        emrJson.episodeVisitNo = opdPatientDetails.episodevisitno
        emrJson.followUp = [FollowUpEmr(endTreatment: "0", instructionNote: "", plannedVisit: [PlannedVisit(plannedVisitDate: "", plannedVisitDays: "", plannedVisitSos: "SOS")], progressNote: "")]
        
        emrJson.historyOfPresentIllNess = ""
        emrJson.hospCode = opdPatientDetails.gnumHospitalCode
        emrJson.hrgnumIsDocuploaded = 0
        emrJson.hvsValue = ""
        emrJson.investgationNote = ""
        
        // MARK: - Investigation
       // print("investigationArrayData-\(investigationArrayData.count)")
        emrJson.investigationJSONArray=[InvestigationJSONArray]()
        for i in investigationArrayData
        {
            let result = i.testDetail.split(separator: "^")
            let testCode = String(result[0])
            let tariffId=String(result[0])
            let LabCode = String(result[1])
            let SampleCode = String(result[2])
            let SampleName = String(result[3])
            let LabName = String(result[4])
            let TestName = i.TestName!
            let isConsent=i.isConsent!
            
            emrJson.investigationJSONArray.append(contentsOf: [InvestigationJSONArray(episodeCode: opdPatientDetails.episodecode, isExternal: "0", isTestGroup: "0", labCode: LabCode, labName: LabName, sampleCode: SampleCode, sampleName: SampleName, sideCode:self.getSideCode(sideCode: i.SideName), sideName: i.SideName, sideRemarks: i.SideRemarks, testCode: testCode, testName: TestName, visitNo: opdPatientDetails.visitNo, isConsent: isConsent, tariffID: tariffId)])
        }
        emrJson.isHvsFlg = "1"
        emrJson.lastVisitDate = ""
        emrJson.otherAllergies = ""
        emrJson.pacReqJSONArr = [String]()
        emrJson.patCatCode = ""
        emrJson.patCompleteGeneralDtl = "\(self.Pat_details)^^^null"
        emrJson.patGaurdianName = ""
        emrJson.patVisitType = ""
        let patAgeSubstring = opdPatientDetails.genderage
        let patGenderSubstring = opdPatientDetails.genderage
        
        emrJson.patientAge = String(patAgeSubstring)
        emrJson.patientCat = ""
        emrJson.patientDept = opdPatientDetails.departmentunitname
        emrJson.patientGender = String(patGenderSubstring)
        emrJson.patientName = opdPatientDetails.patname
        emrJson.patientQueueNo = ""
        emrJson.patientRefrel = [String]()
        emrJson.piccleArray  = PiccleArray(strclubbing: "0", strcyanosis: "0", stredema: "0", stricterus: "0", striymphadenopathyID: "0", strpallor: "0")
        emrJson.reasonOfVisitJSONArray = [String]()
        emrJson.referralProcJSON = [String]()
        emrJson.referralTestJSON = [String]()
        emrJson.seatID = UserDefaults.standard.string(forKey: "udEmpcode")!
        emrJson.strAllDeptIdflg = "1"
        
        emrJson.strAllDeptIdflg = ""
        emrJson.strBookmarkModifyFlag = "0"
        emrJson.strConfidentialsInfo = ""
        emrJson.strDeptIdflg = ""
        emrJson.strDesignation  = ""
        emrJson.strLevelOfEntitlement = ""
        emrJson.strPatRecentDept =  ""
        emrJson.strPresCriptionBookmarkDescVal =  ""
        emrJson.strPresCriptionBookmarkNameval =  ""
        emrJson.strPresProfileBookmarkID = ""
        emrJson.strStation = ""
        emrJson.strUmidNo =  self.umid_no
        emrJson.strVitalsChart = ""
        emrJson.strpiccle = StrpiccleEmr(strclubbing: "0", strcyanosis: "0", stredema: "0", stricterus: "0", striymphadenopathyID: "0", strpallor: "0")
        emrJson.strtreatmentAdvice = self.rxLbl.text!
        emrJson.systematicExamniationArray = SystematicExamniationArrayEmr(strLocalExamn: "", strcns: "", strcvs: "", strmuscularExamn: "", strotherExamn: "", strpA: "", strrs: "")
        
        
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try! encoder.encode(emrJson)
     //   print(String(data: jsonData, encoding: .utf8)!)
        print("emrJson2222-\(String(data: jsonData, encoding: .utf8)!)")

        
        
        
        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let url = URL(string: ServiceUrl.saveEmrJsonData)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        request.setValue("\(String(describing: jsonData.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                self.showAlert(title: "", message:"error")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("response string:  \(responseJSON)") //Code after Successfull POST Request
                
                let status:String = (responseJSON["status"]) as! String
                DispatchQueue.main.async {
                    if(status == "1"){
                      //  self.showAlert(title: "Success", message: "Data Saved Successfully!")
                      //  self.showToast(message: "Data Saved Successfully!", font: .systemFont(ofSize: 12))
                        
                    }else{
                        self.showAlert(title: "Cannot Raise Request", message:"")
                    }
                    self.view.activityStopAnimating()
                }
            }
        }
        task.resume()

    }

    //Mark:-Save Ehr JSON
    private func saveEhrJsonDataNew(){
        //        let clinicalProcedureJSONArray=ClinicalProcedureJSONArrayEmr()
        
        
        let ehrJson=EhrJSON()
        
        ehrJson.admissionadviceDeptName = ""
        ehrJson.admissionadviceNotes = ""
        ehrJson.admissionadviceWardName = ""
        ehrJson.crNo=opdPatientDetails.patcrno
        
        ehrJson.clinicalProcedureJSONArray=[ClinicalProcedureJSONArray]()
        // MARK: - Procedure
        for i in arrProcedureData
        {
            ehrJson.clinicalProcedureJSONArray.append(contentsOf: [ClinicalProcedureJSONArray(isExternal: "0", procedureCode: i.ProcedureCode, procedureSideCode: "0", procedureSideName: i.ProcedureSideName, procedureSideRemarks: i.ProcedureSideRemarks, proceduresName: i.ProceduresName, serviceAreaCode: i.ServiceAreaCode, serviceAreaName: i.ServiceAreaName, strSittingJSON: "")])
        }
        
        ehrJson.patConsultantName = UserDefaults.standard.string(forKey: "udUserdisplayname")!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/yyyy"
        let dateObj = dateFormatter.date(from: opdPatientDetails.episodedate)
        ehrJson.currentVisitDate = dateFormatter.string(from:dateObj!)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        _ = dateFormatter2.date(from: opdPatientDetails.episodedate)
        
        let todayDate = Date.getCurrentDate()

        ehrJson.diagnosis=[String]()
        ehrJson.drugCodeCat = [String]()
        // MARK: - Drug
        for i in arrDrugArrayData
        {
            ehrJson.drugCodeCat.append("\(i.drugName!)&&\(i.drugCodeValue!)&&--&&\(0)&&\(i.frequencyName!)&&\(0)&&\(todayDate)&&\(i.totalDrugGiven!)#\(i.totalQty!)&&\(i.desc!)&& && &&")
        }
        
        ehrJson.episodeCode = opdPatientDetails.episodecode
        ehrJson.episodeVisitNo = opdPatientDetails.episodevisitno
        ehrJson.followUp = [FollowUp(endTreatment: "0", instructionNote: "", plannedVisit: [PlannedVisit(plannedVisitDate: "", plannedVisitDays: "", plannedVisitSos: "SOS")], progressNote: "")]
        
        ehrJson.hospCode = opdPatientDetails.gnumHospitalCode
        ehrJson.hrgnumIsDocuploaded = 0
        ehrJson.hvsValue = ""
        ehrJson.strInvestgationNote = ""
        ehrJson.invTestCode = [String]()
        // MARK: - Investigation
        for i in investigationArrayData
        {
            ehrJson.invTestCode.append("\(i.testDetail!)^0^\(opdPatientDetails.episodecode)^\(opdPatientDetails.visitNo)^1^\(i.remarks!)^\(i.visitDate!)^0^\(i.TestName!)\(i.SideRemarks!)")
        }
        ehrJson.invTestCodeToPrint = [String]()
         for i in investigationArrayData
         {
             ehrJson.invTestCodeToPrint.append("\(i.testDetail!)^0^\(opdPatientDetails.episodecode)^\(opdPatientDetails.visitNo)^1^\(i.remarks!)^\(i.visitDate!)^0^\(i.TestName!)\(i.SideRemarks!)")
         }
        ehrJson.isHvsFlg = "1"
        ehrJson.lastVisitDate = ""
        ehrJson.strotherAllergies = ""
        ehrJson.pacReqJSONArr = [String]()
        ehrJson.patCatCode = ""
        ehrJson.patCompleteGeneralDtl = "\(self.Pat_details)^^^null"
        ehrJson.patGaurdianName = ""
        ehrJson.patVisitType = opdPatientDetails.visitType
        let patAgeSubstring = opdPatientDetails.genderage.suffix(5)
        let patGenderSubstring = opdPatientDetails.genderage.prefix(1)


        ehrJson.patAge = " \(String(patAgeSubstring))"
        ehrJson.patCat = ""
        ehrJson.patDept = opdPatientDetails.departmentunitname
        ehrJson.patGender = String(patGenderSubstring)
        ehrJson.patName = opdPatientDetails.patname
        ehrJson.patQueueNo = opdPatientDetails.mobileno
        ehrJson.referralTestJSON = [String]()
        ehrJson.referralProcJSON = [String]()
        ehrJson.reasonOfVisit = [String]()
        ehrJson.strpiccle  = Strpiccle(strclubbing: "0", strcyanosis: "0", stredema: "0", stricterus: "0", striymphadenopathyID: "0", strpallor: "0")
        
        ehrJson.seatID = UserDefaults.standard.string(forKey: "udEmpcode")!
        ehrJson.strAllDeptIdflg = "1"
        
        ehrJson.strBookmarkModifyFlag = "0"
        
        ehrJson.strChronicDisease = [String]()
        
        ehrJson.strConfidentialsInfo = ""
        ehrJson.strDeptIdflg = "0"
        ehrJson.strDesignation  = ""
        ehrJson.strLevelOfEntitlement = ""
        ehrJson.strPatRecentDept =  ""
        ehrJson.strPresCriptionBookmarkDescVal =  ""
        ehrJson.strPresCriptionBookmarkNameval =  ""
        ehrJson.strPresProfileBookmarkID = ""
        ehrJson.strStation = ""
        ehrJson.strUmidNo =  self.umid_no
        ehrJson.strVitalsChart = ""
        ehrJson.strClinicalProcedure = [String]()
        
        for i in self.arrProcedureData
         {
            ehrJson.strClinicalProcedure.append("\(i.ProceduresName!)#\(i.ProcedureCode!)#0#\(i.ProcedureSideName!)#\(i.ProcedureSideRemarks!)#\(i.ServiceAreaCode!)#\(i.ServiceAreaName!)")
         }
        
        ehrJson.strtreatmentAdvice = self.rxLbl.text!
        ehrJson.strSystematicExamniation = StrSystematicExamniation(strLocalExamn: "", strcns: "", strcvs: "", strmuscularExamn: "", strotherExamn: "", strpA: "", strrs: "")
        ehrJson.strCompleteHistory = StrCompleteHistory(strfamilyHistory: "", strpastHistory: "", strpersonalHistory: "", strsurgicalHistory: "", strtreatmentHistory: "")
        ehrJson.strDiagnosisNote = ""
        ehrJson.strDrugAllergy = [String]()
        ehrJson.strHistoryOfPresentIllNess = ""
        ehrJson.strReferal = [String]()
        
        let actualEmployeeCode =  UserDefaults.standard.string(forKey:"udEmployeeCode");
        print("actualEmployeeCode--\(actualEmployeeCode!)")

        ehrJson.strUserEmpNo = actualEmployeeCode!
        
        
        
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try! encoder.encode(ehrJson)
        print("ehrJson2222-\(String(data: jsonData, encoding: .utf8)!)")
        
        
        
        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let url = URL(string: ServiceUrl.saveEhrJsonDataNew)
        print("saveEhrJsonDataNewbykk-\(ServiceUrl.saveEhrJsonDataNew)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        request.setValue("\(String(describing: jsonData.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                self.showAlert(title: "", message:"error")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("response string:  \(responseJSON)") //Code after Successfull POST Request
                
                let status:String = (responseJSON["status"]) as! String
                DispatchQueue.main.async {
                    if(status == "1"){
                        self.callFollowUpServices()
                    }else{
                        self.showAlert(title: "Cannot Raise Request", message:"")
                    }
                    self.view.activityStopAnimating()
                }
            }
        }
        task.resume()

    }
    private func callFollowUpServices()
    {
        let url = URL(string: ServiceUrl.followUpService)
       print(ServiceUrl.followUpService)
        let parameters: [String: Any] = [
            "CR_No": opdPatientDetails.patcrno,
            "episodeCode": opdPatientDetails.episodecode,
            "hosp_code": (UserDefaults.standard.string(forKey: "udHospCode")!),
            "visitNo": opdPatientDetails.visitNo,
            "progressNote": "",
            "PlannedVisitDate": ""
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        print(String(decoding: jsonData!, as: UTF8.self))
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

       
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                self.showAlert(title: "", message:"error")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("response string:  \(responseJSON)") //Code after Successfull POST Request
                
            
                let status:String = (responseJSON["status"]) as! String
                DispatchQueue.main.async {
                    if(status == "1"){
                        
                        self.showAlert(title: "Info", message:"Prescription saved successfully.")
                    }else{
                        self.showAlert(title: "Cannot Raise Request", message:"")
                    }
                    self.view.activityStopAnimating()
                }
            }
        }

        task.resume()
        
    }
    func getPatDetail(){
           DispatchQueue.main.async {
               self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
           }
      
        
        let urlStr = "\(ServiceUrl.getPatientDetailSavePrescription)?hosp_code=\(UserDefaults.standard.string(forKey: "udHospCode")!)&crNo=\(opdPatientDetails.patcrno)&visitNo=\(opdPatientDetails.visitNo)&episodeCode=\(opdPatientDetails.episodecode)"
           let url = URL(string: urlStr)

           print("getPatDetailList---\(urlStr)")
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               guard let data = data else { return }
               do{
           
                   let json = try JSON(data:data)
                   print("urjsonl--\(json)")
                   if json.count == 0
                   {
                       DispatchQueue.main.async {
                           self.showToast(message: "No Record found", font: .systemFont(ofSize: 12))
                           self.view.activityStopAnimating()
                       }
                   }
                   else{
                       self.status = json["status"].stringValue
                       self.Pat_details = json["Pat_details"].stringValue
                       self.customUnit = json["customUnit"].stringValue
                       self.designation = json["designation"].stringValue
                       self.fatherName = json["fatherName"].stringValue
                       self.umid_no = json["umid_no"].stringValue
                       self.catName = json["catName"].stringValue
                      
                       
//                       for arr in json.arrayValue{
//                       self.arrPatDetails.append(PatDetails(json: arr))
//                   }
                      
                   DispatchQueue.main.async {
                       self.view.activityStopAnimating()
                   }
                       
                   }
                   
               }catch{
                   print("Error "+error.localizedDescription)
               }
               }.resume()
       }
    func getSideCode(sideCode: String) -> (String) {
        var sideNo = ""
        if (sideCode == "Side") {
            sideNo = "0";
        } else if (sideCode == "NR") {
                   sideNo = "1";
        } else if (sideCode == "Left") {
                   sideNo = "2";
        } else if (sideCode == "Right") {
                   sideNo = "3";
        } else if (sideCode == "Bilateral") {
                   sideNo = "4";
        } else {
                   sideNo = "0";
        }
        return sideNo
    }
}
extension OPDLiteVController: UITextViewDelegate {
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}

