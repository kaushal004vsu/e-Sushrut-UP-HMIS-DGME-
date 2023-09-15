//
//  CompleteHistoryJaonArray.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - CompleteHistoryJaonArray
class CompleteHistoryJaonArrayEmr: Codable {
    var strfamilyHistory, strpastHistory, strpersonalHistory, strsurgicalHistory: String!
    var strtreatmentHistory: String!

    init(){}
    init(strfamilyHistory: String, strpastHistory: String, strpersonalHistory: String, strsurgicalHistory: String, strtreatmentHistory: String) {
        self.strfamilyHistory = strfamilyHistory
        self.strpastHistory = strpastHistory
        self.strpersonalHistory = strpersonalHistory
        self.strsurgicalHistory = strsurgicalHistory
        self.strtreatmentHistory = strtreatmentHistory
    }
}
