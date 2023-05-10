//
//  PAMModel.swift
//  medcon-swift
//
//  Created by Macbook on 14/04/2023.
//

import Foundation
import ObjectMapper

struct PAMModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : [PAMResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}
struct PAMResult : Mappable {
    var patientAwareness : [PatientAwareness]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        patientAwareness <- map["PatientAwareness"]
    }

}
struct PatientAwareness : Mappable {
    var id : Int?
    var title : String?
    var imageUrl : String?
    var html : String?
    var mediaUrl : String?
    var orderId : String?
    var categoryId : String?
    var createdDate : Int?
    var modifiedDate : Int?
    var detailsHtml : String?
    var externalLink : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        title <- map["Title"]
        imageUrl <- map["ImageUrl"]
        html <- map["Html"]
        mediaUrl <- map["MediaUrl"]
        orderId <- map["OrderId"]
        categoryId <- map["CategoryId"]
        createdDate <- map["CreatedDate"]
        modifiedDate <- map["ModifiedDate"]
        detailsHtml <- map["DetailsHtml"]
        externalLink <- map["ExternalLink"]
    }

}
