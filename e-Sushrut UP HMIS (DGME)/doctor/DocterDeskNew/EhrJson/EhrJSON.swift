//
//  EhrJSON.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation

// MARK: - EhrJSON
class EhrJSON: Codable {
    var admissionadviceDeptName, admissionadviceNotes, admissionadviceWardName, crNo: String!
    var clinicalProcedureJSONArray: [ClinicalProcedureJSONArray]!
    var currentVisitDate: String!
    var diagnosis: [String]!
    var drugCodeCat: [String]!
    var episodeCode, episodeVisitNo: String!
    var followUp: [FollowUp]!
    var hospCode: String!
    var hrgnumIsDocuploaded: Int!
    var hvsValue: String!
    var invTestCode, invTestCodeToPrint: [String]!
    var isHvsFlg, lastVisitDate: String!
    var pacReqJSONArr: [String]!
    var patAge, patCat, patCatCode, patCompleteGeneralDtl: String!
    var patConsultantName, patDept, patGaurdianName, patGender: String!
    var patName, patQueueNo, patVisitType: String!
    var reasonOfVisit, referralProcJSON, referralTestJSON: [String]!
    var seatID, strAllDeptIdflg, strBookmarkModifyFlag: String!
    var strChronicDisease: [String]!
    var strClinicalProcedure: [String]!
    var strCompleteHistory: StrCompleteHistory!
    var strConfidentialsInfo, strDeptIdflg, strDesignation, strDiagnosisNote: String!
    var strDrugAllergy: [String]!
    var strHistoryOfPresentIllNess, strInvestgationNote, strLevelOfEntitlement, strPatRecentDept: String!
    var strPresCriptionBookmarkDescVal, strPresCriptionBookmarkNameval, strPresProfileBookmarkID: String!
    var strReferal: [String]!
    var strStation: String!
    var strSystematicExamniation: StrSystematicExamniation!
    var strUmidNo, strUserEmpNo, strVitalsChart, strotherAllergies: String!
    var strpiccle: Strpiccle!
    var strtreatmentAdvice: String!

    enum CodingKeys: String, CodingKey {
        case admissionadviceDeptName, admissionadviceNotes, admissionadviceWardName
        case crNo = "CR_No"
        case clinicalProcedureJSONArray = "ClinicalProcedureJsonArray"
        case currentVisitDate
        case diagnosis = "Diagnosis"
        case drugCodeCat = "DrugCodeCat"
        case episodeCode, episodeVisitNo
        case followUp = "FOLLOW_UP"
        case hospCode = "hosp_code"
        case hrgnumIsDocuploaded = "hrgnum_is_docuploaded"
        case hvsValue
        case invTestCode = "InvTestCode"
        case invTestCodeToPrint = "InvTestCodeToPrint"
        case isHvsFlg, lastVisitDate
        case pacReqJSONArr = "pacReqJsonArr"
        case patAge, patCat, patCatCode
        case patCompleteGeneralDtl = "PatCompleteGeneralDtl"
        case patConsultantName, patDept, patGaurdianName, patGender
        case patName = "pat_Name"
        case patQueueNo, patVisitType
        case reasonOfVisit = "ReasonOfVisit"
        case referralProcJSON = "referralProcJson"
        case referralTestJSON = "referralTestJson"
        case seatID = "seatId"
        case strAllDeptIdflg, strBookmarkModifyFlag, strChronicDisease, strClinicalProcedure, strCompleteHistory, strConfidentialsInfo, strDeptIdflg, strDesignation, strDiagnosisNote, strDrugAllergy, strHistoryOfPresentIllNess, strInvestgationNote, strLevelOfEntitlement, strPatRecentDept, strPresCriptionBookmarkDescVal, strPresCriptionBookmarkNameval
        case strPresProfileBookmarkID = "strPresProfileBookmarkId"
        case strReferal, strStation, strSystematicExamniation, strUmidNo, strUserEmpNo, strVitalsChart, strotherAllergies, strpiccle, strtreatmentAdvice
    }

