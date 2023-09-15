//
//  SavePrescription.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 14/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import Foundation
struct SavePrescription: Codable
{
    var pat_data:PatientRequestDetails=PatientRequestDetails()
    var pres_data:PresData=PresData()
    
   
    init(pat_data:PatientRequestDetails,pres_data:PresData) {
        self.pat_data=pat_data
        self.pres_data=pres_data
        
        
    }
    

}
