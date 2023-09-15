//
//  ProcedureDetails.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 27/07/23.
//

import Foundation
struct ProcedureDetails{
    var getInvestigation: String = ""
    var getSide: String = ""
    var getDescription:String = ""

    init(){
        
    }
    
    init(getInvestigation:String,getSide:String,getDescription:String){
        self.getInvestigation = getInvestigation
        self.getSide = getSide
        self.getDescription = getDescription
    }
}
