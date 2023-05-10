//
//  MostPopularModel.swift
//  medcon-swift
//
//  Created by Macbook on 18/04/2023.
//

import Foundation
import ObjectMapper

struct MostPopularModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : [MostPopularResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}

struct MostPopularResult : Mappable {
    var imageURL : String?
    var title : String?
    var popularCount : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        imageURL <- map["ImageURL"]
        title <- map["Title"]
        popularCount <- map["popularCount"]
    }

}
