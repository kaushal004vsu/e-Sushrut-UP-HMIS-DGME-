//
//  StatsDetails.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 28/09/22.
//

import Foundation
struct StatsDetails{
    var crno = ""
    var sl_no = ""
    var vital_name = ""
    var vital_id = ""
    var vital_value = ""
    var record_date = ""
    var vital_unit = ""
    var is_normal = ""
    var hnum_is_servere = ""
   
    init(){
        
    }

    init(json:JSON){
   
               crno = json["CRNO"].stringValue
              sl_no = json["SL_NO"].stringValue
              vital_name = json["VITAL_NAME"].stringValue
              vital_id = json["VITAL_ID"].stringValue
              vital_value = json["VITAL_VALUE"].stringValue

              record_date = json["RECORD_DATE"].stringValue
              vital_unit = json["VITAL_UNIT"].stringValue
              is_normal = json["IS_NORMAL"].stringValue
              hnum_is_servere = json["HNUM_IS_SEVERE"].stringValue
              
    }
}
