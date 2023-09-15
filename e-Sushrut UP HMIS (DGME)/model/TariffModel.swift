//
//  JsonModel.swift
//  swiftyjson
//
//  Created by Yogesh Patel on 16/04/18.
//  Copyright © 2018 Yogesh Patel. All rights reserved.
//

import Foundation

struct TariffModel{
    var tariffName: String = ""
    var tariffCharge: String = ""
//    var artworkUrl100: String = ""
    init(){
        
    }
    
    init(json:JSON){
        tariffName = json["tariffName"].stringValue
        tariffCharge = json["tariffCharge"].stringValue
//        artworkUrl100 = json["artworkUrl100"].stringValue
    }
}
