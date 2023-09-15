//
//  MenuDetails.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 04/06/22.
//

import Foundation
struct MenuDetails{
    var labelName: String = ""
    var iconName: String = ""
    var id:String = ""

    init(){
        
    }
    
    init(labelName:String,iconName:String,id:String){
        self.labelName = labelName
        self.iconName = iconName
        self.id = id
    }
}
