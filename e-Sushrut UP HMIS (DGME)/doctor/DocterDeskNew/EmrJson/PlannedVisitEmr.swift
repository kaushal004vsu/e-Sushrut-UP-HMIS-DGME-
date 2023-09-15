//
//  PlannedVisit.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - PlannedVisit
class PlannedVisitEmr:  Codable {
    var plannedVisitDate, plannedVisitDays, plannedVisitSos: String

    init(plannedVisitDate: String, plannedVisitDays: String, plannedVisitSos: String) {
        self.plannedVisitDate = plannedVisitDate
        self.plannedVisitDays = plannedVisitDays
        self.plannedVisitSos = plannedVisitSos
    }
}
