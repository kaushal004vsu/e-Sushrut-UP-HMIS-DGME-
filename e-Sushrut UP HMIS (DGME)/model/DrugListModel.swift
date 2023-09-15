//
//  DrugList.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 16/08/22.
//

import Foundation
struct DrugListModel
{
    var storen_ame: String = ""
    var item: String = ""
    var qty: String = ""
    init(){
    }
    
    init(json:JSON){
        storen_ame = json["STORE_NAME"].stringValue
        item = json["ITEM"].stringValue
        qty = json["QTY"].stringValue
        
      
    }
}

