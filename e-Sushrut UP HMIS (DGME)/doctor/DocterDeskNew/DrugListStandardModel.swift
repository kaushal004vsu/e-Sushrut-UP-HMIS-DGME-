//
//  DrugListStandardModel.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 28/07/23.
//

import Foundation
struct DrugListStandardModel{
        var VALUE: String = ""
        var LABEL: String = ""
        var QTY: String = ""
        var EXPDATE: String = ""
        var MFCDATE: String = ""
        var RATE: String = ""
        var QUANTITY: String = ""
        var ITEM_GROUP_NAME: String = ""
        var ITEM_TYPE_NAME: String = ""
        var DRUG_CODE: String = ""
        var ITEM_TYPE_SHORT_NAME: String = ""
        
     

        init(){}
        
        init(json:JSON){
            VALUE = json["VALUE"].stringValue
            LABEL = json["LABEL"].stringValue
            QTY = json["QTY"].stringValue
            EXPDATE = json["EXPDATE"].stringValue
            MFCDATE = json["MFCDATE"].stringValue
            RATE = json["RATE"].stringValue
            QUANTITY = json["QUANTITY"].stringValue
            ITEM_GROUP_NAME = json["ITEM_GROUP_NAME"].stringValue
            ITEM_TYPE_NAME = json["ITEM_TYPE_NAME"].stringValue
            DRUG_CODE = json["DRUG_CODE"].stringValue
            ITEM_TYPE_SHORT_NAME = json["ITEM_TYPE_SHORT_NAME"].stringValue
           
        }
   
    
}
