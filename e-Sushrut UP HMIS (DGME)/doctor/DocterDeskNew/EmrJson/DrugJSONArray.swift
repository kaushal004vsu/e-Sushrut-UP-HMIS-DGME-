//
//  DrugJSONArray.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - DrugJSONArray
class DrugJSONArray: Codable {
    var mode, doaseCode, doaseName, drugCode: String
    var drugDays, drugInstruction, drugName, drugQuantity: String
    var episodeCode, frequencyCode, frequencyName, isExterNal: String
    var startDate, visitNo: String

    enum CodingKeys: String, CodingKey {
        case mode = "Mode"
        case doaseCode = "DoaseCode"
        case doaseName = "DoaseName"
        case drugCode = "DrugCode"
        case drugDays = "DrugDays"
        case drugInstruction = "DrugInstruction"
        case drugName = "DrugName"
        case drugQuantity = "DrugQuantity"
        case episodeCode = "EpisodeCode"
        case frequencyCode = "FrequencyCode"
        case frequencyName = "FrequencyName"
        case isExterNal = "IsExterNal"
        case startDate = "StartDate"
        case visitNo = "VisitNo"
    }

    init(mode: String, doaseCode: String, doaseName: String, drugCode: String, drugDays: String, drugInstruction: String, drugName: String, drugQuantity: String, episodeCode: String, frequencyCode: String, frequencyName: String, isExterNal: String, startDate: String, visitNo: String) {
        self.mode = mode
        self.doaseCode = doaseCode
        self.doaseName = doaseName
        self.drugCode = drugCode
        self.drugDays = drugDays
        self.drugInstruction = drugInstruction
        self.drugName = drugName
        self.drugQuantity = drugQuantity
        self.episodeCode = episodeCode
        self.frequencyCode = frequencyCode
        self.frequencyName = frequencyName
        self.isExterNal = isExterNal
        self.startDate = startDate
        self.visitNo = visitNo
    }
}
