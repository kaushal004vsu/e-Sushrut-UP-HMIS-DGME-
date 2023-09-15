//
//  ShiftDetails.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 01/11/22.
//

import Foundation
struct ShiftDetails{
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
              shiftName = json["GETSHIFTNAME"].stringValue
              shiftst = json["SHIFTST"].stringValue
              shiftet = json["SHIFTET"].stringValue

              slotst = json["SLOTST"].stringValue
              slotet = json["SLOTET"].stringValue
              freeslotdetail = json["FREESLOTDETAIL"].stringValue
              slotstatus = json["GETSLOTSTATUS"].stringValue
              opdslots = json["OPDSLOTS"].stringValue
              ipdslots = json["IPDSLOTS"].stringValue
              opdbookedslots = json["OPDBOOKEDSLOTS"].stringValue
              ipdbookedslots = json["IPDBOOKEDSLOTS"].stringValue
    }
}
