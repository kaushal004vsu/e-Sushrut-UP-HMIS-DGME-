//
//  PatientDetails.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 06/06/22.
//

import Foundation
struct PatientDetails:Codable,Equatable
{
    var umidNo:String=""
      var isSailEmployee:String=""
    
      var mobileNo: String = ""
      var crno: String = ""
      var firstName: String = ""
      var middleName:String=""
      var lastName: String = ""
      var age: String = ""
      var dob: String = ""
      var gender: String = ""
      var fatherName: String = ""
      var motherName: String = ""
      var spouseName: String = ""
      var stateId: String = ""
      var districtId: String = ""
      var hospCode:String=""
      var patientCatCode:String=""
      var city:String=""
      var pincode:String=""
      var email: String = ""
      var healthId:String=""
      var patHealthId:String=""
    
    
    var sublocality:String=""
         var districtName:String=""
         var state:String=""
    
      var umidData:UmidData = UmidData()
    
    
    init(){
        
    }
    init(json:JSON){
        umidNo=json["UMID_NO"].stringValue
         isSailEmployee=json["IS_SAIL_EMPLOYEE"].stringValue
         mobileNo=json["MOBILE_NO"].stringValue
         crno=json["CRNO"].stringValue
         firstName=json["FIRSTNAME"].stringValue
         middleName=json["MIDDLE_NAME"].stringValue
         lastName=json["LAST_NAME"].stringValue
        age=json["AGE"].stringValue
         dob=json["DOB"].stringValue
         gender=json["GENDER"].stringValue
         fatherName=json["FATHERNAME"].stringValue
         motherName=json["MOTHER_NAME"].stringValue
         spouseName=json["SPOUSE_NAME"].stringValue
         stateId=json["STATE_CODE"].stringValue
         districtId=json["DISTRICT_CODE"].stringValue
         hospCode=json["HOSPITAL_CODE"].stringValue
         patientCatCode=json["PATIENT_CAT_CODE"].stringValue
         city=json["CITY"].stringValue
         pincode=json["PINCODE"].stringValue
         email=json["EMAIL_ID"].stringValue
         healthId=json["HEALTH_ID"].stringValue
         patHealthId=json["PAT_HEALTH_ID"].stringValue
        //umidData=json["UMID_DATA"].object as! UmidData
        
        sublocality=json["SUBLOCALITY"].stringValue
                 districtName=json["DISTRICT_NAME"].stringValue
                 state=json["STATE_NAME"].stringValue
        
        print("umid"+json["UMID_DATA"].stringValue)
        
        umidData=UmidData(json: JSON.init(parseJSON:json["UMID_DATA"].stringValue))
}
}
