//
//  BrandDetailModel.swift
//  medcon-swift
//
//  Created by macbook on 16/09/2022.
//

import Foundation
import ObjectMapper

struct BrandDetailModel : Mappable {
    var request : BrandRequest?
    var status : String?
    var data : BrandDetailData?
    var brands : [BrandsDetail]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        request <- map["request"]
        status <- map["status"]
        data <- map["data"]
        brands <- map["brands"]
    }

}

struct BrandRequest : Mappable {
    var token : String?
    var id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        token <- map["token"]
        id <- map["id"]
    }

}

struct BrandDetailData : Mappable {
    var id : Int?
    var created_at : String?
    var updated_at : String?
    var name : String?
    var address : String?
    var tel : String?
    var fax : String?
    var email : String?
    var website : String?
    var user_id : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        name <- map["name"]
        address <- map["address"]
        tel <- map["tel"]
        fax <- map["fax"]
        email <- map["email"]
        website <- map["website"]
        user_id <- map["user_id"]
    }

}

struct BrandsDetail : Mappable {
    var id : Int?
    var created_at : String?
    var updated_at : String?
    var type_id : Int?
    var packing : String?
    var actual_price : String?
    var retail_price : String?
    var drug_id : Int?
    var quantity : String?
    var brand : String?
    var company : String?
    var active_ingredient : String?
    var new : String?
    var user_id : Int?
    var manufacture_id : Int?
    var draft : String?
    var alt_description : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        type_id <- map["type_id"]
        packing <- map["packing"]
        actual_price <- map["actual_price"]
        retail_price <- map["retail_price"]
        drug_id <- map["drug_id"]
        quantity <- map["quantity"]
        brand <- map["brand"]
        company <- map["company"]
        active_ingredient <- map["active_ingredient"]
        new <- map["new"]
        user_id <- map["user_id"]
        manufacture_id <- map["manufacture_id"]
        draft <- map["draft"]
        alt_description <- map["alt_description"]
    }

}
