//  File.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 05/06/22.


import Foundation
class ServiceUrl: NSObject {
    
    
//    Production
//    public static var ip:String="https://hmisdgmeup.prd.dcservices.in/"
   
//    Uat
        public static var ip:String="http://10.10.11.17:8082/"

    
//    development
//    public static var ip:String="http://10.226.21.136:8380/";
//    public static var ip:String="http://10.226.30.125:8380/";
    
    public static var mobileNo = "7042420714"
    //ndhm
    public static var ndhm:String="https://ndhmexchange.uat.dcservices.in/";
    public static var updateNdhmId =  ndhm + "railtelService/updateNdhmHealthId"
    
    //Jitsi url
    public static var jitsiUrl="https://mconsultancy.uat.dcservices.in";
    
    public static var hospCode="100";
    public static var hospId="99113";
    public static var hostName = "sailbokaro.uat.dcservices.in";
      public static var testurl:String=ip+"HISServices/service/";
    
    public static var tariffUrl=testurl+"tariff/tariffList?hospCode="
    public static var enquiryUrl=testurl+"consultant/consultantByDept?deptCode=0&hospCode="
    public static var labEnquiryUrl=testurl+"investigationtest/labtestlist?hospCode="
    public static var reportListUrl=testurl+"railtelService/getReportList?crno="
    public static var rxListurl=testurl+"railtelService/prescriptionList?hosCode=0&crno="
    public static var viewPdf=testurl+"invService/reportData?crNo=";
    public static var getPatDtlsFromcrno=testurl+"webServices/getPatDtlsFromMobile?modeval=1&mobileNo="
    public static var getPastWebPrescription=ip+"HISDRDESK/services/restful/patdata/digi?"
    
    
    public static var printWebPrescription = hostName+"/HISDRDESK/new_opd/transaction/DoctorDeskAction.cnt?hmode=MOBILEPRINTPRESC&crNo=";
    //Show hide
    public static var checkUpdateurl = testurl + "app/config?hospCode=" + hospCode + "&platform=ios&appVer=1&userCat=";
    //check update
    public static var checkUpdate=testurl+"app/config?hospCode=\(hospCode)&platform=ios&appVer=1&userCat="
    
    //OPD lite
    public static var opdLiteUrl=ip+"HISDRDESK/new_opd/transaction/DoctorDeskAction.cnt?hmode=NEW1&seat_id="
    
    
    //Appointment urls
    public static var getPreviousAppointmentsByCRNoUrl = testurl + "AppointmentService/getPreviousAppointmentsByCRNo?hospCode=100&patCRNo=";
    
    public static var getAppointmentSlots=testurl+"AppointmentService/getSpecialClinicSlot?hospCode=\(hospId)&aptDate=";
    
    public static var getHolidays=testurl+"econsultation/holidaylist?hospCode="+hospCode

    
    public static var makeAppointment = testurl + "genericAppointment/bookAppointment";
    
    public static var cancelAppointmentUrl = testurl + "AppointmentService/cancelAppointment";
    public static var rescheduleappointmenturl = testurl + "AppointmentService/rescheduleAppointment";
    
    public static var shiftNameurl = testurl + "AppointmentService/getAppointmentSlotsGeneric?";
    
    //eStamping
    public static var qrStampingUrl = testurl + "railtelUMIDService/callStampingService";
    public static var qmsListUrl = testurl + "genericAppointment/getpatEpisodeDtls/2?hospCode=0&patCrNo=";
    
    
    
    public static var admissionSlip = testurl + "admissionSlipService/List?crNo=";
    public static var downloadDischargeSlip = ip + "HISClinical/emr/uniPagePrescription.cnt?";
    public static var profileImage = testurl + "AppOpdService/getImageByCrNoAndUmid?crNo=";
    
    public static var uploadDocs=testurl+"webServices/uploadDocument"
    
