//
//  GenBranModel.swift
//  medcon-swift
//
//  Created by macbook on 13/09/2022.
//

import Foundation
import ObjectMapper

struct GenBranModel : Mappable {
    var request : Request?
    var status : String?
    var data : BrandData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        request <- map["request"]
        status <- map["status"]
        data <- map["data"]
    }

}
struct Request : Mappable {
    var token : String?
    var page : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        token <- map["token"]
        page <- map["page"]
    }

}

struct BrandData : Mappable {
    var current_page : Int?
    var data : [JsonData]?
    var first_page_url : String?
    var from : Int?
    var last_page : Int?
    var last_page_url : String?
    var next_page_url : String?
    var path : String?
    var per_page : Int?
    var prev_page_url : String?
    var to : Int?
    var total : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        current_page <- map["current_page"]
        data <- map["data"]
        first_page_url <- map["first_page_url"]
        from <- map["from"]
        last_page <- map["last_page"]
        last_page_url <- map["last_page_url"]
        next_page_url <- map["next_page_url"]
        path <- map["path"]
        per_page <- map["per_page"]
        prev_page_url <- map["prev_page_url"]
        to <- map["to"]
        total <- map["total"]
    }
    
}
    
    struct JsonData : Mappable {
        var id : Int?
        var name : String?
        var company : String?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            id <- map["id"]
            name <- map["name"]
            company <- map["company"]
            
        }

}
