//
//  PiccleArray.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 02/08/23.
//

// MARK: - PiccleArray
class PiccleArray: Codable {
    var strclubbing, strcyanosis, stredema, stricterus: String
    var striymphadenopathyID, strpallor: String

    enum CodingKeys: String, CodingKey {
        case strclubbing, strcyanosis, stredema, stricterus
        case striymphadenopathyID = "striymphadenopathyId"
        case strpallor
    }

    init(strclubbing: String, strcyanosis: String, stredema: String, stricterus: String, striymphadenopathyID: String, strpallor: String) {
        self.strclubbing = strclubbing
        self.strcyanosis = strcyanosis
        self.stredema = stredema
        self.stricterus = stricterus
        self.striymphadenopathyID = striymphadenopathyID
        self.strpallor = strpallor
    }
}