    public static var view_docs = ip + "eSushrutEMRServices/service/ehr/get/patient/document/all?crNo=";
    public static var sickCertificate = testurl + "sickLeaveService/procSickDtl?hospcode=";
    public static var drugAvailabilty=testurl+"railtelService/getDrugAvailability?hospCode="
    public static var lpstatus=testurl+"jsp/lpStatus.jsp?crno="
    public static var teleconsultancyHospitalList=testurl+"eConsultReq/teleconsultancyHospitalList"

    
    //doctor urls
    public static var docRequestList = testurl + "eConsultReq/getRequestByDocEmpNo?docEmpNo=";
    public static var doctorLoginSalt=testurl+"login/salt"
    public static var doctorLoginUrl=testurl+"login/checkBeforeLogin?user="
    public static var getPastPrescription=testurl+"eConsultReq/getPastPrescription?hospCode="+hospCode
    public static var viewDocument = testurl + "eConsultReq/retriveImageData";
    /**
     teleconsulatancy services
     */
    public static var serverLegacyKey="key=AAAA_wN054A:APA91bFz4gupSTKaqoq-7fNsk6n-U5wRWeaPo50UNf1lbevOToha4Ac8jqewJKk5C5r4YaHY2Eu3cL3M2Ue9-F6cmztdgNF7ZNl33SnGVQm7SOMpKR0I2hqvXCBBpsJ_h5WrdQ7_ati-";
    
    
     public static var updateRequestStatus = testurl + "eConsultReq/updateRequestStatus?hospCode=";
     public static var generateEpisode = testurl + "eConsultReq/generateEpisodeWithReqNo?requestId=";
     public static var updateDoctorMessage = testurl + "eConsultReq/setDoctorMessage?requestID=";
     public static var viewRequestListByEmployeeCode = testurl + "eConsultReq/getRequestByDocEmpNo?docEmpNo=";
     public static var savePrescriptionUrl = testurl + "econsultation/savePrescription";
    
    ////
    public static var getSlots = testurl + "eConsultReq/getSpecialClinicSlot?hospCode=";
    public static var savePhrUrl = testurl + "AppOpdService/saveVitalDetails";
    
    public static var graphUrl = testurl + "AppOpdService/getVitalDetails?crno=";
    public static var viewRequestListByPatMobNo = testurl + "eConsultReq/getRequestPatMobNo/?patMobNo=";
    public static var bookAppointment = testurl + "eConsultReq/raiseRequestWithAppt";
    public static var teleconsultationsDepartments = testurl + "eConsultReq/getSpecialClinicsList?hospCode=";
    
    public static var feedbackUrl = testurl + "eConsultReq/patientFeedback";
    public static var getUpdateDoctorMessage = testurl + "econsultation/setMessage?";
    
    public static var getAppointmentDepartmens=testurl+"AppointmentService/getDeptUnitListGeneric?hospCode=\(hospId)&patRevisitFlag=0&patCrNo=";
    
    public static var getSlotsDateServer = testurl + "genericAppointment/getTotalAvailableSlots?pMode=1&pHospCode=";
    public static var getFamilyQrPdf = testurl + "webServices/getFamilyQrPdf?mobileNo=";
    //Announcement
    public static var announcement = testurl + "webServices/getAnnouncementListing?modeval=1&hospCode=";
    public static var downloadDocument = testurl + "econsultation/getDocumentBase64?fileName=";
    public static var FeedbackUrl = testurl + "railtelService/submitFeedback";

    public static var emrDesk = ip + "emrdashboard/patientOverviewAction.cnt?hmode=DETAIL&crno=";
    public static var generalInfoResource = ip + "HISServices/jsp/GeneralHealthResource.jsp";
    public static var divisionAndZoneWiseHospitalList = testurl + "railtelService/getHospitalList";
    //OPD
    public static var opdLiteDeptList=testurl+"AppOpdService/procDeptDtl?modeval=1&hospCode="
    public static var opdLiteDeptCodeWise=testurl+"AppOpdService/procPatientDtl?modeval=1&hospCode="
    
    public static var saveEhrJsonDataNew = testurl + "AppOpdService/saveAppEHRData";
    public static var saveEmrJsonData = testurl + "AppOpdService/saveGenralDataFormattedData";
    
    public static var getPatientDetailSavePrescription = testurl + "AppOpdService/patientDetail";
    public static var followUpService = testurl + "AppOpdService/followUpDTL";

}
