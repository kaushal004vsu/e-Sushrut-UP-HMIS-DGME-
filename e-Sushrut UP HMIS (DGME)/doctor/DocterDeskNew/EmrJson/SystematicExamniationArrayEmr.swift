//
//  SystematicExamniationArray.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - SystematicExamniationArray
class SystematicExamniationArrayEmr: Codable {
    var strLocalExamn, strcns, strcvs, strmuscularExamn: String
    var strotherExamn, strpA, strrs: String

    init(strLocalExamn: String, strcns: String, strcvs: String, strmuscularExamn: String, strotherExamn: String, strpA: String, strrs: String) {
        self.strLocalExamn = strLocalExamn
        self.strcns = strcns
        self.strcvs = strcvs
        self.strmuscularExamn = strmuscularExamn
        self.strotherExamn = strotherExamn
        self.strpA = strpA
        self.strrs = strrs
    }
}
