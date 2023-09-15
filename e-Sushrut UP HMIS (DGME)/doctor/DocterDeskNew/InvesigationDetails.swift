//
//  InvesigationDetails.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 25/07/23.
//

import Foundation
struct InvesigationDetails{
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
