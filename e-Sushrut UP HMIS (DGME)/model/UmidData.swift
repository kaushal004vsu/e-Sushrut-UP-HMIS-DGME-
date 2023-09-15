//
//  UmidData.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 07/06/22.
//

import Foundation
struct UmidData:Codable,Equatable{
    var pchId:String=""
    var beneficiaryuuid: String = ""
    var umidNo:String=""
    var name: String = ""
    var relation:String=""
    var gender: String = ""
    var dob:String=""
    var maritalStatus: String = ""
    var residentialAddress:String=""
    var city: String = ""
    var pincode:String=""
    var healthUnitOpted: String = ""
    var mobileNo:String=""
    var emailId: String = ""
    var validity:String=""
    var jobType: String = ""
    var currentStatus: String = ""
    var middleName: String = ""
    var lastName: String = ""
    var age: String = ""
    var bloodGroup: String = ""
    var profilePic: String = ""
    var aadhaarNo: String = ""
    var panNo: String = ""
    var fatherName: String = ""
    var spouseName: String = ""
    var street: String = ""
    var landmark: String = ""
    var location: String = ""
    var district: String = ""
    var stateName: String = ""
    var countryName: String = ""
    var handicapStatus: String = ""
    var levelOfEntitlement: String = ""
    var department: String = ""
    var designation: String = ""
    var opdEligibility: String = ""
    var ipdEligibility: String = ""
    var beneficiaryType: String = ""
    var customUnit: String = ""
    var customunitCode: String = ""
    var customZone: String = ""
    var customZoneCode: String = ""
    var cardStatus: String = ""
    var cardInactiveRemarks: String = ""
    var umidRemarks: String = ""
    var idCardValidityStatusFlag: String = ""
    var patientCategory: String = ""

    
    init(){
        
    }
    init(json:JSON){
  
        pchId=json["pch_id"].stringValue
        beneficiaryuuid=json["beneficiary_uuid"].stringValue
        umidNo=json["umid_no"].stringValue
        name=json["name"].stringValue
        relation=json["relation"].stringValue
        gender=json["gender"].stringValue
        dob=json["dob"].stringValue
        maritalStatus=json["marital_status"].stringValue
        residentialAddress=json["residential_address"].stringValue
        city=json["city"].stringValue
        pincode=json["pincode"].stringValue
        healthUnitOpted=json["health_unit_opted"].stringValue
        mobileNo=json["mobile_no"].stringValue
        emailId=json["email_id"].stringValue
        validity=json["validity"].stringValue
        jobType=json["job_type"].stringValue
        currentStatus=json["current_status"].stringValue
        middleName=json["middle_name"].stringValue
        lastName=json["last_name"].stringValue
        age=json["age"].stringValue
        bloodGroup=json["blood_group"].stringValue
        profilePic=json["profile_pic"].stringValue
        aadhaarNo=json["aadhaar_no"].stringValue
        panNo=json["pan_no"].stringValue
        fatherName=json["father_name"].stringValue
        spouseName=json["spouse_name"].stringValue
        street=json["street"].stringValue
        landmark=json["landmark"].stringValue
        location=json["location"].stringValue
        district=json["district"].stringValue
        stateName=json["state_name"].stringValue
        countryName=json["country_name"].stringValue
        handicapStatus=json["handicap_status"].stringValue
        levelOfEntitlement=json["level_of_entitilment"].stringValue
        department=json["department"].stringValue
        designation=json["designation"].stringValue
        opdEligibility=json["opd_eligibility"].stringValue
        ipdEligibility=json["ipd_eligibility"].stringValue
        beneficiaryType=json["beneficiary_type"].stringValue
        customUnit=json["custom_unit"].stringValue
        customunitCode=json["custom_unit_code"].stringValue
        customZone=json["custom_zone"].stringValue
        customZoneCode=json["custom_zone_code"].stringValue
        cardStatus=json["card_status"].stringValue
        cardInactiveRemarks=json["card_inactive_remarks"].stringValue
        umidRemarks=json["umid_remarks"].stringValue
        idCardValidityStatusFlag=json["id_card_validity_status_flag"].stringValue
        patientCategory=json["patient_category"].stringValue
        
        
        
}
    
}
