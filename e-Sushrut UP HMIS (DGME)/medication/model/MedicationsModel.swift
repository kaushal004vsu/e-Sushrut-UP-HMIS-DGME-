//
//  MedicationsModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 13/05/23.
//

import Foundation
struct MedicationsModel
{
    var drug_name: String = ""
    var advise_date: String = ""
    var adviced_qty: String = ""
    var issue_qty: String = ""
   

    
    init(){}
    init(json:JSON){
        drug_name = json["drug_name"].stringValue
        advise_date = json["advise_date"].stringValue
        adviced_qty = json["adviced_qty"].stringValue
        issue_qty = json["issue_qty"].stringValue
    }
}
