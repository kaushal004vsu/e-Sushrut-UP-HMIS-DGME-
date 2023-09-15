//
//  departmentModel.swift
//  SAIL Rourkela
//
//  Created by HICDAC on 25/05/23.
//

import Foundation
struct OPDLiteDepartmentModel{
        var COLUMN: String = ""
        var UNITNAME: String = ""
        var HGSTR_UNITNAME: String = ""
     

        init(){}
        
        init(json:JSON){
            COLUMN = json["?COLUMN?"].stringValue
            UNITNAME = json["UNITNAME"].stringValue
            HGSTR_UNITNAME = json["HGSTR_UNITNAME"].stringValue
        }
   
    
}
