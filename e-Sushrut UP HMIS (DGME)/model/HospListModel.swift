//
//  HospListModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 17/08/22.
//

import Foundation

struct HospListModel{
        let hospCode: String
        let hospName: String
        let hospEmail: String
        let hospPhone: String
        let hospAddr: String
    
    init(json:JSON){
            hospCode = json["hospCode"].stringValue
            hospName = json["hospName"].stringValue
            hospEmail = json["hospEmail"].stringValue
            hospPhone = json["hospPhone"].stringValue
            hospAddr = json["hospAddr"].stringValue
        }
}

//struct HospListModel: Decodable {
//    let post: [SinglePost]
//}
//
//struct SinglePost: Decodable{
//    let hospCode: String
//    let hospName: String
//    let hospEmail: String
//    let hospPhone: String
//    let hospAddr: String
//
//
//
//    init(json:JSON){
//        hospCode = json["hospCode"].stringValue
//        hospName = json["hospName"].stringValue
//        hospEmail = json["hospEmail"].stringValue
//        hospPhone = json["hospPhone"].stringValue
//        hospAddr = json["hospAddr"].stringValue
//    }
//
//}
