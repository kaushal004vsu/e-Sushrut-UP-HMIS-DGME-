//
//  ProcedureModel.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 27/07/23.
//

import Foundation
struct ProcedureModel{
        var PROCEDURE_DETAIL: String = ""
        var PROCEDURE_NAME: String = ""
        var SERVICE_AREA_CODE: String = ""
        var SERVICE_AREA_NAME: String = ""
        
      
        init(){}
        
        init(json:JSON){
            PROCEDURE_DETAIL = json["PROCEDURE_DETAIL"].stringValue
            PROCEDURE_NAME = json["PROCEDURE_NAME"].stringValue
            SERVICE_AREA_CODE = json["SERVICE_AREA_CODE"].stringValue
            SERVICE_AREA_NAME = json["SERVICE_AREA_NAME"].stringValue
           
           
        }
   
    
}
