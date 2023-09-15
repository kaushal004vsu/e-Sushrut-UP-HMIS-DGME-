//
//  DoctorHomeDetails.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 03/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import Foundation
struct DoctorHomeDetails{
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
