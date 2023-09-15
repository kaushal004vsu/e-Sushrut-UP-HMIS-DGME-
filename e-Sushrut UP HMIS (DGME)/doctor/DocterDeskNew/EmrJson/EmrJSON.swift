//
//  EmrJSON.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//
import Foundation


// MARK: - EmrJSON
class EmrJSON: Codable {
    var admissionadviceDeptName, admissionadviceNotes, admissionadviceWardName, crNo: String!
    var chronicDiseaseArray: [ChronicDiseaseArray]!
    var clinicalProcedureJSONArray: [ClinicalProcedureJSONArrayEmr]!
    var completeHistoryJaonArray: CompleteHistoryJaonArrayEmr!
    var consultantName, currentVisitDate: String!
    var diagnosisJSONArray: [DiagnosisJsonArray]!
    var diagnosisNote: String!
    var drugJSONArray: [DrugJSONArray]!
    var episodeCode, episodeVisitNo: String!
    var followUp: [FollowUpEmr]!
    var historyOfPresentIllNess, hospCode: String!
    var hrgnumIsDocuploaded: Int!
    var hvsValue, investgationNote: String!
    var investigationJSONArray: [InvestigationJSONArray]!
    var isHvsFlg, lastVisitDate, otherAllergies: String!
    var pacReqJSONArr: [String]!
    var patCatCode, patCompleteGeneralDtl, patGaurdianName, patVisitType: String!
    var patientAge, patientCat, patientDept, patientGender: String!
    var patientName, patientQueueNo: String!
    var patientRefrel: [String]!
    var piccleArray: PiccleArray!
    var reasonOfVisitJSONArray, referralProcJSON, referralTestJSON: [String]!
    var seatID, strAllDeptIdflg, strBookmarkModifyFlag, strConfidentialsInfo: String!
    var strDeptIdflg, strDesignation, strLevelOfEntitlement, strPatRecentDept: String!
    var strPresCriptionBookmarkDescVal, strPresCriptionBookmarkNameval, strPresProfileBookmarkID, strStation: String!
    var strUmidNo, strVitalsChart: String!
    var strpiccle: StrpiccleEmr!
    var strtreatmentAdvice: String!
    var systematicExamniationArray: SystematicExamniationArrayEmr!

