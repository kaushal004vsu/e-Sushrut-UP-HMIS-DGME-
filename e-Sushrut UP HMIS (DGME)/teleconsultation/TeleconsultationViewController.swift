//
//  TelecunsultaionViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import iOSDropDown

class TeleconsultationViewController: UITableViewController,UIAlertViewDelegate,UITextFieldDelegate, URLSessionDelegate {
    var hospList=[HospListModel]()
    @IBOutlet var myTableview: UITableView!
    var arHospName = [String]();
    var arHospCode = [Int]();
    var hospCode:Int = 0
    var hospName:String = ""
    var from:Int = 0
//    var departmentArrayList = [DepartmentModel]()
    var arrData=[DepartmentModel]()
    var generalData=[DepartmentModel]()
    var specialData=[DepartmentModel]()
    var allData=[DepartmentModel]()
    
    var arDepartmentName = [String]();
    var arDepartmentCode = [Int]();
    var unitCode:Int=0
    var departName:String = ""
    var loCode:String = ""
    var loName:String = ""
    
    
    var patientDetails = PatientDetails()
    
   
    
    @IBOutlet weak var dropDownHosp: DropDown!
    @IBOutlet weak var dropDownDept: DropDown!
    
    @IBOutlet weak var hosp_textfield: UITextField!
    @IBOutlet weak var dept_textfield: UITextField!
    
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var heightInFtTextfield: UITextField!
    @IBOutlet weak var heightInInchTextfield: UITextField!
    @IBOutlet weak var symptomsLbl: UITextField!
    
   // --------------------------------------------------------
    @IBOutlet weak var covid_screening_param_tf: UITextField!
    @IBOutlet weak var symptomes_stack: UIStackView!
    
    @IBOutlet weak var fever: UIButton!
    @IBOutlet weak var cough: UIButton!
    @IBOutlet weak var sore_throat: UIButton!
    @IBOutlet weak var chest_congestion: UIButton!
    @IBOutlet weak var body_ache: UIButton!
    @IBOutlet weak var pink_eye: UIButton!
    @IBOutlet weak var small_taste: UIButton!
    @IBOutlet weak var hearing_impairment: UIButton!
    @IBOutlet weak var breathing_diffculty: UIButton!
    @IBOutlet weak var gasto_intestial: UIButton!
  // --------------------------------------------------------
    @IBOutlet weak var pre_existing_param_tf: UITextField!
    
    @IBOutlet weak var diabates: UIButton!
    @IBOutlet weak var hypertension: UIButton!
    @IBOutlet weak var lung_diseases: UIButton!
    @IBOutlet weak var heart_diseases: UIButton!
    @IBOutlet weak var kideny_disorder: UIButton!
    @IBOutlet weak var asthma: UIButton!
  // --------------------------------------------------------
   
    @IBOutlet weak var show_diagnosed_condition: UITextField!
    
    @IBOutlet weak var show_diagnosed_condition_iv: UIImageView!
    @IBOutlet weak var hide_diagnosed_condition_iv: UIImageView!
    @IBOutlet weak var diagnosed_condition_tf: UITextView!
    var placeholderLabel : UILabel!
  // --------------------------------------------------------
    @IBOutlet weak var show_medication_iv: UIImageView!
    @IBOutlet weak var hide_medication_iv: UIImageView!
    @IBOutlet weak var show_medication_tf: UITextView!
  // --------------------------------------------------------
    @IBOutlet weak var show_allergies_iv: UIImageView!
    @IBOutlet weak var hide_allergies_iv: UIImageView!
    @IBOutlet weak var allergies_tf: UITextView!
// --------------------------------------------------------
    @IBOutlet weak var problem_description_tf: UITextView!
    
    @IBOutlet weak var proceed_btn: UIButton!
    
    var weightPicker = UIPickerView()
    var heightInFtPicker = UIPickerView()
    var heightInInchPicker = UIPickerView()
    
    
      
