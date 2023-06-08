//
//  PopularDetailModel.swift
//  medcon-swift
//
//  Created by Macbook on 07/06/2023.
//

import Foundation
import ObjectMapper

struct PopularDetailModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : PopularDetailResult?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}
struct PopularDetailResult : Mappable {
    var id : Int?
    var title : String?
    var imageUrl : String?
    var html : String?
    var mediaUrl : String?
    var orderId : String?
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
