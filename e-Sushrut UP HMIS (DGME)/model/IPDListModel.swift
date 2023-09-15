//
//  IPDLIstModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 08/07/22.
//

import Foundation
struct IPDListModel{
    var hospname="", deptname="", deathFlag="", accStatus="";
    var unit1="", puk="", finalBillFlg="", bedName="";
    var profileId="", name="", age_Sex="", ward="";
    var roomname="", unitName="", bedCode="", department="";
    var adm_no="", wardName="", admDateTime="", room="", distDateTime="";
    
    init(){}
    
    init(json:JSON){
        hospname = json["HOSP_NAME"].stringValue
        deptname = json["DEPT_NAME"].stringValue
        deathFlag = json["DEATHFLAG"].stringValue
        accStatus = json["ACCSTATUS"].stringValue
        unit1 = json["UNIT"].stringValue
        puk = json["PUK"].stringValue
        finalBillFlg = json["FINALBILLFLG"].stringValue
        bedName = json["BED_NAME"].stringValue
        profileId = json["PROFILEID"].stringValue
        name = json["NAME"].stringValue
        age_Sex = json["AGE_SEX"].stringValue
        ward = json["WARD"].stringValue
        roomname = json["ROOM_NAME"].stringValue
        unitName = json["UNIT_NAME"].stringValue
        bedCode = json["BEDCODE"].stringValue
        department = json["DEPT"].stringValue
        adm_no = json["ADM_NO"].stringValue
        wardName = json["WARD_NAME"].stringValue
        admDateTime = json["ADMDATETIME"].stringValue
        room = json["ROOM"].stringValue
        distDateTime = json["DISCDATETIME"].stringValue
}
    
}