    var arrWeight = [String]()
    var arrHeightInFt = [String]()
    var arrHeightInInch = [String]()

    var istvFeverSelected = false, istvCoughSelected = false, istvSoreThroatSelected = false, istvBreathingDifficultySelected = false;
    //, istvFreignTravelSelected = false;
    
    var istvCongestionSelected = false, istvBodyAcheSelected = false, istvPinkEyesSelected = false, istvSmellSelected = false, istvHearingImpairmentSelected = false,isTvGastro = false;

    var istvDiabetesSelected = false,istvHypertensionSelected = false,istvLungDiseaseSelected = false, istvHeartDiseaseSelected = false, istvKidneyDisorderSelected = false,isAsthmaSelected = false;

    
    var  responseHOF = " ", responseHOC = " ", responseHOS = " ", responseBD = " ";//, responseFT = " ";
    var  responsegastro = " ", responseHearingImpairment = " ", responseBodyAche = " ", responsePinkEyes = " ", responseCongestion = " ",
         responseSmell = " ";
    let placeholder1 = "Write diagnosed conditions"
    let placeholder2 = "Write medications"
    let placeholder3 = "Write allergies"
    let placeholder4 = "Problem Description(maximum 500 characters)"
    
    var defaultWeight = "65"

    override func viewDidLoad() {
      //  self.hospSelctedLbl.text = hospName
        
       // getDepartments(hospCode: String(self.hospCode))
        myTableview.delegate = self
        myTableview.dataSource = self
             
        self.showInternetAlert()
        hideKeyboardWhenTappedAround()
//        if let indexPosition = weightPicker.firstIndex(of: item){
//           pickerView.selectRow(indexPosition, inComponent: inComponent, animated: true)
//         }
       // weightPicker.selectRow(3, inComponent: 0, animated: true)

        
        diagnosed_condition_tf.delegate = self
        diagnosed_condition_tf.text = placeholder1
        diagnosed_condition_tf.textColor = UIColor.lightGray
        diagnosed_condition_tf.selectedTextRange = diagnosed_condition_tf.textRange(from: diagnosed_condition_tf.beginningOfDocument, to: diagnosed_condition_tf.beginningOfDocument)
        
        show_medication_tf.delegate = self
        show_medication_tf.text = placeholder2
        show_medication_tf.textColor = UIColor.lightGray
        show_medication_tf.selectedTextRange = show_medication_tf.textRange(from: show_medication_tf.beginningOfDocument, to: show_medication_tf.beginningOfDocument)

        allergies_tf.delegate = self
        allergies_tf.text = placeholder3
        allergies_tf.textColor = UIColor.lightGray
        allergies_tf.selectedTextRange = allergies_tf.textRange(from: allergies_tf.beginningOfDocument, to: allergies_tf.beginningOfDocument)
        
        problem_description_tf.delegate = self
        problem_description_tf.text = placeholder4
        problem_description_tf.textColor = UIColor.lightGray
        problem_description_tf.selectedTextRange = problem_description_tf.textRange(from: problem_description_tf.beginningOfDocument, to: problem_description_tf.beginningOfDocument)

        
        fever.tintColor = UIColor.systemBlue
        cough.tintColor = UIColor.systemBlue
        sore_throat.tintColor = UIColor.systemBlue
        chest_congestion.tintColor = UIColor.systemBlue
        body_ache.tintColor = UIColor.systemBlue
        pink_eye.tintColor = UIColor.systemBlue
        small_taste.tintColor = UIColor.systemBlue
        hearing_impairment.tintColor = UIColor.systemBlue
        breathing_diffculty.tintColor = UIColor.systemBlue
        gasto_intestial.tintColor = UIColor.systemBlue
        diabates.tintColor = UIColor.systemBlue
        hypertension.tintColor = UIColor.systemBlue
        lung_diseases.tintColor = UIColor.systemBlue
        heart_diseases.tintColor = UIColor.systemBlue
        kideny_disorder.tintColor = UIColor.systemBlue
        asthma.tintColor = UIColor.systemBlue
       
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        self.patientDetails=obj!
        dropDownHosp.arrowColor = .systemBlue
        dropDownHosp.selectedRowColor = .systemBlue
               dropDownHosp.listHeight = 300
               getHospital()
               dropDownHosp.didSelect { [self] selectedText, index, id in
                   print("\(selectedText) inside view did load  \(id)")
                   self.hospCode=id
                   let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
                   getDepartments(hospCode: String(self.hospCode))
                   self.hospName = selectedText
                   if(selectedText == ""){
                    
                   }
               }
        dropDownDept.arrowColor = .systemBlue
        dropDownDept.selectedRowColor = .systemBlue
            dropDownDept.listHeight = 300
            dropDownDept.didSelect { [self] selectedText, index, id in
                print("\(selectedText) inside view did load  \(id)")
                self.unitCode=id
                self.departName = selectedText
                
                self.loCode = allData[index].loCode
                self.loName = allData[index].loName
                print("selected_text"+hosp_textfield.text!)
               
                if(selectedText == ""){
                }
               
               }
//        dept_textfield.delegate = self
//        let textViewRecognizer = UITapGestureRecognizer()
//        textViewRecognizer.addTarget(self, action: #selector(tappedTextView(_:)))
//        dept_textfield.addGestureRecognizer(textViewRecognizer)
        
        self.weightTextfield.delegate = self
        self.heightInFtTextfield.delegate = self
        self.heightInInchTextfield.delegate = self
        
        weightTextfield.setupRightImage(imageName: "arrow_down")
        heightInFtTextfield.setupRightImage(imageName: "arrow_down")
        heightInInchTextfield.setupRightImage(imageName: "arrow_down")
        
        symptomsLbl.setupRightImage(imageName: "arrow_down")
        
        weightTextfield.inputView = weightPicker
        heightInFtTextfield.inputView = heightInFtPicker
        heightInInchTextfield.inputView = heightInInchPicker
        
        weightPicker.delegate = self
        weightPicker.dataSource = self
        heightInFtPicker.delegate = self
        heightInFtPicker.dataSource = self
        heightInInchPicker.delegate = self
        heightInInchPicker.dataSource = self
        
        weightPicker.tag = 1
        heightInFtPicker.tag = 2
        heightInInchPicker.tag = 3
        
        weightTextfield.placeholder = "Weight in Kg"
        heightInFtTextfield.placeholder = "Height in Ft"
        heightInInchTextfield.placeholder = "Inch"
        
        
        super.viewDidLoad()
        for i in 1...200 {
            arrWeight.append("\(i)")
        }
        for i in 1...9 {
            arrHeightInFt.append("\(i)")
        }
        for i in 0...11 {
            arrHeightInInch.append("\(i)")
        }
        self.weightPicker.selectRow(64, inComponent: 0, animated: true)
        self.heightInFtPicker.selectRow(4, inComponent: 0, animated: true)
        self.heightInInchPicker.selectRow(5, inComponent: 0, animated: false)
        
  
        hide_diagnosed_condition_iv.tintColor = .red
        hide_medication_iv.tintColor = .red
        hide_allergies_iv.tintColor = .red
        
        diagnosed_condition_tf.isHidden = true
        show_medication_tf.isHidden = true
        allergies_tf.isHidden = true
        
        let show_diagnosedTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(show_diagnosed_imageTapped(tapGestureRecognizer:)))
        show_diagnosed_condition_iv.isUserInteractionEnabled = true
        show_diagnosed_condition_iv.addGestureRecognizer(show_diagnosedTapGestureRecognizer)
        
