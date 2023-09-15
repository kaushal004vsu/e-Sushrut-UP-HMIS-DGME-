//
//  PastModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 30/09/22.
//

import Foundation
struct PastModel{

    var  requestID: String = ""
    var  CRNo: String = ""
    var  scrResponse: String = ""
    var  consName: String = ""
    var  deptUnitCode: String = ""
    var  deptUnitName: String = ""
    var  hospCode: String = ""
    var  requestStatus: String = ""
    var  patMobileNo: String = ""
    var  consMobileNo: String = ""
    var  patDocs: String = ""
    var  docMessage: String = ""
    var  cnsltntId: String = ""
    var  patName: String = ""
    var  patAge: String = ""
    var  patGender: String = ""
    var  rmrks: String = ""
    var  email: String = ""
    var  date: String = ""

    var  patWeight: String = ""
    var  patHeight: String = ""
    var  patMedication: String = ""
    var  patPastDiagnosis: String = ""
    var  patAllergies: String = ""
    var  deptName: String = ""
    var  deptCode: String = ""

    var  appointmentNo: String = ""
    var  apptStartTime: String = ""
    var  apptEndTime: String = ""
    var  apptDate: String = ""
    var  hospitalName: String = ""

    var  isEpisodeExist: String = ""
    var  episodeCode: String = ""
    var  episodeVisitNo: String = ""
    var  requestStatusCompleteDate: String = ""
    var  requestStatusCompleteMode: String = ""


    var  isPast: Bool

    var  patientToken: String = ""
    var  doctorToken: String = ""
    var  consultationTime: String = ""
   
    init( requestID: String, CRNo: String, scrResponse: String, consName: String, deptUnitCode: String, deptUnitName: String, hospCode: String, requestStatus: String, patMobileNo: String, consMobileNo: String, patDocs: String, docMessage: String, cnsltntId: String, patName: String, patAge: String, patGender: String, rmrks: String, email: String, date: String, patWeight: String, patHeight: String, patMedication: String, patPastDiagnosis: String, patAllergies: String, deptName: String, deptCode: String, appointmentNo: String, apptStartTime: String, apptEndTime: String, apptDate: String, hospitalName: String, isEpisodeExist: String, episodeCode: String, episodeVisitNo: String, requestStatusCompleteDate: String, requestStatusCompleteMode:String,  isPast: Bool, patientToken: String, doctorToken: String, consultationTime: String) {
    self.requestID = requestID;
    self.CRNo = CRNo;
    self.scrResponse = scrResponse;
    self.consName = consName;
    self.deptUnitCode = deptUnitCode;
    self.deptUnitName = deptUnitName;
    self.hospCode = hospCode;
    self.requestStatus = requestStatus;
    self.patMobileNo = patMobileNo;
    self.consMobileNo = consMobileNo;
    self.patDocs = patDocs;
    self.docMessage = docMessage;
    self.cnsltntId = cnsltntId;
    self.patName = patName;
    self.patAge = patAge;
    self.patGender = patGender;
    self.rmrks = rmrks;
    self.email = email;
    self.date = date;
    self.patWeight = patWeight;
    self.patHeight = patHeight;
    self.patMedication = patMedication;
    self.patPastDiagnosis = patPastDiagnosis;
    self.patAllergies = patAllergies;
    self.deptName = deptName;
    self.deptCode = deptCode;
    self.appointmentNo = appointmentNo;
    self.apptStartTime = apptStartTime;
    self.apptEndTime = apptEndTime;
    self.apptDate = apptDate;
    self.hospitalName = hospitalName;
    self.isEpisodeExist = isEpisodeExist;
    self.episodeCode = episodeCode;
    self.episodeVisitNo = episodeVisitNo;
    self.requestStatusCompleteDate = requestStatusCompleteDate;
    self.requestStatusCompleteMode = requestStatusCompleteMode;
    self.isPast=isPast;

    self.patientToken=patientToken;
    self.doctorToken=doctorToken;
    self.consultationTime=consultationTime;
        
    }
}
