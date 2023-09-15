//
//  File.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 05/08/22.
//

import Foundation
struct SickListModel
{
    var sick_end: String = ""
    var printStr: String = ""
    var current_status: String = ""
    var request_date: String = ""
    var categoryStr: String = ""
    var check_box_val: String = ""
    var deparment: String = ""
    var sick_start: String = ""
    var sick_period: String = ""
    var sick_type: String = ""

    init(){
        
    }
    
    init(json:JSON){
        sick_end = json["SICK_END"].stringValue
        printStr = json["PRINT"].stringValue
        current_status = json["CURRENT_STATUS"].stringValue
        request_date = json["REQUEST_DATE"].stringValue
        categoryStr = json["CATEGORY"].stringValue
        check_box_val = json["CHEBOXVAL"].stringValue
        deparment = json["DEPARTMENT"].stringValue
        sick_start = json["SICK_START"].stringValue
        sick_period = json["SICK_PERIOD"].stringValue
        sick_type = json["SICK_TYPE"].stringValue
    }
}
