//
//  MedicineModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 16/08/22.
//

import Foundation
struct MedicineModel
{
    var item_brand_id: String = ""
    var brand_name: String = ""

    init(){
        
    }
    
    init(json:JSON){
        item_brand_id = json["ITEM_BRAND_ID"].stringValue
        brand_name = json["BRAND_NAME"].stringValue
      
      
    }
}
