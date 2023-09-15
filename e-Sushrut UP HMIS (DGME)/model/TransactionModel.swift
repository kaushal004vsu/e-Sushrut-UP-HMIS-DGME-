//
//  TransactionModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 12/08/22.
//

import Foundation
struct TransactionModel
{
    var tran_no: String = ""
    var trans_date: String = ""
    var reciept_no: String = ""
    var deducted: String = ""
    var deposit: String = ""
    var hosp_code: String = ""
    var hosp_name: String = ""


    init(){
        
    }
    
    init(json:JSON){
        tran_no = json["TRANS_NO"].stringValue
        trans_date = json["TRANS_DATE"].stringValue
        reciept_no = json["RECIEPTNO"].stringValue
        deducted = json["DEDUCTED"].stringValue
        deposit = json["DEPOSIT"].stringValue
        hosp_code = json["HOSP_CODE"].stringValue
        hosp_name = json["HOSP_NAME"].stringValue
      
    }
}
