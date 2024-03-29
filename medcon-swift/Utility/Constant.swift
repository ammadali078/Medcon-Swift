//
//  Constant.swift
//  medcon-swift
//
//  Created by macbook on 13/09/2022.
//

import Foundation

class Constants {
//        static let BaseUrl = "http://192.168.100.101/"
    static let BaseLogin = "http://sante.digitrends.pk/"
    static let BaseUrl = "http://sante-visitplanner.digitrends.pk/"
    static let DcrBaseUrl = "http://sante-dcr.digitrends.pk/"
    static var isLoginPerform: Bool = false
    static var CheckForUpdateUrl: String = BaseUrl + "/Content/mobile/updateApi.json"
    
//    http://himont-dcr.digitrends.pk/webapi/GetMSRPlan/?employeeid=
    
    
    static let UpdatePlanApi = BaseUrl + "WebApi/EditDoctorVisit"
    static let LoginApi = BaseLogin + "account/Login"
    static let GetSummaryApi = BaseUrl + "WebApi/GetSummaryOfPlanInExecution"
    static let CalendarPostApi = BaseUrl + "WebApi/CreateMonthPlan"
    static let CopyMonthPlan = BaseUrl + "WebApi/CopyMonthPlan"
    static let DayPlanApi = BaseUrl + "WebApi/GetDayPlan"
    static let ammad = "ammad"
    
    static let VideoApi = "http://medconwebapi-v3.digitrends.pk/api/VideoLibrary/Index"
    static let DoctorListApi = BaseUrl + "WebApi/GetDoctorList"
    static let AddDocotorVisitApi = BaseUrl + "WebApi/AddDoctorVisit"
    static let WeekWiseApi = BaseUrl + "WebApi/GetDetailOfPlanInExecutionWeekWise"
    static let getPlanHistory = BaseUrl + "WebApi/GetPlanHistory"
    static let SebmitPlanApi = BaseUrl + "WebApi/SubmitMonthPlan"
    static let AddLeaveApi = BaseUrl + "WebApi/AddLeave"
    static let SkipDoctorApi = BaseUrl + "WebApi/GetSkippedDoctorList"
    static let BrandApi = "https://drugportal.a2hosted.com/api/brands"
    static let PAMArtApi = "http://medcon-webapi-beta.digitrends.pk/api/PatientAwareness/Index"
    static let PopularApi = "http://medcon-webapi-beta.digitrends.pk/api/PatientAwareness/MostPopular"
    static let FecturerApi = "https://drugportal.a2hosted.com/api/manufacturers"
    static let AvailableApi = "https://drugportal.a2hosted.com/api/brands-index"
    static let DrugInterApi = "https://drugportal.a2hosted.com/api/drug-interactions"
    static let DetailAvailableApi = "https://drugportal.a2hosted.com/api/drugs/get"
    static let BrandDetailApi = "https://drugportal.a2hosted.com/api/manufacturers/get"
    static let getMsrId = "getMsrId"
    static let deletePlanApi = BaseUrl + "WebApi/DeleteMSRPlanEntry"
    static let StatisticsApi = DcrBaseUrl + "webapi//padashboard"
    static let SalesApi = DcrBaseUrl + "WebApi/SalesDashboard"
    static let btn = "btn"
    static let DoctorApi = BaseUrl + "account/EmployeeDoctors"
    static let selId = "selId"
    static let PlannedDoctorApi = DcrBaseUrl + "webapi/GetMSRPlan"
    static let AttendenceApi = BaseUrl + "webapi/GetAllContactPoints"
    static let AttendencePostApi = BaseUrl + "webapi/AddListCPAttendanceOfflineVersion10"
    static let AttendenceMarkTimeApi = BaseUrl + "account/getattendancemarktime"
    static let SampleApi = BaseUrl + "ExpensesSync/PostExpenses"
    static let CallSyncApi = BaseUrl + "/api/callsync"
    static let ManagerApi = BaseUrl + "account/EmployeeManagerDetails"
    static let LOGIN_RESULT = "login_result"
    static let ArtID = "ArtID"
    static let pasteDate = "pasteDate"
    static let ApproveDate = "ApproveDate"
    static let CreatedDate = "CreatedDate"
    static let EmpType = "EmpType"
    static let Id = "Id"
    static let Month = "Month"
    static let Note = "Note"
    static let RejectDate = "RejectDate"
    static let StatusCode = "StatusCode"
    static let SupervisorId = "SupervisorId"
    static let UserAgent = "UserAgent"
    static let Year = "Year"
    static let fulldate = "fulldate"
    static let IsSignInKey = "IsSignInKey"
    static let TypeProduct = "Product"
    static let TypeApi = "Api"
    static let genPage = "genPage"
    static let EmpId = "empID"
    static let EmpName = "empName"
    static let EmpDes = "empDes"
    static let leaveId = "leaveId"
    static let RootDir = "himont"
    static let DownloadDir = "Downloads"
    static let WeekMonth = "WeekMonth"
    static let MorningStartTime = "MorningStartTime"
    static let MaxMorningTime = "MaxMorningTime"
    static let EveningTimeStart = "EveningTimeStart"
    static let MaxEveningTime = "maxEveningTime"
    static let CallToUploadKey = "CallToUploadKey"
    static let LastTimeOfUpload = "LastTimeOfUpload"
    static let LatitudeKey = "Latitude"
    static let LongitudeKey = "Lonitude"
    static let DoctorSelectedList = "DoctorSelectedList"
    static let ManagerSelectedList = "ManagerSelectedList"
    static let ProductSelectedList = "ProductSelectedList"
    static let StartCallKey = "StartCallKey"
    static let getPlanResult = "getPlanResult"
    static let LastEmpId = "LastEmpId"
    static let CalendarId = "CalendarId"
    static let CalendarMonth = "CalendarMonth"
    static let startDate = "startDate"
    static let endDate = "endDate"
    static let CalendarYear = "CalendarYear"
    static let LastEmpPassword = "LastEmpPassword"
    static let SelectedDate = "SelectedDate"
    static let GetDoctorList = "GetDoctorList"
    static let SelectedYear = "SelectedYear"
    static let SelectedMonth = "SelectedMonth"
    static let SelectedDay = "SelectedDay"
    static let IsEditting = "IsEditting"
    static let BrickCode = "BrickCode"
    static let docCount = "docCount"
    static let LastLoginResponse = "LastLoginResponse"
    static let DOCTOR_RESULT = "DOCTOR_RESULT"
    static let SelectedPlan = "SelectedPlan"
    static let SELECTED_MORNING_ATTENDANCE_TIME = "SELECTED_MORNING_ATTENDANCE_TIME"
    static let SELECTED_MORNING_ATTENDANCE_LOCATION = "SELECTED_MORNING_ATTENDANCE_LOCATION"
    static let SELECTED_EVENING_ATTENDANCE_TIME = "SELECTED_EVENING_ATTENDANCE_TIME"
    static let SELECTED_EVENING_ATTENDANCE_LOCATION = "SELECTED_EVENING_ATTENDANCE_LOCATION"
    static let COMPELET_CONTACT_POINT_JSON = "COMPELET_CONTACT_POINT_JSON"
   
    
}
