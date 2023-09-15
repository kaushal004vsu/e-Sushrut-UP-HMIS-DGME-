//
//  ScreeningDetails.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 16/09/22.
//

import Foundation
struct ScreeningDetails{
   
    

 var requestId:String = "";
 var crno:String = "";
 var scrResponse:String = "";
 var consName:String = "";
 var deptUnitCode:String = "";
 var deptUnitName:String = "";
 var requestStatus:String = "";
 var patMobileNo:String = "";
 var consMobileNo:String = "";
 var patDocs:String = "";
 var docMessage:String = "";
 var constId:String = "";
 var patName:String = "";
 var patAge:String = "";
 var patGender:String = "";
 var email:String = "";
 var remarks:String = "";
 var patWeight:String = "";
 var patHeight:String = "";
 var medications:String = "";
 var pastdiagnosis:String = "";
 var pastAllergies:String = "";
 var userId:String = "";
 var stateCode:String = "";
 var districtCode:String = "";

 var apptDeptUnit:String = "";
 var guardianName:String = "";
 var patientToken:String = "";
 var hospCode:String = "";
 var hospName:String = "";
 var OPDTimings:String = "";

init(){
}

     init(requestId: String = "", crno: String = "", scrResponse: String = "", consName: String = "", deptUnitCode: String = "", deptUnitName: String = "", requestStatus: String = "", patMobileNo: String = "", consMobileNo: String = "", patDocs: String = "", docMessage: String = "", constId: String = "", patName: String = "", patAge: String = "", patGender: String = "", email: String = "", remarks: String = "", patWeight: String = "", patHeight: String = "", medications: String = "", pastdiagnosis: String = "", pastAllergies: String = "", userId: String = "", stateCode: String = "", districtCode: String = "", apptDeptUnit: String = "", guardianName: String = "", patientToken: String = "", hospCode: String = "", hospName: String = "", OPDTimings: String = "") {
         
        self.requestId = requestId
        self.crno = crno
        self.scrResponse = scrResponse
        self.consName = consName
        self.deptUnitCode = deptUnitCode
        self.deptUnitName = deptUnitName
        self.requestStatus = requestStatus
        self.patMobileNo = patMobileNo
        self.consMobileNo = consMobileNo
        self.patDocs = patDocs
        self.docMessage = docMessage
        self.constId = constId
        self.patName = patName
        self.patAge = patAge
        self.patGender = patGender
        self.email = email
        self.remarks = remarks
        self.patWeight = patWeight
        self.patHeight = patHeight
        self.medications = medications
        self.pastdiagnosis = pastdiagnosis
        self.pastAllergies = pastAllergies
        self.userId = userId
        self.stateCode = stateCode
        self.districtCode = districtCode
        self.apptDeptUnit = apptDeptUnit
        self.guardianName = guardianName
        self.patientToken = patientToken
        self.hospCode = hospCode
        self.hospName = hospName
        self.OPDTimings = OPDTimings
    }
}
