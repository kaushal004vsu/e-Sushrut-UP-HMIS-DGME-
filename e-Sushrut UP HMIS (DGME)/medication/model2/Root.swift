//
//  Root.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 02/05/23.
//

import Foundation
// MARK: - Root
struct Root: Codable {
//    let total: String
//    let recent: [Recent]
    let all_data: [AllData]
}
// MARK: - Datum
struct AllData: Codable {
    let encounter_detail: String
    let medications: [Medications]
}

//// MARK: - Job
//struct Job: Codable {
//    let order_status: String
//    let drug_name, jobDesc, jobDate, jobVenue: String
//    let jobAccept: String
//
//    enum CodingKeys: String, CodingKey {
//        case jobID = "jobId"
//        case drug_name, drug_code, generic_drug_code, jobVenue, jobAccept
//    }
//}
