//
//  PatientSearchModel.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import UIKit

class PatientSearchModel{
var COLUMN: String = ""


init(){}

init(json:JSON){
    COLUMN = json["?COLUMN?"].stringValue
}


}
