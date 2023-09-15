//
//  AppointmentSlotModel.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 18/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import Foundation
struct AppointmentSlotModel{
    var date = ""
    var shift = ""
    var shiftName = ""
    var shiftst = ""
    var shiftet = ""
    var slotst = ""
    var slotet = ""
    var freeslotdetail = ""
    var slotstatus = ""
    var opdslots = ""
    var ipdslots = ""
    var opdbookedslots = ""
    var ipdbookedslots=""


    init(){
        
    }

    init(json:JSON){
   
    
               date = json["DT"].stringValue
              shift = json["SHIFT"].stringValue
              shiftName = json["SHIFTNAME"].stringValue
              shiftst = json["SHIFTST"].stringValue
              shiftet = json["SHIFTET"].stringValue

              slotst = json["SLOTST"].stringValue
              slotet = json["SLOTET"].stringValue
              freeslotdetail = json["FREESLOTDETAIL"].stringValue
              slotstatus = json["SLOTSTATUS"].stringValue
              opdslots = json["OPDSLOTS"].stringValue
              ipdslots = json["IPDSLOTS"].stringValue
              opdbookedslots = json["OPDBOOKEDSLOTS"].stringValue
              ipdbookedslots = json["IPDBOOKEDSLOTS"].stringValue
    }
}
