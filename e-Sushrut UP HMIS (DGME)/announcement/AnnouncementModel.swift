//
//  AnnouncementModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//  Created by HICDAC on 09/05/23.
//

import Foundation
struct AnnouncementModel{
    var req_no="", subject="", publish_date="", valid_till="", document_file="", isNew="";
    var s_no="", date="",topic=""
    
    
    init(){}
    
    init(json:JSON){
        req_no = json["REQ_NO"].stringValue
        subject = json["SUBJECT"].stringValue
        publish_date = json["PUBLISH_DATE"].stringValue
        valid_till = json["VALID_TILL"].stringValue
        document_file = json["DOCUMENT_FILE"].stringValue
        isNew = json["IS_NEW"].stringValue
        
    }
    init(s_no:String,date:String,topic:String){
        self.s_no = s_no
        self.date = date
        self.topic = topic
    }
    
}
