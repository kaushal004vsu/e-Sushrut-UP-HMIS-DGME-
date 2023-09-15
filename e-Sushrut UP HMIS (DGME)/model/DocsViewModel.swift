//
//  DocsViewModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 14/07/22.
//

struct DocsViewModel: Decodable {
let documents_detail: DocumentDetail?
}

struct DocumentDetail: Decodable {
let all_data: [AllData2]?
let total: String?
}

struct AllData2: Decodable {

    let document_title: String?
    let document_content_type: String?
    let document_base64: String?
    
}


