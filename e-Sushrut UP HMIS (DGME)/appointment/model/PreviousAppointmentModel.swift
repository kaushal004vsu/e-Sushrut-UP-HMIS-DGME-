//
//  PreviousAppointmentModel.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 16/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import Foundation

struct PreviousAppointmentModel{
    var appointmentno:String  = "";
    var patcrno:String = "";
    var episodecode:String = "";
    var patfirstname:String = "";
    var patmiddlename:String = "";
    var patlastname:String = "";
    var patguardianname:String = "";
    var patgendercode:String = "";
    var emailid:String = "";
    var mobileno:String = "";
    var appointmentqueueno:String = "";
    var appointmenttime:String = "";
    var appointmentstatus:String = "";
    var statusremarks:String = "";
    var slottype:String = "";
    var remarks:String = "";
    var appointmenttypeid:String = "";
    var modulespecificcode:String = "";
    var appointmentmode:String = "";
    var modulespecifickeyname:String = "";
    var patage:String = "";
    var patspousename:String = "";
    var appointmentdate:String = "";
    var appointmentforid:String = "";
    var appointmentforname:String = "";
    var actulaparaid1:String = "";
    var actulaparaid2:String = "";
    var actulaparaid3:String = "";
    var actulaparaid4:String = "";
    var actulaparaid5:String = "";
    var actulaparaid6:String = "";
    var actulaparaid7:String = "";
    var actulaparaname1:String = "";
    var actulaparaname2:String = "";
    var actulaparaname3:String = "";
    var actulaparaname4:String = "";
    var actulaparaname5:String = "";
    var actulaparaname6:String = "";
    var actulaparaname7:String = "";
    
    var isFeesPaid:String = ""
    var hospCode:String = "";
    var hospName:String = "";
    var actualParaRefId:String = "";

    
    init(){
        }
    
    init(json:JSON){
    
         appointmentno = json["APPOINTMENTNO"].stringValue
         patcrno = json["PATCRNO"].stringValue
         episodecode = json["EPISODECODE"].stringValue
         patfirstname = json["PATFIRSTNAME"].stringValue
         patmiddlename = json["PATMIDDLENAME"].stringValue
         patlastname = json["PATLASTNAME"].stringValue
         patguardianname = json["PATGUARDIANNAME"].stringValue
         patgendercode = json["PATGENDERCODE"].stringValue
         emailid = json["EMAILID"].stringValue
         mobileno = json["MOBILENO"].stringValue
         appointmentqueueno = json["APPOINTMENTQUEUENO"].stringValue
         appointmenttime = json["APPOINTMENTTIME"].stringValue
         appointmentstatus = json["APPOINTMENTSTATUS"].stringValue
         statusremarks = json["STATUSREMARKS"].stringValue
         slottype = json["SLOTTYPE"].stringValue
         remarks = json["REMARKS"].stringValue
         appointmenttypeid = json["APPOINTMENTTYPEID"].stringValue
         modulespecificcode = json["MODULESPECIFICCODE"].stringValue
         appointmentmode = json["APPOINTMENTMODE"].stringValue
         modulespecifickeyname = json["MODULESPECIFICKEYNAME"].stringValue
         patage = json["PATAGE"].stringValue
         patspousename = json["PATSPOUSENAME"].stringValue
         appointmentdate = json["APPOINTMENTDATE"].stringValue
         appointmentforid = json["APPOINTMENTFORID"].stringValue
         appointmentforname = json["APPOINTMENTFORNAME"].stringValue
         actulaparaid1 = json["ACTUALPARAID1"].stringValue
         actulaparaid2 = json["ACTUALPARAID2"].stringValue
         actulaparaid3 = json["ACTUALPARAID3"].stringValue
         actulaparaid4 = json["ACTUALPARAID4"].stringValue
         actulaparaid5 = json["ACTUALPARAID5"].stringValue
         actulaparaid6 = json["ACTUALPARAID6"].stringValue
         actulaparaid7 = json["ACTUALPARAID7"].stringValue
         actulaparaname1 = json["ACTUALPARANAME1"].stringValue
         actulaparaname2 = json["ACTUALPARANAME2"].stringValue
         actulaparaname3 = json["ACTUALPARANAME3"].stringValue
         actulaparaname4 = json["ACTUALPARANAME4"].stringValue
         actulaparaname5 = json["ACTUALPARANAME5"].stringValue
         actulaparaname6 = json["ACTUALPARANAME6"].stringValue
         actulaparaname7 = json["ACTUALPARANAME7"].stringValue
        
        isFeesPaid = json["IS_FEES_PAID"].stringValue
        hospCode = json["HOSP_CODE"].stringValue
        hospName = json["HOSP_NAME"].stringValue
        actualParaRefId = json["PARA_REFID"].stringValue
        
    }
}
