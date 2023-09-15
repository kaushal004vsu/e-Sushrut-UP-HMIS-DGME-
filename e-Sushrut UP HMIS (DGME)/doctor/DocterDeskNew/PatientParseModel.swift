//
//  PatientParseModel.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import Foundation
struct PatientParseModel: Decodable {
    let patCrNo: String
    let patIdno: String
    let patdob: String
    let patfirstname: String
    let patmiddlename: String
    let patlastname: String
    let isActualDob: String
    let patAgeWithUnit: String
    let patGenderCode: String
    let patgender: String
    let patGuardianName: String
    let patMotherName: String
    let patAadharNo: String
    let patAddPhoneNo: String
    let patAddMobileNo: String
    let patAddHNo: String
    let patAddStreet: String
    let patAddLandMarks: String
    let patadddistrict: String
    let pataddstate: String
    let pataddcountry: String
    let relation: String

}
