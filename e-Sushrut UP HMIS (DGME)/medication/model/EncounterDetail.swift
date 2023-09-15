
import Foundation

struct EncounterDetail: Codable {

  var crNo                : String? = nil
  var encounterType       : String? = nil
  var encounterTypeCode   : String? = nil
  var isCurrent           : String? = nil
  var hospitalCode        : String? = nil
  var episodeCode         : String? = nil
  var episodeVisitNo      : String? = nil
  var admissionNo         : String? = nil
  var department          : String? = nil
  var departmentCode      : String? = nil
  var unit                : String? = nil
  var unitCode            : String? = nil
  var ward                : String? = nil
  var wardCode            : String? = nil
  var room                : String? = nil
  var roomCode            : String? = nil
  var bed                 : String? = nil
  var bedCode             : String? = nil
  var encounterStatus     : String? = nil
  var encounterStatusCode : String? = nil
  var visitDate           : String? = nil
  var admissionDatetime   : String? = nil
  var encounterDate       : String? = nil
  var encounterStartDate  : String? = nil
  var encounterEndDate    : String? = nil
  var dischargeDatetime   : String? = nil
  var byUserCode          : String? = nil
  var byUserName          : String? = nil
  var byUserDesg          : String? = nil
  var hospitalName        : String? = nil

  enum CodingKeys: String, CodingKey {

    case crNo                = "cr_no"
    case encounterType       = "encounter_type"
    case encounterTypeCode   = "encounter_type_code"
    case isCurrent           = "is_current"
    case hospitalCode        = "hospital_code"
    case episodeCode         = "episode_code"
    case episodeVisitNo      = "episode_visit_no"
    case admissionNo         = "admission_no"
    case department          = "department"
    case departmentCode      = "department_code"
    case unit                = "unit"
    case unitCode            = "unit_code"
    case ward                = "ward"
    case wardCode            = "ward_code"
    case room                = "room"
    case roomCode            = "room_code"
    case bed                 = "bed"
    case bedCode             = "bed_code"
    case encounterStatus     = "encounter_status"
    case encounterStatusCode = "encounter_status_code"
    case visitDate           = "visit_date"
    case admissionDatetime   = "admission_datetime"
    case encounterDate       = "encounter_date"
    case encounterStartDate  = "encounter_start_date"
    case encounterEndDate    = "encounter_end_date"
    case dischargeDatetime   = "discharge_datetime"
    case byUserCode          = "by_user_code"
    case byUserName          = "by_user_name"
    case byUserDesg          = "by_user_desg"
    case hospitalName        = "hospital_name"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    crNo                = try values.decodeIfPresent(String.self , forKey: .crNo                )
    encounterType       = try values.decodeIfPresent(String.self , forKey: .encounterType       )
    encounterTypeCode   = try values.decodeIfPresent(String.self , forKey: .encounterTypeCode   )
    isCurrent           = try values.decodeIfPresent(String.self , forKey: .isCurrent           )
    hospitalCode        = try values.decodeIfPresent(String.self , forKey: .hospitalCode        )
    episodeCode         = try values.decodeIfPresent(String.self , forKey: .episodeCode         )
    episodeVisitNo      = try values.decodeIfPresent(String.self , forKey: .episodeVisitNo      )
    admissionNo         = try values.decodeIfPresent(String.self , forKey: .admissionNo         )
    department          = try values.decodeIfPresent(String.self , forKey: .department          )
    departmentCode      = try values.decodeIfPresent(String.self , forKey: .departmentCode      )
    unit                = try values.decodeIfPresent(String.self , forKey: .unit                )
    unitCode            = try values.decodeIfPresent(String.self , forKey: .unitCode            )
    ward                = try values.decodeIfPresent(String.self , forKey: .ward                )
    wardCode            = try values.decodeIfPresent(String.self , forKey: .wardCode            )
    room                = try values.decodeIfPresent(String.self , forKey: .room                )
    roomCode            = try values.decodeIfPresent(String.self , forKey: .roomCode            )
    bed                 = try values.decodeIfPresent(String.self , forKey: .bed                 )
    bedCode             = try values.decodeIfPresent(String.self , forKey: .bedCode             )
    encounterStatus     = try values.decodeIfPresent(String.self , forKey: .encounterStatus     )
    encounterStatusCode = try values.decodeIfPresent(String.self , forKey: .encounterStatusCode )
    visitDate           = try values.decodeIfPresent(String.self , forKey: .visitDate           )
    admissionDatetime   = try values.decodeIfPresent(String.self , forKey: .admissionDatetime   )
    encounterDate       = try values.decodeIfPresent(String.self , forKey: .encounterDate       )
    encounterStartDate  = try values.decodeIfPresent(String.self , forKey: .encounterStartDate  )
    encounterEndDate    = try values.decodeIfPresent(String.self , forKey: .encounterEndDate    )
    dischargeDatetime   = try values.decodeIfPresent(String.self , forKey: .dischargeDatetime   )
    byUserCode          = try values.decodeIfPresent(String.self , forKey: .byUserCode          )
    byUserName          = try values.decodeIfPresent(String.self , forKey: .byUserName          )
    byUserDesg          = try values.decodeIfPresent(String.self , forKey: .byUserDesg          )
    hospitalName        = try values.decodeIfPresent(String.self , forKey: .hospitalName        )
 
  }

  init() {

  }

}