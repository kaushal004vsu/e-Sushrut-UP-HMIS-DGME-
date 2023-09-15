//
//  FollowUp.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - FollowUp
class FollowUpEmr:  Codable {
    var endTreatment, instructionNote: String
    var plannedVisit: [PlannedVisit]
    var progressNote: String

    enum CodingKeys: String, CodingKey {
        case endTreatment, instructionNote
        case plannedVisit = "Planned_Visit"
        case progressNote
    }

    init(endTreatment: String, instructionNote: String, plannedVisit: [PlannedVisit], progressNote: String) {
        self.endTreatment = endTreatment
        self.instructionNote = instructionNote
        self.plannedVisit = plannedVisit
        self.progressNote = progressNote
    }
}