        let hide_diagnosedTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hide_diagnosed_imageTapped(tapGestureRecognizer:)))
        hide_diagnosed_condition_iv.isUserInteractionEnabled = true
        hide_diagnosed_condition_iv.addGestureRecognizer(hide_diagnosedTapGestureRecognizer)
        
        let showMedicationTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMedication_imageTapped(tapGestureRecognizer:)))
        show_medication_iv.isUserInteractionEnabled = true
        show_medication_iv.addGestureRecognizer(showMedicationTapGestureRecognizer)
        
        let hideMedicationTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideMedication_imageTapped(tapGestureRecognizer:)))
        hide_medication_iv.isUserInteractionEnabled = true
        hide_medication_iv.addGestureRecognizer(hideMedicationTapGestureRecognizer)
        
        let showAllergyTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAllergy_imageTapped(tapGestureRecognizer:)))
        show_allergies_iv.isUserInteractionEnabled = true
        show_allergies_iv.addGestureRecognizer(showAllergyTapGestureRecognizer)
        
        let hideAllergyTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideAllergy_imageTapped(tapGestureRecognizer:)))
        hide_allergies_iv.isUserInteractionEnabled = true
        hide_allergies_iv.addGestureRecognizer(hideAllergyTapGestureRecognizer)
      

       // myTableview.isScrollEnabled = false;
        self.myTableview.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
        self.myTableview.contentOffset = CGPointMake(0, -20);
    }
   
