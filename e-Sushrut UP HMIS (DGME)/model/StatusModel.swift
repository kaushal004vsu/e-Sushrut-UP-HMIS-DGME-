//
//  StatusModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 30/09/22.
//

import Foundation
struct StatusModel{
    var requestID : String = ""
    var crNo: String = ""
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
    var deptName: String = ""
    var deptCode: String = ""
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

//optional String handle karna hoga
    var patientToken: String = ""
    var doctorToken: String = ""
    var consultationTime: String = ""
   
    init(){
        
    }
    init(json:JSON){
        
        self.requestID = json["requestID"].stringValue
        self.crNo = json["CRNo"].stringValue
        self.scrResponse = json["scrResponse"].stringValue
        self.consName = json["consName"].stringValue
        self.deptUnitCode = json["deptUnitCode"].stringValue
        self.deptUnitName = json["deptUnitName"].stringValue
        self.hospCode = json["hospCode"].stringValue
        self.requestStatus = json["requestStatus"].stringValue
        self.patMobileNo = json["patMobileNo"].stringValue
        self.consMobileNo = json["consMobileNo"].stringValue
        self.patDocs = json["patDocs"].stringValue
        self.docMessage = json["docMessage"].stringValue
        self.cnsltntId = json["cnsltntId"].stringValue
        self.patName = json["patName"].stringValue
        self.patAge = json["patAge"].stringValue
        self.patGender = json["patGender"].stringValue
        self.rmrks = json["rmrks"].stringValue
        self.email = json["email"].stringValue
        self.date = json["date"].stringValue
        self.patWeight = json["patWeight"].stringValue
        self.patHeight = json["patHeight"].stringValue
        self.patMedication = json["patMedication"].stringValue
        self.patPastDiagnosis = json["patPastDiagnosis"].stringValue
        self.patAllergies = json["patAllergies"].stringValue
        self.deptName = json["deptName"].stringValue
        self.deptCode = json["deptCode"].stringValue
        self.appointmentNo = json["appointmentNo"].stringValue
        self.apptStartTime = json["apptStartTime"].stringValue
        self.apptEndTime = json["apptEndTime"].stringValue
        self.apptDate = json["apptDate"].stringValue
        self.hospitalName = json["hospitalName"].stringValue
        self.isEpisodeExist = json["isEpisodeExist"].stringValue
        self.episodeCode = json["episodeCode"].stringValue
        self.episodeVisitNo = json["episodeVisitNo"].stringValue
        self.requestStatusCompleteDate = json["requestStatusCompleteDate"].stringValue
        self.requestStatusCompleteMode = json["requestStatusCompleteMode"].stringValue


                                                       
    //optional String handle karna hoga
        self.patientToken = json["patientToken"].stringValue
        self.doctorToken = json["doctorToken"].stringValue
        self.consultationTime = json["consultationTime"].stringValue
        
        
        
        
      
        
      
    }

}
