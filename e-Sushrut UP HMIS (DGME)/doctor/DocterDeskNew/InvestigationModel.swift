//
//  File.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import Foundation

struct InvestigationModel{
        var TEST_DETAIL: String = ""
        var TEST_NAME: String = ""
        var LABNAME: String = ""
        var COLORTESTNAME: String = ""
        var SAMPLECODE: String = ""
        var TARIFF: String = ""
        var VISIT_DATE: String = ""
        var ISCONSENTREQUIRED: String = ""
      
        init(){}
        
        init(json:JSON){
            TEST_DETAIL = json["TEST_DETAIL"].stringValue
            TEST_NAME = json["TEST_NAME"].stringValue
            LABNAME = json["LABNAME"].stringValue
            COLORTESTNAME = json["COLORTESTNAME"].stringValue
            SAMPLECODE = json["SAMPLECODE"].stringValue
            TARIFF = json["TARIFF"].stringValue
            VISIT_DATE = json["VISIT_DATE"].stringValue
            ISCONSENTREQUIRED = json["ISCONSENTREQUIRED"].stringValue
           
        }
   
    
}
