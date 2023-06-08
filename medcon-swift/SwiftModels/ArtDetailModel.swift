//
//  ArtDetailModel.swift
//  medcon-swift
//
//  Created by Macbook on 18/05/2023.
//

import Foundation
import ObjectMapper

struct ArtDetailModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : ARTData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}
struct ARTData : Mappable {
    var id : Int?
    var title : String?
    var imageUrl : String?
    var html : String?
    var mediaUrl : String?
    var orderId : Int?
    var categoryId : Int?
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
