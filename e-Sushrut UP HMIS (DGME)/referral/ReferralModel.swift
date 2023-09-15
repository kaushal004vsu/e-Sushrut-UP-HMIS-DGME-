//
//  ReferralModel.swift
//  Railways-HMIS
//
//  Created by HICDAC on 20/12/22.
//

import Foundation
struct ReferralModel{
    var req_sl_no="",hrgnm_adm_no="",doctorName="",crno="",refer_date=""
    var episode_code="",seat_id="",visit_date="",visit_no="",toDepartment=""
    var refer_type="",from_department_unit="",status="",isPublished="",hosp_code=""
    var fromHospital="",fromDepartment="",hrgnum_status="",adm_no="",req_no=""
    
    init(){}
    
    init(json:JSON){
        req_sl_no = json["REQ_SL_NO"].stringValue
        hrgnm_adm_no = json["HRGNUM_ADMISSION_NO"].stringValue
        doctorName = json["DOCTOR_NAME"].stringValue
        crno = json["CR_NO"].stringValue
        refer_date = json["REFERDT"].stringValue
        episode_code = json["EPISODE_CODE"].stringValue
        seat_id = json["SEAT_ID"].stringValue
        visit_date = json["VISIT_DATE"].stringValue
        visit_no = json["VISIT_NO"].stringValue
        toDepartment = json["TO_DEPARTMENT"].stringValue
        refer_type = json["REFER_TYPE"].stringValue
        from_department_unit = json["FROM_DEPARTMENT_UNIT"].stringValue
        status = json["STATUS"].stringValue
        isPublished = json["IS_PUBLISHED"].stringValue
        hosp_code = json["HOSP_CODE"].stringValue
        fromHospital = json["FROM_HOSPITAL"].stringValue
        fromDepartment = json["FROM_DEPARTMENT"].stringValue
        hrgnum_status = json["HRGNUM_STATUS"].stringValue
        adm_no = json["ADM_NO"].stringValue
        req_no = json["REQ_NO"].stringValue
    }
    
}
