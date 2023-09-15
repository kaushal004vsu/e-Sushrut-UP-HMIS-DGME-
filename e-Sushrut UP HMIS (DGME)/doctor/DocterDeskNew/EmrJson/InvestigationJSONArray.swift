//
//  InvestigationJSONArray.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - InvestigationJSONArray
class InvestigationJSONArray: Codable {
    var episodeCode, isExternal, isTestGroup, labCode: String
    var labName, sampleCode, sampleName, sideCode: String
    var sideName, sideRemarks, testCode, testName: String
    var visitNo, isConsent, tariffID: String

    enum CodingKeys: String, CodingKey {
        case episodeCode = "EpisodeCode"
        case isExternal = "IsExternal"
        case isTestGroup = "IsTestGroup"
        case labCode = "LabCode"
        case labName = "LabName"
        case sampleCode = "SampleCode"
        case sampleName = "SampleName"
        case sideCode = "SideCode"
        case sideName = "SideName"
        case sideRemarks = "SideRemarks"
        case testCode = "TestCode"
        case testName = "TestName"
        case visitNo = "VisitNo"
        case isConsent
        case tariffID = "tariffId"
    }

    init(episodeCode: String, isExternal: String, isTestGroup: String, labCode: String, labName: String, sampleCode: String, sampleName: String, sideCode: String, sideName: String, sideRemarks: String, testCode: String, testName: String, visitNo: String, isConsent: String, tariffID: String) {
        self.episodeCode = episodeCode
        self.isExternal = isExternal
        self.isTestGroup = isTestGroup
        self.labCode = labCode
        self.labName = labName
        self.sampleCode = sampleCode
        self.sampleName = sampleName
        self.sideCode = sideCode
        self.sideName = sideName
        self.sideRemarks = sideRemarks
        self.testCode = testCode
        self.testName = testName
        self.visitNo = visitNo
        self.isConsent = isConsent
        self.tariffID = tariffID
    }
}