    init(){}
    init(admissionadviceDeptName: String, admissionadviceNotes: String, admissionadviceWardName: String, crNo: String, clinicalProcedureJSONArray: [ClinicalProcedureJSONArray], currentVisitDate: String, diagnosis: [String], drugCodeCat: [String], episodeCode: String, episodeVisitNo: String, followUp: [FollowUp], hospCode: String, hrgnumIsDocuploaded: Int, hvsValue: String, invTestCode: [String], invTestCodeToPrint: [String], isHvsFlg: String, lastVisitDate: String, pacReqJSONArr: [String], patAge: String, patCat: String, patCatCode: String, patCompleteGeneralDtl: String, patConsultantName: String, patDept: String, patGaurdianName: String, patGender: String, patName: String, patQueueNo: String, patVisitType: String, reasonOfVisit: [String], referralProcJSON: [String], referralTestJSON: [String], seatID: String, strAllDeptIdflg: String, strBookmarkModifyFlag: String, strChronicDisease: [String], strClinicalProcedure: [String], strCompleteHistory: StrCompleteHistory, strConfidentialsInfo: String, strDeptIdflg: String, strDesignation: String, strDiagnosisNote: String, strDrugAllergy: [String], strHistoryOfPresentIllNess: String, strInvestgationNote: String, strLevelOfEntitlement: String, strPatRecentDept: String, strPresCriptionBookmarkDescVal: String, strPresCriptionBookmarkNameval: String, strPresProfileBookmarkID: String, strReferal: [String], strStation: String, strSystematicExamniation: StrSystematicExamniation, strUmidNo: String, strUserEmpNo: String, strVitalsChart: String, strotherAllergies: String, strpiccle: Strpiccle, strtreatmentAdvice: String) {
        self.admissionadviceDeptName = admissionadviceDeptName
        self.admissionadviceNotes = admissionadviceNotes
        self.admissionadviceWardName = admissionadviceWardName
        self.crNo = crNo
        self.clinicalProcedureJSONArray = clinicalProcedureJSONArray
        self.currentVisitDate = currentVisitDate
        self.diagnosis = diagnosis
        self.drugCodeCat = drugCodeCat
        self.episodeCode = episodeCode
        self.episodeVisitNo = episodeVisitNo
        self.followUp = followUp
        self.hospCode = hospCode
        self.hrgnumIsDocuploaded = hrgnumIsDocuploaded
        self.hvsValue = hvsValue
        self.invTestCode = invTestCode
        self.invTestCodeToPrint = invTestCodeToPrint
        self.isHvsFlg = isHvsFlg
        self.lastVisitDate = lastVisitDate
        self.pacReqJSONArr = pacReqJSONArr
        self.patAge = patAge
        self.patCat = patCat
        self.patCatCode = patCatCode
        self.patCompleteGeneralDtl = patCompleteGeneralDtl
        self.patConsultantName = patConsultantName
        self.patDept = patDept
        self.patGaurdianName = patGaurdianName
        self.patGender = patGender
        self.patName = patName
        self.patQueueNo = patQueueNo
        self.patVisitType = patVisitType
        self.reasonOfVisit = reasonOfVisit
        self.referralProcJSON = referralProcJSON
        self.referralTestJSON = referralTestJSON
        self.seatID = seatID
        self.strAllDeptIdflg = strAllDeptIdflg
        self.strBookmarkModifyFlag = strBookmarkModifyFlag
        self.strChronicDisease = strChronicDisease
        self.strClinicalProcedure = strClinicalProcedure
        self.strCompleteHistory = strCompleteHistory
        self.strConfidentialsInfo = strConfidentialsInfo
        self.strDeptIdflg = strDeptIdflg
        self.strDesignation = strDesignation
        self.strDiagnosisNote = strDiagnosisNote
        self.strDrugAllergy = strDrugAllergy
        self.strHistoryOfPresentIllNess = strHistoryOfPresentIllNess
        self.strInvestgationNote = strInvestgationNote
        self.strLevelOfEntitlement = strLevelOfEntitlement
        self.strPatRecentDept = strPatRecentDept
        self.strPresCriptionBookmarkDescVal = strPresCriptionBookmarkDescVal
        self.strPresCriptionBookmarkNameval = strPresCriptionBookmarkNameval
        self.strPresProfileBookmarkID = strPresProfileBookmarkID
        self.strReferal = strReferal
        self.strStation = strStation
        self.strSystematicExamniation = strSystematicExamniation
        self.strUmidNo = strUmidNo
        self.strUserEmpNo = strUserEmpNo
        self.strVitalsChart = strVitalsChart
        self.strotherAllergies = strotherAllergies
        self.strpiccle = strpiccle
        self.strtreatmentAdvice = strtreatmentAdvice
    }
}
