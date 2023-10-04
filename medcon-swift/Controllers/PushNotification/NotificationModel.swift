//
//  NotificationModel.swift
//  medcon-swift
//
//  Created by Macbook on 16/08/2023.
//

import Foundation
import ObjectMapper

struct NotificationModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : [NotifyData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}

struct NotifyData : Mappable {
    var id : Int?
    var title : String?
    var description : String?
    var createdDate : String?
    var loggedInId : String?
    var issent : Bool?
    var email : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        title <- map["Title"]
        description <- map["Description"]
        createdDate <- map["CreatedDate"]
        loggedInId <- map["LoggedInId"]
        issent <- map["Issent"]
        email <- map["Email"]
    }

}
