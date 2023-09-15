//
//  PrescriptionListModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 08/06/22.
//

import Foundation
struct PrescriptionListModel{
    var crno: String = ""
    var episodeCode: String = ""
    var deptCode: String = ""
    var visitDate: String = ""
    var hospCode: String = ""
    var deptName:String = ""
    var unitName:String = ""
    var visitNo:String = ""
    var genderCode:String = ""
    var hospName: String = ""
    var entryDate:String = ""
    init(){
        
    }
    
    
    
    init(json:JSON){
         crno = json["HRGNUM_PUK"].stringValue
        episodeCode = json["HRGNUM_EPISODE_CODE"].stringValue
        deptCode = json["GNUM_DEPT_CODE"].stringValue
        visitDate = json["HRGDT_VISIT_DATE"].stringValue
        hospCode = json["GNUM_HOSPITAL_CODE"].stringValue
        deptName = json["GSTR_DEPT_NAME"].stringValue
        unitName = json["HGSTR_UNITNAME"].stringValue
        visitNo = json["HRGNUM_VISIT_NO"].stringValue
        genderCode = json["GSTR_GENDER_CODE"].stringValue
        hospName = json["HOSP_NAME"].stringValue
        entryDate = json["ENTRY_DATE"].stringValue 
           }
}
