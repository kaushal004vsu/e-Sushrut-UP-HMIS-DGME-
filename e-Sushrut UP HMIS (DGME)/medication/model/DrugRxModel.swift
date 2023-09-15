
import Foundation

struct DrugRxModel: Decodable {

  var medicationDetail : MedicationDetail? = MedicationDetail()

  enum CodingKeys: String, CodingKey {

    case medicationDetail = "medication_detail"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    medicationDetail = try values.decodeIfPresent(MedicationDetail.self , forKey: .medicationDetail )
 
  }

  init() {

  }

}
