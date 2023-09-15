//
//  EmeregencyContactModel.swift
//  Railways-HMIS
//
//  Created by HICDAC on 21/12/22.
//

import Foundation
struct EmeregencyContactModel{
    var code="",name="",address="",phone="",email=""
    var weekdays_timing="",sat_timing="",lunch_break="",opd_timings=""
    
    init(){}
    
    init(json:JSON){
        code = json["CODE"].stringValue
        name = json["NAME"].stringValue
        address = json["ADDRESS"].stringValue
        phone = json["PHONE"].stringValue
        email = json["EMAIL"].stringValue
        
        weekdays_timing = json["WEEKDAYSTIMING"].stringValue
        sat_timing = json["SATTIMING"].stringValue
        lunch_break = json["LUNCHBREAK"].stringValue
        opd_timings = json["OPDTIMINGS"].stringValue
       
    }
   
    
}
