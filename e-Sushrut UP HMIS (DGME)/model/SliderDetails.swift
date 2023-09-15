//
//  SliderDetails.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 07/11/22.
//

import Foundation
struct SliderDetails{
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
