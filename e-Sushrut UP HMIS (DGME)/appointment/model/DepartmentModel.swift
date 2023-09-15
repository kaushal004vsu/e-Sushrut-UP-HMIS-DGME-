//
//  DepartmentModel.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 17/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import Foundation
struct DepartmentModel{
    var unitcode="";
    var loCode="";
    var  loName="";
    var  deptname="";
    var  workingDays="";
    var  newPatPortalLimit="";
    var  oldpatportallimit="";
    var  loweragelimit="";
    var  maxAgeLimit="";
    var  isrefer="";
    var  actualparameterreferenceid="";
    var  boundGenderCode="";
    var  isTeleconsUnit="";
    var  unitType="";
    var  unitTypeCode="";
    var  tariffId="";
    var  charge="";

    init(){
        
    }

    init(json:JSON){
   
        unitcode = json["UNITCODE"].stringValue
               loCode = json["LOCCODE"].stringValue
               loName = json["LOCNAME"].stringValue
               deptname = json["DEPTNAME"].stringValue
               workingDays = json["WORKINGDAYS"].stringValue
               newPatPortalLimit = json["NEWPATPORTALLIMIT"].stringValue
               oldpatportallimit = json["OLDPATPORTALLIMIT"].stringValue
               loweragelimit = json["LOWERAGELIMIT"].stringValue
               maxAgeLimit = json["MAXAGELIMIT"].stringValue

               isrefer = json["ISREFER"].stringValue

               actualparameterreferenceid = json["ACTUALPARAMETERREFERENCEID"].stringValue
               boundGenderCode = json["BOUNDGENDERCODE"].stringValue
               isTeleconsUnit = json["IS_TELECONS_UNIT"].stringValue
               unitType = json["UNIT_TYPE"].stringValue
               unitTypeCode = json["UNIT_TYPE_CODE"].stringValue
               tariffId = json["TARIFF_ID"].stringValue
               charge = json["CHARGE"].stringValue
    }
}
