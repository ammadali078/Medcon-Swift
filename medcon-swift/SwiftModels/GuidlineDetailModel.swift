//
//  GuidlineDetailModel.swift
//  medcon-swift
//
//  Created by Macbook on 08/06/2023.
//

import Foundation
import ObjectMapper

struct GuidlineDetailModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : [GuidlineData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}
struct GuidlineData : Mappable {
    var guidelines : [Guidelines]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        guidelines <- map["Guidelines"]
    }

}
struct Guidelines : Mappable {
    var id : Int?
    var title : String?
    var imageUrl : String?
    var encodeFileUrl : String?
    var html : String?
    var orderId : Int?
    var categoryId : String?
    var createdDate : Int?
    var modifiedDate : Int?
    var detailsHtml : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        title <- map["Title"]
        imageUrl <- map["ImageUrl"]
        encodeFileUrl <- map["EncodeFileUrl"]
        html <- map["Html"]
        orderId <- map["OrderId"]
        categoryId <- map["CategoryId"]
        createdDate <- map["CreatedDate"]
        modifiedDate <- map["ModifiedDate"]
        detailsHtml <- map["DetailsHtml"]
    }

}