    enum CodingKeys: String, CodingKey {
        case admissionadviceDeptName, admissionadviceNotes, admissionadviceWardName
        case crNo = "CR_No"
        case chronicDiseaseArray = "ChronicDiseaseArray"
        case clinicalProcedureJSONArray = "ClinicalProcedureJsonArray"
        case completeHistoryJaonArray = "CompleteHistoryJaonArray"
        case consultantName = "ConsultantName"
        case currentVisitDate = "CurrentVisitDate"
        case diagnosisJSONArray = "DiagnosisJsonArray"
        case diagnosisNote = "DiagnosisNote"
        case drugJSONArray = "DrugJsonArray"
        case episodeCode = "EpisodeCode"
        case episodeVisitNo = "EpisodeVisitNo"
        case followUp = "FOLLOW_UP"
        case historyOfPresentIllNess = "HistoryOfPresentIllNess"
        case hospCode = "hosp_code"
        case hrgnumIsDocuploaded = "hrgnum_is_docuploaded"
        case hvsValue
        case investgationNote = "InvestgationNote"
        case investigationJSONArray = "InvestigationJsonArray"
        case isHvsFlg
        case lastVisitDate = "LastVisitDate"
        case otherAllergies = "OtherAllergies"
        case pacReqJSONArr = "pacReqJsonArr"
        case patCatCode
        case patCompleteGeneralDtl = "PatCompleteGeneralDtl"
        case patGaurdianName
        case patVisitType = "PatVisitType"
        case patientAge = "PatientAge"
        case patientCat = "PatientCat"
        case patientDept = "PatientDept"
        case patientGender = "PatientGender"
        case patientName = "Patient_Name"
        case patientQueueNo = "PatientQueueNo"
        case patientRefrel = "PatientRefrel"
        case piccleArray = "PiccleArray"
        case reasonOfVisitJSONArray = "ReasonOfVisitJsonArray"
        case referralProcJSON = "referralProcJson"
        case referralTestJSON = "referralTestJson"
        case seatID = "seatId"
        case strAllDeptIdflg, strBookmarkModifyFlag, strConfidentialsInfo, strDeptIdflg, strDesignation, strLevelOfEntitlement, strPatRecentDept, strPresCriptionBookmarkDescVal, strPresCriptionBookmarkNameval
        case strpiccle = "strpiccle"
        case strPresProfileBookmarkID = "strPresProfileBookmarkId"
        case strStation, strUmidNo, strVitalsChart, strtreatmentAdvice
        case systematicExamniationArray = "SystematicExamniationArray"
    }
    init(){}
    init(admissionadviceDeptName: String, admissionadviceNotes: String, admissionadviceWardName: String, crNo: String, chronicDiseaseArray: [ChronicDiseaseArray], clinicalProcedureJSONArray: [ClinicalProcedureJSONArrayEmr], completeHistoryJaonArray: CompleteHistoryJaonArrayEmr, consultantName: String, currentVisitDate: String, diagnosisJSONArray:  [DiagnosisJsonArray], diagnosisNote: String, drugJSONArray: [DrugJSONArray], episodeCode: String, episodeVisitNo: String, followUp: [FollowUpEmr], historyOfPresentIllNess: String, hospCode: String, hrgnumIsDocuploaded: Int, hvsValue: String, investgationNote: String, investigationJSONArray: [InvestigationJSONArray], isHvsFlg: String, lastVisitDate: String, otherAllergies: String, pacReqJSONArr: [String], patCatCode: String, patCompleteGeneralDtl: String, patGaurdianName: String, patVisitType: String, patientAge: String, patientCat: String, patientDept: String, patientGender: String, patientName: String, patientQueueNo: String, patientRefrel: [String], piccleArray: PiccleArray, reasonOfVisitJSONArray: [String], referralProcJSON: [String], referralTestJSON: [String], seatID: String, strAllDeptIdflg: String, strBookmarkModifyFlag: String, strConfidentialsInfo: String, strDeptIdflg: String, strDesignation: String, strLevelOfEntitlement: String, strPatRecentDept: String, strPresCriptionBookmarkDescVal: String, strPresCriptionBookmarkNameval: String, strPresProfileBookmarkID: String, strStation: String, strUmidNo: String, strVitalsChart: String, strpiccle: StrpiccleEmr, strtreatmentAdvice: String, systematicExamniationArray: SystematicExamniationArrayEmr) {
        self.admissionadviceDeptName = admissionadviceDeptName
        self.admissionadviceNotes = admissionadviceNotes
        self.admissionadviceWardName = admissionadviceWardName
        self.crNo = crNo
        self.chronicDiseaseArray = chronicDiseaseArray
        self.clinicalProcedureJSONArray = clinicalProcedureJSONArray
        self.completeHistoryJaonArray = completeHistoryJaonArray
        self.consultantName = consultantName
        self.currentVisitDate = currentVisitDate
        self.diagnosisJSONArray = diagnosisJSONArray
        self.diagnosisNote = diagnosisNote
        self.drugJSONArray = drugJSONArray
        self.episodeCode = episodeCode
        self.episodeVisitNo = episodeVisitNo
        self.followUp = followUp
        self.historyOfPresentIllNess = historyOfPresentIllNess
        self.hospCode = hospCode
        self.hrgnumIsDocuploaded = hrgnumIsDocuploaded
        self.hvsValue = hvsValue
        self.investgationNote = investgationNote
        self.investigationJSONArray = investigationJSONArray
        self.isHvsFlg = isHvsFlg
        self.lastVisitDate = lastVisitDate
        self.otherAllergies = otherAllergies
        self.pacReqJSONArr = pacReqJSONArr
        self.patCatCode = patCatCode
        self.patCompleteGeneralDtl = patCompleteGeneralDtl
        self.patGaurdianName = patGaurdianName
        self.patVisitType = patVisitType
        self.patientAge = patientAge
        self.patientCat = patientCat
        self.patientDept = patientDept
        self.patientGender = patientGender
        self.patientName = patientName
        self.patientQueueNo = patientQueueNo
        self.patientRefrel = patientRefrel
        self.piccleArray = piccleArray
        self.reasonOfVisitJSONArray = reasonOfVisitJSONArray
        self.referralProcJSON = referralProcJSON
        self.referralTestJSON = referralTestJSON
        self.seatID = seatID
        self.strAllDeptIdflg = strAllDeptIdflg
        self.strBookmarkModifyFlag = strBookmarkModifyFlag
        self.strConfidentialsInfo = strConfidentialsInfo
        self.strDeptIdflg = strDeptIdflg
        self.strDesignation = strDesignation
        self.strLevelOfEntitlement = strLevelOfEntitlement
        self.strPatRecentDept = strPatRecentDept
        self.strPresCriptionBookmarkDescVal = strPresCriptionBookmarkDescVal
        self.strPresCriptionBookmarkNameval = strPresCriptionBookmarkNameval
        self.strPresProfileBookmarkID = strPresProfileBookmarkID
        self.strStation = strStation
        self.strUmidNo = strUmidNo
        self.strVitalsChart = strVitalsChart
        self.strpiccle = strpiccle
        self.strtreatmentAdvice = strtreatmentAdvice
        self.systematicExamniationArray = systematicExamniationArray
    }
}
