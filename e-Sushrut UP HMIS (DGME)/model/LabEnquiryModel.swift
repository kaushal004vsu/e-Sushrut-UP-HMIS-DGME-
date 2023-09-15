//
//  LabEnquiryModel.swift
//  swiftyjson
//
//  Created by sudeep rai on 13/03/19.
//  Copyright © 2019 Yogesh Patel. All rights reserved.
//

import Foundation

struct LabEnquiryModel
{
    var testName: String = ""
    var labName: String = ""
    var testPrice: String = ""
    var isApptMandatory: String = ""
    init(){
        
    }
    
    
    
    init(json:JSON){
        testName = json["TEST_NAME"].stringValue
        labName = json["LAB_NAME"].stringValue
        testPrice = json["TEST_CHARGE"].stringValue
        isApptMandatory = json["IS_APPT_BASED"].stringValue
       
}
}
