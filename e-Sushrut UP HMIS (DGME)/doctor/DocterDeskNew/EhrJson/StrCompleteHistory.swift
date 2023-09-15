//
//  StrCompleteHistory.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - StrCompleteHistory
class StrCompleteHistory: Codable {
    var strfamilyHistory, strpastHistory, strpersonalHistory, strsurgicalHistory: String
    var strtreatmentHistory: String

    init(strfamilyHistory: String, strpastHistory: String, strpersonalHistory: String, strsurgicalHistory: String, strtreatmentHistory: String) {
        self.strfamilyHistory = strfamilyHistory
        self.strpastHistory = strpastHistory
        self.strpersonalHistory = strpersonalHistory
        self.strsurgicalHistory = strsurgicalHistory
        self.strtreatmentHistory = strtreatmentHistory
    }
}
