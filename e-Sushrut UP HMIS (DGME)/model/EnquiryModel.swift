import Foundation


struct EnquiryModel{
    var deptName: String = ""
    var unitName: String = ""
    var location: String = ""
    var unitDays: String = ""
    var room: String=""
    
    init(){
        
    }

    init(json:JSON){
        deptName = json["deptName"].stringValue
        unitName = json["unitName"].stringValue
        location = json["location"].stringValue
        unitDays = json["unitDays"].stringValue
        room=json["roomName"].stringValue
        
    }
}
