//
//  PatientRequestDetails.swift
//  AIIMS Bhubaneswar Swasthya
//
//  Created by sudeep rai on 06/08/20.
//  Copyright © 2020 sudeep rai. All rights reserved.
//

import Foundation
struct PatientRequestDetails:Codable
{
    var requestID: String = ""
    var CRNo: String = ""
    var scrResponse: String = ""
    var consName: String = ""
    var deptUnitCode: String = ""
     var deptUnitName: String = ""
     var hospCode: String = ""
     var requestStatus: String = ""
     var patMobileNo: String = ""
     var consMobileNo: String = ""
     var patDocs: String = ""
     var docMessage: String = ""
     var cnsltntId: String = ""
     var patName: String = ""
     var patAge: String = ""
     var patGender: String = ""
     var rmrks: String = ""
     var email: String = ""
     var date: String = ""
     var patWeight: String = ""
     var patHeight: String = ""
     var patMedication: String = ""
     var patPastDiagnosis: String = ""
     var patAllergies: String = ""
     var departmentName: String = ""
     var deptCode: String = ""
    var isDocUploaded: String = ""
     var doctorToken: String = ""
     var patientToken: String = ""
     var appointmentNo: String = ""
     var apptStartTime: String = ""
     var apptEndTime: String = ""
     var apptDate: String = ""
     var hospitalName: String = ""
     var isEpisodeExist: String = ""
     var episodeCode: String = ""
     var episodeVisitNo: String = ""
     var requestStatusCompleteDate: String = ""
     var requestStatusCompleteMode: String = ""
    
    
    var patientCategory:String=""
    var pVisitdate:String=""
    var patVisitNo:String=""
    var roomId:String=""
    var hcode:String=""
    var departmentId:String=""
    
    
    init(){
        
    }
    
    
    
    init(json:JSON){

          requestID = json["requestID"].stringValue
             CRNo = json["CRNo"].stringValue
             scrResponse = json["scrResponse"].stringValue
             consName = json["consName"].stringValue
             deptUnitCode = json["deptUnitCode"].stringValue
              deptUnitName = json["deptUnitName"].stringValue
              hospCode = json["hospCode"].stringValue
              requestStatus = json["requestStatus"].stringValue
              patMobileNo = json["patMobileNo"].stringValue
              consMobileNo = json["consMobileNo"].stringValue
              patDocs = json["patDocs"].stringValue
              docMessage = json["docMessage"].stringValue
              cnsltntId = json["cnsltntId"].stringValue
              patName = json["patName"].stringValue
              patAge = json["patAge"].stringValue
              patGender = json["patGender"].stringValue
              rmrks = json["rmrks"].stringValue
              email = json["email"].stringValue
              date = json["date"].stringValue
              patWeight = json["patWeight"].stringValue
              patHeight = json["patHeight"].stringValue
              patMedication = json["patMedication"].stringValue
              patPastDiagnosis = json["patPastDiagnosis"].stringValue
              patAllergies = json["patAllergies"].stringValue
              departmentName = json["deptName"].stringValue
              deptCode = json["deptCode"].stringValue
             isDocUploaded = json["isDocUploaded"].stringValue
              doctorToken = json["doctorToken"].stringValue
              patientToken = json["patientToken"].stringValue
              appointmentNo = json["appointmentNo"].stringValue
              apptStartTime = json["apptStartTime"].stringValue
              apptEndTime = json["apptEndTime"].stringValue
              apptDate = json["apptDate"].stringValue
              hospitalName = json["hospitalName"].stringValue
              isEpisodeExist = json["isEpisodeExist"].stringValue
              episodeCode = json["episodeCode"].stringValue
              episodeVisitNo = json["episodeVisitNo"].stringValue
              requestStatusCompleteDate = json["requestStatusCompleteDate"].stringValue
              requestStatusCompleteMode = json["requestStatusCompleteMode"].stringValue
        
        
        
        self.departmentId = json["deptCode"].stringValue;
        self.patientCategory = "General";
        self.pVisitdate = date;
        self.hcode = json["hospCode"].stringValue;
        self.patVisitNo = "1";
        self.roomId = "0";
    }
}
