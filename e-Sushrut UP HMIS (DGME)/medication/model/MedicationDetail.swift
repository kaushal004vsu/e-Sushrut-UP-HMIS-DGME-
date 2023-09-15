
import Foundation

struct MedicationDetail: Decodable {

  var total   : String?    = nil
  var recent  : [Recent]?  = []

  enum CodingKeys: String, CodingKey {

    case total   = "total"
    case recent  = "recent"
    case allData = "all_data"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    total   = try values.decodeIfPresent(String.self    , forKey: .total   )
    recent  = try values.decodeIfPresent([Recent].self  , forKey: .recent  )
 
  }

  init() {

  }

}
