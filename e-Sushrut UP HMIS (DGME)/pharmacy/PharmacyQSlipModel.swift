//
//  PharmacyQSlipModel.swift
//  Railways-HMIS
//
//  Created by HICDAC on 10/01/23.
//

import Foundation

struct PharmacyQSlipModel{
    
    var crno="", pat_name="", age="", gender="";
    var que_no="", dept_code="", dept_unit_name="", episode_code="";
    var visit_no="", hosp_code="", service_type="", status_code="";
    var entry_date="", dispensed_time="", store_name="", hosp_name="",token_status="";
  
    init(){}
    init(json:JSON){
        crno = json["CRNO"].stringValue
        pat_name = json["PAT_NAME"].stringValue
        age = json["AGE"].stringValue
        gender = json["GENDER"].stringValue
        que_no = json["QUE_NO"].stringValue
        dept_code = json["DEPT_CODE"].stringValue
        dept_unit_name = json["DEPTUNITNAME"].stringValue
        episode_code = json["EPISODE_CODE"].stringValue
        visit_no = json["VISIT_NO"].stringValue
        hosp_code = json["HOSP_CODE"].stringValue
        service_type = json["SERVICE_TYPE"].stringValue
        status_code = json["STATUS_CODE"].stringValue
        entry_date = json["ENTRY_DATE"].stringValue
        dispensed_time = json["DISPENSED_TIME"].stringValue
        store_name = json["STORENAME"].stringValue
        hosp_name = json["HOSP_NAME"].stringValue
        token_status = json["TOKEN_STATUS"].stringValue
        
         }
        }
