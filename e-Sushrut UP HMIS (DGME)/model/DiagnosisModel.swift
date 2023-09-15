//
//  DiagnosisModel.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 26/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import Foundation
struct DiagnosisModel{
    var term: String = ""
    var id: String = ""

    init(){
        
    }
    
    init(term:String,id:String){
        self.term = term
            self.id = id
    }
}
