//
//  OPDLiteModel.swift
//  SAIL Rourkela
//
//  Created by HICDAC on 24/05/23.
//

import Foundation
struct OPDLiteModel{
        var PATCRNO: String = ""
        var QUENO: String = ""
        var PATNAME: String = ""
        var GENDERAGE: String = ""
        var PATPRIMARYCAT: String = ""
        var VISITREASON: String = ""
        var DEPARTMENTUNITNAME: String = ""
        var GET_UMID_NO_FROM_PATIENT_DTL: String = ""
        var PATGUARDIANNAME: String = ""
        var PATMOMNAME: String = ""
        var EPISODECODE: String = ""
        var EPISODEVISITNO: String = ""
        var EPISODETYPECODE: String = ""
        var DEPARTMENTUNITCODE: String = ""
        var DEPARTMENTCODE: String = ""
        var PATCHANGETYPE: String = ""
        var PATMARITALSTATUSCODE: String = ""
        var EPISODEDATE: String = ""
        var PATPRIMARYCATCODE: String = ""
        var PATSECONDARYCATCODE: String = ""
        var PATSECONDARYCAT: String = ""
        var DEPARTMENT: String = ""
        var DEPARTMENTUNIT: String = ""
        var ISCONFIRMED: String = ""
        var VISIT_NO: String = ""
        var GNUM_HOSPITAL_CODE: String = ""
        var VISIT_TYPE: String = ""
        var IS_APPOINTMENT: String = ""
        var PREV_CR_EXISTS: String = ""
        var PAT_ADM_NO: String = ""
        var ISREFFRED: String = ""
        var BROUGHT_DEAD: String = ""
        var MLC: String = ""
        var SEATID: String = ""
        var HGNUM_PAT_STATUS_CODE: String = ""
        var TO_CHAR: String = ""
        var TEMPCRNO: String = ""
        var PRESCRIPTIONCOUNT: String = ""
        var ISSAVEDJSON: String = ""
        var MOBILENO: String = ""
        var IS_VITAL: String = ""
        var NVL: String = ""
        var TELECONSULTANCYFLG: String = ""
        var HRGSTR_TELECONSULTANCY_REQ_ID: String = ""
        var FUN_GET_UNIT_CONSULTANT: String = ""
        var UMID_DATA: String = ""
        var COLUMN: String = ""
        var GET_PAT_TRIAGE_STATUS: String = ""
        var HRGNUM_REG_CAT_CODE: String = ""


        init(){}
        
        init(json:JSON){
            PATCRNO = json["PATCRNO"].stringValue
            QUENO = json["QUENO"].stringValue
            PATNAME = json["PATNAME"].stringValue
            GENDERAGE = json["GENDERAGE"].stringValue
            PATPRIMARYCAT = json["PATPRIMARYCAT"].stringValue
            VISITREASON = json["VISITREASON"].stringValue
            DEPARTMENTUNITNAME = json["DEPARTMENTUNITNAME"].stringValue
            GET_UMID_NO_FROM_PATIENT_DTL = json["GET_UMID_NO_FROM_PATIENT_DTL"].stringValue
            PATGUARDIANNAME = json["PATGUARDIANNAME"].stringValue
            PATMOMNAME = json["PATMOMNAME"].stringValue
            EPISODECODE = json["EPISODECODE"].stringValue
            EPISODEVISITNO = json["EPISODEVISITNO"].stringValue
            EPISODETYPECODE = json["EPISODETYPECODE"].stringValue
            DEPARTMENTUNITCODE = json["DEPARTMENTUNITCODE"].stringValue
            DEPARTMENTCODE = json["DEPARTMENTCODE"].stringValue
            PATCHANGETYPE = json["PATCHANGETYPE"].stringValue
            PATMARITALSTATUSCODE = json["PATMARITALSTATUSCODE"].stringValue
            EPISODEDATE = json["EPISODEDATE"].stringValue
            PATPRIMARYCATCODE = json["PATPRIMARYCATCODE"].stringValue
            PATSECONDARYCATCODE = json["PATSECONDARYCATCODE"].stringValue
            PATSECONDARYCAT = json["PATSECONDARYCAT"].stringValue
            DEPARTMENT = json["DEPARTMENT"].stringValue
            DEPARTMENTUNIT = json["DEPARTMENTUNIT"].stringValue
            ISCONFIRMED = json["ISCONFIRMED"].stringValue
            VISIT_NO = json["VISIT_NO"].stringValue
            GNUM_HOSPITAL_CODE = json["GNUM_HOSPITAL_CODE"].stringValue
            VISIT_TYPE = json["VISIT_TYPE"].stringValue
            IS_APPOINTMENT = json["IS_APPOINTMENT"].stringValue
            PREV_CR_EXISTS = json["PREV_CR_EXISTS"].stringValue
            PAT_ADM_NO = json["PAT_ADM_NO"].stringValue
            ISREFFRED = json["ISREFFRED"].stringValue
            BROUGHT_DEAD = json["BROUGHT_DEAD"].stringValue
            MLC = json["MLC"].stringValue
            SEATID = json["SEATID"].stringValue
            HGNUM_PAT_STATUS_CODE = json["HGNUM_PAT_STATUS_CODE"].stringValue
            TO_CHAR = json["TO_CHAR"].stringValue
            TEMPCRNO = json["TEMPCRNO"].stringValue
            PRESCRIPTIONCOUNT = json["PRESCRIPTIONCOUNT"].stringValue
            ISSAVEDJSON = json["ISSAVEDJSON"].stringValue
            MOBILENO = json["MOBILENO"].stringValue
            IS_VITAL = json["IS_VITAL"].stringValue
            NVL = json["NVL"].stringValue
            TELECONSULTANCYFLG = json["TELECONSULTANCYFLG"].stringValue
            HRGSTR_TELECONSULTANCY_REQ_ID = json["HRGSTR_TELECONSULTANCY_REQ_ID"].stringValue
            FUN_GET_UNIT_CONSULTANT = json["FUN_GET_UNIT_CONSULTANT"].stringValue
            UMID_DATA = json["UMID_DATA"].stringValue
            COLUMN = json["?COLUMN?"].stringValue
            GET_PAT_TRIAGE_STATUS = json["GET_PAT_TRIAGE_STATUS"].stringValue
            HRGNUM_REG_CAT_CODE = json["HRGNUM_REG_CAT_CODE"].stringValue
        }
   
    
}
