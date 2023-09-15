//
//  ChronicDiseaseArray.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 03/08/23.
//

import Foundation

// MARK: - ChronicDiseaseArray this is blank array
class ChronicDiseaseArray: Codable {
    var blankStr: String!

    enum CodingKeys: String, CodingKey {
        case blankStr = "blankStr"
      
    }

    init(){
        
    }
    init(blankStr: String) {
        self.blankStr = blankStr
       
    }
}
