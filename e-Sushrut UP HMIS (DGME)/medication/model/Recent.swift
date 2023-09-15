
import Foundation

struct Recent: Codable {

  var orderStatus     : String?          = nil
  var drugName        : String?          = nil
  var drugCode        : String?          = nil
  var genericDrugCode : String?          = nil
  var genericDrugName : String?          = nil
  var drugTypeCode    : String?          = nil
  var codeType        : String?          = nil
  var drugType        : String?          = nil
  var crNo            : String?          = nil
  var hospitalCode    : String?          = nil
  var episodeCode     : String?          = nil
  var episodeVisitNo  : String?          = nil
  var admissionNo     : String?          = nil
  var encounterDetail : EncounterDetail? = EncounterDetail()
  var frequencyCode   : String?          = nil
  var dosageCode      : String?          = nil
  var quantity        : String?          = nil
  var dosage          : String?          = nil
  var routeCode       : String?          = nil
  var noOfDays        : String?          = nil
  var startDate       : String?          = nil
  var endDate         : String?          = nil
  var isRunning       : String?          = nil
  var adviseDate      : String?          = nil
  var advicedQty      : String?          = nil
  var issueQty        : String?          = nil

  enum CodingKeys: String, CodingKey {

    case orderStatus     = "order_status"
    case drugName        = "drug_name"
    case drugCode        = "drug_code"
    case genericDrugCode = "generic_drug_code"
    case genericDrugName = "generic_drug_name"
    case drugTypeCode    = "drug_type_code"
    case codeType        = "code_type"
    case drugType        = "drug_type"
    case crNo            = "cr_no"
    case hospitalCode    = "hospital_code"
    case episodeCode     = "episode_code"
    case episodeVisitNo  = "episode_visit_no"
    case admissionNo     = "admission_no"
    case encounterDetail = "encounter_detail"
    case frequencyCode   = "frequency_code"
    case dosageCode      = "dosage_code"
    case quantity        = "quantity"
    case dosage          = "dosage"
    case routeCode       = "route_code"
    case noOfDays        = "no_of_days"
    case startDate       = "start_date"
    case endDate         = "end_date"
    case isRunning       = "is_running"
    case adviseDate      = "advise_date"
    case advicedQty      = "adviced_qty"
    case issueQty        = "issue_qty"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    orderStatus     = try values.decodeIfPresent(String.self          , forKey: .orderStatus     )
    drugName        = try values.decodeIfPresent(String.self          , forKey: .drugName        )
    drugCode        = try values.decodeIfPresent(String.self          , forKey: .drugCode        )
    genericDrugCode = try values.decodeIfPresent(String.self          , forKey: .genericDrugCode )
    genericDrugName = try values.decodeIfPresent(String.self          , forKey: .genericDrugName )
    drugTypeCode    = try values.decodeIfPresent(String.self          , forKey: .drugTypeCode    )
    codeType        = try values.decodeIfPresent(String.self          , forKey: .codeType        )
    drugType        = try values.decodeIfPresent(String.self          , forKey: .drugType        )
    crNo            = try values.decodeIfPresent(String.self          , forKey: .crNo            )
    hospitalCode    = try values.decodeIfPresent(String.self          , forKey: .hospitalCode    )
    episodeCode     = try values.decodeIfPresent(String.self          , forKey: .episodeCode     )
    episodeVisitNo  = try values.decodeIfPresent(String.self          , forKey: .episodeVisitNo  )
    admissionNo     = try values.decodeIfPresent(String.self          , forKey: .admissionNo     )
    encounterDetail = try values.decodeIfPresent(EncounterDetail.self , forKey: .encounterDetail )
    frequencyCode   = try values.decodeIfPresent(String.self          , forKey: .frequencyCode   )
    dosageCode      = try values.decodeIfPresent(String.self          , forKey: .dosageCode      )
    quantity        = try values.decodeIfPresent(String.self          , forKey: .quantity        )
    dosage          = try values.decodeIfPresent(String.self          , forKey: .dosage          )
    routeCode       = try values.decodeIfPresent(String.self          , forKey: .routeCode       )
    noOfDays        = try values.decodeIfPresent(String.self          , forKey: .noOfDays        )
    startDate       = try values.decodeIfPresent(String.self          , forKey: .startDate       )
    endDate         = try values.decodeIfPresent(String.self          , forKey: .endDate         )
    isRunning       = try values.decodeIfPresent(String.self          , forKey: .isRunning       )
    adviseDate      = try values.decodeIfPresent(String.self          , forKey: .adviseDate      )
    advicedQty      = try values.decodeIfPresent(String.self          , forKey: .advicedQty      )
    issueQty        = try values.decodeIfPresent(String.self          , forKey: .issueQty        )
 
  }

  init() {

  }

}