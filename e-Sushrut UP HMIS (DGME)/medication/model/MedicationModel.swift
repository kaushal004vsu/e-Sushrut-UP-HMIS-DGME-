//
//  DrugListModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 02/05/23.
//

import Foundation
struct MedicationModel{
    var encounter_detail=""
    var medications=""

    init(){}
    init(json:JSON){
        encounter_detail = json["encounter_detail"].object as! String
        medications = json["medications"].object as! String
}
    
}
