//
//  PresData.swift
//  CustomDialogBox
//
//  Created by sudeep rai on 13/09/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation
struct PresData:Codable{
    var pres_complaint: String = ""
    var pres_history:String=""
    var pres_examination:String=""
    var pres_diagnosis: String = ""
    var pres_test:String=""
    var pres_procedure:String=""
    var pres_treatment:String=""
    var pres_vitals:String=""
    var pres_diagnosis_type:String=""
    var isattended:String=""
    var pres_drug:String=""
   
    init()
    {
        
    }
    init( chiefComplaints: String,history:String,Examinations:String,diagnosis:String,tests:String,procedures:String,rx:String,vitals:String,pres_diagnosis_type:String)
    {
        self.pres_complaint=chiefComplaints
        self.pres_history=history
        self.pres_examination=Examinations
        self.pres_diagnosis=diagnosis
        self.pres_test=tests
        self.pres_procedure=procedures
        self.pres_treatment=rx
        self.pres_vitals=vitals
        pres_drug=""
        self.pres_diagnosis_type=pres_diagnosis_type
    }
}
