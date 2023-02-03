//
//  DollsModel.swift
//  medcon-swift
//
//  Created by Ccomputing on 28/10/2022.
//

import Foundation
import ObjectMapper

struct DollsModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : [DataModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}
struct DataModel : Mappable {
    var categoryName : String?
    var categoryId : Int?
    var videos : [DataVideos]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        categoryName <- map["CategoryName"]
        categoryId <- map["CategoryId"]
        videos <- map["Videos"]
    }

}

struct DataVideos : Mappable {
    var id : Int?
    var title : String?
    var videoUrl : String?
    var imageUrl : String?
    var pageId : String?
    var typeId : Int?
    var isTrending : Bool?
    var isFirstPage : Bool?
    var createdDate : Int?
    var modifiedDate : Int?
    var orderId : Int?
    var categoryId : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        title <- map["Title"]
        videoUrl <- map["VideoUrl"]
        imageUrl <- map["ImageUrl"]
        pageId <- map["PageId"]
        typeId <- map["TypeId"]
        isTrending <- map["IsTrending"]
        isFirstPage <- map["IsFirstPage"]
        createdDate <- map["CreatedDate"]
        modifiedDate <- map["ModifiedDate"]
        orderId <- map["OrderId"]
        categoryId <- map["CategoryId"]
    }

}
