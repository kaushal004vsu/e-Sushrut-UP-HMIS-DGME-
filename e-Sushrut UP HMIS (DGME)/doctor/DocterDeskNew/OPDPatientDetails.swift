//
//  PatientDetails.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 09/07/23.
//

import Foundation
struct OPDPatientDetails{
    
    var patcrno="";
    var queno="";
    var patname="";
    var genderage="";
    var patprimarycat="";
    var visitreason="";
    var departmentunitname="";
    var getUmidNoFromPatientDtl="";
    var patguardianname="";
    var patmomname="";
    var episodecode="";
    var episodevisitno="";
    var episodetypecode="";
    var departmentunitcode="";
    var departmentcode="";
    var patchangetype="";
    var patmaritalstatuscode="";
    var episodedate="";
    var patprimarycatcode="";
    var patsecondarycatcode="";
    var patsecondarycat="";
    var department="";
    var departmentunit="";
    var isconfirmed="";
    var visitNo="";
    var gnumHospitalCode="";
    var visitType="";
    var isAppointment="";
    var prevCrExists="";
    var patAdmNo="";
    var isreffred="";
    var broughtDead="";
    var mlc="";
    var seatid="";
    var hgnumPatStatusCode="";
    var toChar="";
    var tempcrno = ""
    var prescriptioncount = ""
    var issavedjson = ""
    var mobileno = ""
    var isVital = ""
    var nvl = ""
    var teleconsultancyflg = ""
    var hrgstrTeleconsultancyReqId = ""
    var funGetUnitConsultant = ""
    var umidData = ""
    var getPatTriageStatus = ""
    var hrgnumRegCatCode = ""
  
    init(){}
    init(json:JSON){
        patcrno = json["PATCRNO"].stringValue
        queno = json["QUENO"].stringValue
        patname = json["PATNAME"].stringValue
        genderage = json["GENDERAGE"].stringValue
        patprimarycat = json["PATPRIMARYCAT"].stringValue
        visitreason = json["VISITREASON"].stringValue
        departmentunitname = json["DEPARTMENTUNITNAME"].stringValue
        getUmidNoFromPatientDtl = json["GET_UMID_NO_FROM_PATIENT_DTL"].stringValue
        patguardianname = json["PATGUARDIANNAME"].stringValue
        patmomname = json["PATMOMNAME"].stringValue
        episodecode = json["EPISODECODE"].stringValue
        episodevisitno = json["EPISODEVISITNO"].stringValue
        episodetypecode = json["EPISODETYPECODE"].stringValue
        departmentunitcode = json["DEPARTMENTUNITCODE"].stringValue
        departmentcode = json["DEPARTMENTCODE"].stringValue
        patchangetype = json["PATCHANGETYPE"].stringValue
        patmaritalstatuscode = json["PATMARITALSTATUSCODE"].stringValue
        episodedate = json["EPISODEDATE"].stringValue
        patprimarycatcode = json["PATPRIMARYCATCODE"].stringValue
        patsecondarycatcode = json["PATSECONDARYCATCODE"].stringValue
        patsecondarycat = json["PATSECONDARYCAT"].stringValue
        department = json["DEPARTMENT"].stringValue
        departmentunit = json["DEPARTMENTUNIT"].stringValue
        isconfirmed = json["ISCONFIRMED"].stringValue
        visitNo = json["VISIT_NO"].stringValue
        gnumHospitalCode = json["GNUM_HOSPITAL_CODE"].stringValue
        visitType = json["VISIT_TYPE"].stringValue
        isAppointment = json["IS_APPOINTMENT"].stringValue
        prevCrExists = json["PREV_CR_EXISTS"].stringValue
        patAdmNo = json["PAT_ADM_NO"].stringValue
        isreffred = json["ISREFFRED"].stringValue
        broughtDead = json["BROUGHT_DEAD"].stringValue
        mlc = json["MLC"].stringValue
        seatid = json["SEATID"].stringValue
        hgnumPatStatusCode = json["HGNUM_PAT_STATUS_CODE"].stringValue
        toChar = json["TO_CHAR"].stringValue
        tempcrno = json["TEMPCRNO"].stringValue
        prescriptioncount = json["PRESCRIPTIONCOUNT"].stringValue
        issavedjson = json["ISSAVEDJSON"].stringValue
        mobileno = json["MOBILENO"].stringValue
        isVital = json["IS_VITAL"].stringValue
        nvl = json["NVL"].stringValue
        teleconsultancyflg = json["TELECONSULTANCYFLG"].stringValue
        hrgstrTeleconsultancyReqId = json["HRGSTR_TELECONSULTANCY_REQ_ID"].stringValue
        funGetUnitConsultant = json["FUN_GET_UNIT_CONSULTANT"].stringValue
        umidData = json["UMID_DATA"].stringValue
        getPatTriageStatus = json["GET_PAT_TRIAGE_STATUS"].stringValue
        hrgnumRegCatCode = json["HRGNUM_REG_CAT_CODE"].stringValue
    
        
         }
        }