//    @objc  func tappedTextView(_ sender: UITapGestureRecognizer) {
//            print("detected tap!")
//        if(hosp_textfield.text!.count == 0){
//                       showAlert(message: "Please select Hospital.")
//                       dropDownHosp.becomeFirstResponder()
//                       return
//               }
//    }
    
    @objc func show_diagnosed_imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(tappedImage.tintColor == .red) {
            diagnosed_condition_tf.isHidden = true
            hide_diagnosed_condition_iv.tintColor = .red
            show_diagnosed_condition_iv.tintColor = .lightGray
            
        }else{
            diagnosed_condition_tf.isHidden = false
            hide_diagnosed_condition_iv.tintColor = .lightGray
            show_diagnosed_condition_iv.tintColor = .systemGreen

        }
        
    }
    @objc func hide_diagnosed_imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if(tappedImage.tintColor == .red) {
            diagnosed_condition_tf.isHidden = true
            hide_diagnosed_condition_iv.tintColor = .red
            show_diagnosed_condition_iv.tintColor = .lightGray
        }else if(tappedImage.tintColor == .lightGray) {
            diagnosed_condition_tf.isHidden = true
            hide_diagnosed_condition_iv.tintColor = .red
            show_diagnosed_condition_iv.tintColor = .lightGray
        } else{
            diagnosed_condition_tf.isHidden = false
            hide_diagnosed_condition_iv.tintColor = .lightGray
            show_diagnosed_condition_iv.tintColor = .systemGreen
        }    }
    
    @objc func showMedication_imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(tappedImage.tintColor == .red) {
            show_medication_tf.isHidden = true
            hide_medication_iv.tintColor = .red
            show_medication_iv.tintColor = .lightGray
        }else{
            show_medication_tf.isHidden = false
            hide_medication_iv.tintColor = .lightGray
            show_medication_iv.tintColor = .systemGreen
        }
        
    }
    @objc func hideMedication_imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if(tappedImage.tintColor == .red) {
            show_medication_tf.isHidden = true
            hide_medication_iv.tintColor = .red
            show_medication_iv.tintColor = .lightGray
        }else if(tappedImage.tintColor == .lightGray) {
            show_medication_tf.isHidden = true
            hide_medication_iv.tintColor = .red
            show_medication_iv.tintColor = .lightGray
        } else{
            show_medication_tf.isHidden = false
            hide_medication_iv.tintColor = .lightGray
            show_medication_iv.tintColor = .systemGreen
        }    }

    @objc func showAllergy_imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(tappedImage.tintColor == .red) {
            allergies_tf.isHidden = true
            hide_allergies_iv.tintColor = .red
            show_allergies_iv.tintColor = .lightGray
        }else{
            allergies_tf.isHidden = false
            hide_allergies_iv.tintColor = .lightGray
            show_allergies_iv.tintColor = .systemGreen
        }
        
    }
    @objc func hideAllergy_imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if(tappedImage.tintColor == .red) {
            allergies_tf.isHidden = true
            hide_allergies_iv.tintColor = .red
            show_allergies_iv.tintColor = .lightGray
        }else if(tappedImage.tintColor == .lightGray) {
            allergies_tf.isHidden = true
            hide_allergies_iv.tintColor = .red
            show_allergies_iv.tintColor = .lightGray
        } else{
            allergies_tf.isHidden = false
            hide_allergies_iv.tintColor = .lightGray
            show_allergies_iv.tintColor = .systemGreen
        }    }
  

    @IBAction func symtomParamAction(_ sender: Any) {
        symptomes_stack.isHidden = true
    }
    @IBAction func fevar(_ sender: Any) {
        sympotmsSelection(view: fever)
       if (istvFeverSelected) {
           istvFeverSelected = false
           responseHOF = "N"
        }else{
            istvFeverSelected = true
            responseHOF = "Y"
        }
        
    }
    
    @IBAction func coughAction(_ sender: Any) {
        sympotmsSelection(view: cough)
        if(istvCoughSelected){
            istvCoughSelected = false
            responseHOC = "N"
        }else{
            istvCoughSelected = true
            responseHOC = "Y"
        }

    }
    
    @IBAction func soreThroatAction(_ sender: Any) {
        sympotmsSelection(view: sore_throat)
        if(istvSoreThroatSelected){
            istvSoreThroatSelected = false
            responseHOS = "N"
        }else {
            istvSoreThroatSelected = true
            responseHOS = "Y"
        }

    }
    @IBAction func chestCongestionAction(_ sender: Any) {
        sympotmsSelection(view: chest_congestion)
        if(istvCongestionSelected){
            istvCongestionSelected = false
            responseCongestion = "N"
        }else{
            istvCongestionSelected = true
            responseCongestion = "Y"
        }

    }
    @IBAction func bodyAcheAction(_ sender: Any) {
        sympotmsSelection(view: body_ache)
        if(istvBodyAcheSelected){
            istvBodyAcheSelected = false
            responseBodyAche = "N"
        }else{
            istvBodyAcheSelected = true
            responseBodyAche = "Y"
        }
    }
    @IBAction func pinkEyeAction(_ sender: Any) {
        sympotmsSelection(view: pink_eye)
        if(istvPinkEyesSelected){
            istvPinkEyesSelected = false
            responsePinkEyes = "N"
            }else {
            istvPinkEyesSelected = true
            responsePinkEyes = "Y"
        }

    }
    @IBAction func smellTasteAction(_ sender: Any) {
        sympotmsSelection(view: small_taste)
        if(istvSmellSelected){
            istvSmellSelected = false
            responseSmell = "N"
        }else {
            istvSmellSelected = true
            responseSmell = "Y"
        }
    }
    @IBAction func hearingAction(_ sender: Any) {
        sympotmsSelection(view: hearing_impairment)
       
        if(istvHearingImpairmentSelected){
            istvHearingImpairmentSelected = false
            responseHearingImpairment = "N"
        }else {
            istvHearingImpairmentSelected = true
            responseHearingImpairment = "Y"
        }

    }
    @IBAction func breathingAction(_ sender: Any) {
        sympotmsSelection(view: breathing_diffculty)
        if(istvBreathingDifficultySelected){
            istvBreathingDifficultySelected = false
            responseBD = "N"
        }else {
            istvBreathingDifficultySelected = true
            responseBD = "Y"
        }

    }
    @IBAction func gastorialAction(_ sender: Any) {
        sympotmsSelection(view: gasto_intestial)
        if(isTvGastro){
            isTvGastro = false
            responsegastro = "N"
        }else {
            isTvGastro = true
            responsegastro = "Y"
   }

    }
    
    @IBAction func diabetesAction(_ sender: Any) {
        sympotmsSelection(view: diabates)
        if(istvDiabetesSelected){
            istvDiabetesSelected = false}
        else{
            istvDiabetesSelected = true
        }
    }
    @IBAction func hypertensionAction(_ sender: Any) {
        sympotmsSelection(view: hypertension)
        if(istvHypertensionSelected){
            istvHypertensionSelected = false
        }else{
            istvHypertensionSelected = true
        }

    }
    @IBAction func lungDisecesAction(_ sender: Any) {
        sympotmsSelection(view: lung_diseases)
        if(istvLungDiseaseSelected){
            istvLungDiseaseSelected = false
        }else{
            istvLungDiseaseSelected = true
        }

    }
    @IBAction func heartDiescesAction(_ sender: Any) {
        sympotmsSelection(view: heart_diseases)
        if(istvHeartDiseaseSelected){
            istvHeartDiseaseSelected = false
        }else{
            istvHeartDiseaseSelected = true
        }

    }
    @IBAction func kidenyDisorderAction(_ sender: Any) {
        sympotmsSelection(view: kideny_disorder)
        if(istvKidneyDisorderSelected){
            istvKidneyDisorderSelected = false
        }else{
            istvKidneyDisorderSelected = true
        }

    }
    @IBAction func asthmaAction(_ sender: Any) {
        sympotmsSelection(view: asthma)
        if(isAsthmaSelected){
            isAsthmaSelected = false
        }else{
            isAsthmaSelected = true
        }

    }
    
    
    @IBAction func proceedBtnAction(_ sender: Any) {
        let txtWeight=weightTextfield.text!
        let heightInFeet=heightInFtTextfield.text!
        let heightInInch=heightInInchTextfield.text!

        if(heightInFeet.count > 0){
            if(heightInInch.count > 0){
                   
            }else{
                showAlert(message: "Please Enter Height in Inch.")
                heightInInchTextfield.becomeFirstResponder()
                return
            }
        }
        
        if(hosp_textfield.text!.count == 0){
                       showAlert(message: "Please select Hospital.")
                       dropDownHosp.becomeFirstResponder()
                       return
               }
        if(dept_textfield.text!.count == 0){
                showAlert(message: "Please select Department.")
                dropDownDept.becomeFirstResponder()
                return
        }
    
        var preExistingSymptoms="";
        
        preExistingSymptoms = (istvDiabetesSelected && !preExistingSymptoms.contains("Diabetes")) ? preExistingSymptoms+" Diabetes,":preExistingSymptoms.replacingOccurrences(of: "Diabetes,", with: "");
        
        preExistingSymptoms = (istvHypertensionSelected && !preExistingSymptoms.contains("Hypertension")) ? preExistingSymptoms+" Hypertension,":preExistingSymptoms.replacingOccurrences(of: "Hypertension,",with: "");
        
        preExistingSymptoms = (istvLungDiseaseSelected && !preExistingSymptoms.contains("Lung Disease")) ? preExistingSymptoms+" Lung Disease,":preExistingSymptoms.replacingOccurrences(of: "Lung Disease,",with: "");
        
        preExistingSymptoms = (istvHeartDiseaseSelected && !preExistingSymptoms.contains("Heart Disease")) ? preExistingSymptoms+" Heart Disease,":preExistingSymptoms.replacingOccurrences(of: "Heart Disease,",with: "");
        
        preExistingSymptoms = (istvKidneyDisorderSelected && !preExistingSymptoms.contains("Kidney Disorder")) ? preExistingSymptoms+" Kidney Disorder,":preExistingSymptoms.replacingOccurrences(of: "Kidney Disorder,",with: "");
        
        preExistingSymptoms = (isAsthmaSelected && !preExistingSymptoms.contains("Asthma")) ? preExistingSymptoms+" Asthma":preExistingSymptoms.replacingOccurrences(of: "Asthma",with: "");
        
        preExistingSymptoms = (diagnosed_condition_tf.text!.count < 0) ? preExistingSymptoms : preExistingSymptoms + ", " + (diagnosed_condition_tf.text)!;
        
        print("preExistingSymptoms \(preExistingSymptoms)  ")
        
        let scrResponse = responseHOF + responseHOC + responseHOS + responseBD + responseCongestion+responseBodyAche+responsePinkEyes+responseSmell+responseHearingImpairment+responsegastro;
        
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        var guardianName = ""
        if (obj!.fatherName.count > 0){
            guardianName = obj!.fatherName
        }else if (obj!.motherName.count > 0){
            guardianName = obj!.motherName
        }else{
            guardianName = obj!.spouseName
        }
        print("guarjian \(guardianName)  ")
            let problem_description=problem_description_tf.text!
        print("problem_description \(problem_description.count) ")
        if(problem_description.count == 0) || problem_description == "Problem Description(maximum 500 characters)"{
                showAlert(message: "Please enter problem description.")
                problem_description_tf.becomeFirstResponder()
            }else{
                var arrScreeningDeatails =  ScreeningDetails.init(requestId: "", crno: obj!.crno, scrResponse: scrResponse, consName: "", deptUnitCode: String(unitCode), deptUnitName: departName, requestStatus: "0", patMobileNo: obj!.mobileNo, consMobileNo: "", patDocs: "", docMessage: "", constId: "", patName: obj!.firstName, patAge: obj!.age, patGender: obj!.gender, email: obj!.email, remarks: problem_description_tf.text!, patWeight: weightTextfield.text!, patHeight: "\(heightInFtTextfield.text!)\(heightInInchTextfield.text!)", medications: show_medication_tf.text!, pastdiagnosis: preExistingSymptoms, pastAllergies: allergies_tf.text!, userId: "0", stateCode: obj!.stateId, districtCode: obj!.districtId, apptDeptUnit: "\(self.unitCode)@\(self.loCode)@\(self.loName)", guardianName: guardianName, patientToken: "token", hospCode: String(hospCode), hospName: hospName, OPDTimings: "<b> <font color='#122d4a'>Teleconsultancy Timings :</font></b> Ispat General Hospital<br><br> Monday to Friday - 8:30 AM To 5:00 PM <br> Saturday - 08:30 AM To 12:00 PM")
                
                print("gendereee \(obj!.age) \(obj!.gender)")
                
                let viewController = (UIStoryboard.init(name: "teleconsultation", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlotSelectionViewController") as? SlotSelectionViewController)!
                viewController.screeningDeatails=arrScreeningDeatails
                viewController.deptname = self.dropDownDept.text!
                
                self.navigationController!.pushViewController( viewController, animated: true)
              //  self.navigationController!.show(viewController, sender: self)
            }
          
     
       
    }
    
    func sympotmsSelection(view:UIButton){
        view.layer.cornerRadius = 8
        view.isSelected = !view.isSelected;

        if (view.isSelected) {
            view.tintColor = UIColor.red
        } else {
            view.tintColor = UIColor.systemBlue
        }
        
    }
    
    func getHospital(){
           DispatchQueue.main.async {
               self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
           }
           let url2 = ServiceUrl.teleconsultancyHospitalList

           let url = URL(string: url2)

           print("url "+url2)
           URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
               guard let data = data else { return }
               do{
                   var json = try JSON(data:data)
                   if json.count == 0{
                       DispatchQueue.main.async {
                           self.view.activityStopAnimating()
                       }
                   }
                   else{
                   for arr in json.arrayValue{
                       self.hospList.append(HospListModel(json: arr))
                   }
                       for i in 0 ..< self.hospList.count {
                           self.arHospName.append(self.hospList[i].hospName)
                           self.arHospCode.append(Int(self.hospList[i].hospCode)!)
                       }
                       dropDownHosp.optionArray = self.arHospName
                       dropDownHosp.optionIds = self.arHospCode
                       
                   }
                   DispatchQueue.main.async {
                       self.view.activityStopAnimating()
                   }
                   
               }catch{
                   print("error"+error.localizedDescription)
               }
               }.resume()
     
       }
    func getDepartments(hospCode:String){
        self.allData.removeAll()
           print("getDepartments called.."+ServiceUrl.teleconsultationsDepartments+hospCode)
           DispatchQueue.main.async {
               self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
           }
           let url = URL(string: ServiceUrl.teleconsultationsDepartments+hospCode)
        print("department url \(ServiceUrl.teleconsultationsDepartments+hospCode)")
           let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
   
           URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
               guard let data = data else { return }
               do{
                   let json = try JSON(data:data)
                   let status=json["status"].stringValue
                   let arrData=json["dept_list"].array

                   print("getDepartments called.. \(json)-\(status)")
                   if status == "0"
                   {
                       DispatchQueue.main.async {
                           self.view.activityStopAnimating()
                           self.arDepartmentName.removeAll()
                           self.arDepartmentCode.removeAll()
                           self.showAlert(message: "THIS HOSPITAL DOES NOT PROVIDE TELE-CONSULTATION FACILITY. PLEASE CONTACT HOSPITAL ADMINISTRATION")
                           self.dropDownDept.text! = ""
                           self.dropDownDept.isUserInteractionEnabled = false
                           self.dropDownDept.optionArray = self.arDepartmentName
                           self.dropDownDept.optionIds = self.arDepartmentCode
                          
                       }
                   
                   
                   }else{
                       self.dropDownDept.isUserInteractionEnabled = true
                       self.generalData = self.arrData
                       let jsonn = JSON(arrData!)
                        for arr in jsonn.arrayValue{
                        self.allData.append(DepartmentModel(json: arr))
                            }
                       for i in 0 ..< arrData!.count {
                          self.arDepartmentName.append(self.allData[i].deptname)
                          self.arDepartmentCode.append(Int(self.allData[i].unitcode)!)
                      }
                      dropDownDept.optionArray = self.arDepartmentName
                      dropDownDept.optionIds = self.arDepartmentCode
                      DispatchQueue.main.async {
                          self.view.activityStopAnimating()
      
                      }
                   }
 
               }catch{
   
                   DispatchQueue.main.async {
                       self.view.activityStopAnimating()
                   }
   
                   print(error.localizedDescription)
               }
               }.resume()
       }
   

}
extension TeleconsultationViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return arrWeight.count
        case 2:
            return arrHeightInFt.count
        case 3:
            return arrHeightInInch.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return arrWeight[row]
        case 2:
            return arrHeightInFt[row]
        case 3:
            return arrHeightInInch[row]
        default:
            return "Data not found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(arrWeight[row]+" (Kg)")
        switch pickerView.tag {
        case 1:
            weightTextfield.text = arrWeight[row]+" (Kg)"
            weightTextfield.resignFirstResponder()
        case 2:
            heightInFtTextfield.text = arrHeightInFt[row]+"'"
            heightInFtTextfield.resignFirstResponder()
        case 3:
            heightInInchTextfield.text = arrHeightInInch[row]+"''"
            heightInInchTextfield.resignFirstResponder()
        default:
            return
        }
        
    }
    private func showAlert(message:String)  {
        DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Info!", message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
   
}
extension TeleconsultationViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: NSString = textView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        
        if updatedText.isEmpty {
            textView.text = placeholder1
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
         
            diagnosed_condition_tf.delegate = self
            show_medication_tf.delegate = self
            allergies_tf.delegate = self
            problem_description_tf.delegate = self
            if textView == self.diagnosed_condition_tf
            {
                self.diagnosed_condition_tf.text = placeholder1
                textView.textColor = UIColor.lightGray
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }else if textView == self.show_medication_tf{
                self.show_medication_tf.text = placeholder2
                textView.textColor = UIColor.lightGray
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }else if textView == self.allergies_tf{
                self.allergies_tf.text = placeholder3
                textView.textColor = UIColor.lightGray
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }else if textView == self.problem_description_tf{
                self.problem_description_tf.text = placeholder4
                textView.textColor = UIColor.lightGray
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
           
            return false
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}
