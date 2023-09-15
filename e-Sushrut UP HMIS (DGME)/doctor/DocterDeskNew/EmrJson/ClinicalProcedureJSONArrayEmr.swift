//
//  ClinicalProcedureJSONArray.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

import Foundation
// MARK: - ClinicalProcedureJSONArray
class ClinicalProcedureJSONArrayEmr: Codable {
    var isExternal, procedureCode, procedureSideCode, procedureSideName: String!
    var procedureSideRemarks, proceduresName, serviceAreaCode, serviceAreaName: String!
    var strSittingJSON: String!

    enum CodingKeys: String, CodingKey {
        case isExternal = "IsExternal"
        case procedureCode = "ProcedureCode"
        case procedureSideCode = "ProcedureSideCode"
        case procedureSideName = "ProcedureSideName"
        case procedureSideRemarks = "ProcedureSideRemarks"
        case proceduresName = "ProceduresName"
        case serviceAreaCode = "ServiceAreaCode"
        case serviceAreaName = "ServiceAreaName"
        case strSittingJSON = "strSittingJson"
    }

    init(){
        
    }
    init(isExternal: String, procedureCode: String, procedureSideCode: String, procedureSideName: String, procedureSideRemarks: String, proceduresName: String, serviceAreaCode: String, serviceAreaName: String, strSittingJSON: String) {
        self.isExternal = isExternal
        self.procedureCode = procedureCode
        self.procedureSideCode = procedureSideCode
        self.procedureSideName = procedureSideName
        self.procedureSideRemarks = procedureSideRemarks
        self.proceduresName = proceduresName
        self.serviceAreaCode = serviceAreaCode
        self.serviceAreaName = serviceAreaName
        self.strSittingJSON = strSittingJSON
    }
}
