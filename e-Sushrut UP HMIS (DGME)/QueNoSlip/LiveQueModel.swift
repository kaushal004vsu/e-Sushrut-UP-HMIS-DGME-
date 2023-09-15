//
//  LiveQueModel.swift
//  Railways-HMIS
//
//  Created by HICDAC on 02/03/23.
//

import Foundation
struct LiveQueModel{
    var hosp_name="",dept_name="",unit_name="",liveQueno="",waitingTime=""
  
//    init(){}
    
    init(json:JSON){
        hosp_name = json["hosp_name"].stringValue
        dept_name = json["dept_name"].stringValue
        unit_name = json["unit_name"].stringValue
        liveQueno = json["hrgnum_que_no"].stringValue
        waitingTime = json["per_person_waiting_time_mins"].stringValue
    }
   
    
}
