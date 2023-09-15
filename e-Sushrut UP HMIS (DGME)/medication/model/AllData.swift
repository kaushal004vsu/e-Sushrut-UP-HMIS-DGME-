
import Foundation

struct AllData1: Codable {

  var encounterDetail : EncounterDetail? = EncounterDetail()
  var medications     : [Medications]?   = []

  enum CodingKeys: String, CodingKey {

    case encounterDetail = "encounter_detail"
    case medications     = "medications"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    encounterDetail = try values.decodeIfPresent(EncounterDetail.self , forKey: .encounterDetail )
    medications     = try values.decodeIfPresent([Medications].self   , forKey: .medications     )
 
  }

  init() {

  }

}
