//
//  QMSList.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 12/06/22.
//

import Foundation

struct QMSListModel{
    
    var patcrno="", episodecode="", visitno="", visittype="";
    var deptunitcode="", isepisodeopen="", episodestartdate="", episodetariff="";
    var hospname="", hospcode="", queueno="", roomname="";
    var deptname="", deptunitname="", printedon="", umid="";
    var patname="", age="", gendercode="";
    init(){}
    
    
    
    init(json:JSON){
        patcrno = json["PATCRNO"].stringValue
        episodecode = json["EPISODECODE"].stringValue
        visitno = json["VISITNO"].stringValue
        visittype = json["VISITTYPE"].stringValue
        deptunitcode = json["DEPTUNITCODE"].stringValue
        isepisodeopen = json["ISEPISODEOPEN"].stringValue
        episodestartdate = json["EPISODESTARTDATE"].stringValue
        episodetariff = json["EPISODETARIFF"].stringValue
        hospname  = json["HOSPNAME"].stringValue
        hospcode = json["HOSPCODE"].stringValue
        queueno = json["QUEUENO"].stringValue
        roomname = json["ROOMNAME"].stringValue
        deptname = json["DEPTNAME"].stringValue
        deptunitname = json["DEPTUNITNAME"].stringValue
        printedon = json["PRINTEDON"].stringValue
        umid = json["UMID"].stringValue
        patname = json["PATNAME"].stringValue
        age = json["AGE"].stringValue
        gendercode = json["GENDERCODE"].stringValue
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       
}
}
