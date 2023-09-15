//
//  reportlistModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 05/06/22.
//

import Foundation
struct reportListModel
{
    var testName: String = ""
    var reqNumber: String = ""
    var reportDate: String = ""
    var hospCode: String = ""
    var hospName: String = ""
    
    init(){
        
    }
    
    
    
    init(json:JSON){
        testName = json["TESTNAME"].stringValue
        reqNumber = json["HIVTNUM_REQ_DNO"].stringValue
        reportDate = json["HIVDT_REPORT_DATE"].stringValue
        hospCode = json["GNUM_HOSPITAL_CODE"].stringValue
        hospName = json["GSTR_HOSPITAL_NAME"].stringValue
        
        
    }
}
