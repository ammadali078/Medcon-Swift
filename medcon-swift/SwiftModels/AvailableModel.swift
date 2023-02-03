//
//  AvailableModel.swift
//  medcon-swift
//
//  Created by macbook on 15/09/2022.
//

import Foundation
import ObjectMapper

struct AvailableModel : Mappable {
    var request : AvailableRequest?
    var status : String?
    var data : AvailableData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        request <- map["request"]
        status <- map["status"]
        data <- map["data"]
    }

}
struct AvailableRequest : Mappable {
    var token : String?
    var id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        token <- map["token"]
        id <- map["id"]
    }

}
struct AvailableData : Mappable {
    var id : Int?
    var created_at : String?
    var updated_at : String?
    var name : String?
    var indications_and_dose : String?
    var contraindications : String?
    var side_effects : String?
    var cautions : String?
    var precautions : String?
    var interaction : String?
    var warnings : String?
    var adverse_effects : String?
    var lactations : String?
    var special_precautions : String?
    var counselling : String?
    var side_effects_or_adverse_reactions : String?
    var patient_and_carer_advice : String?
    var new : Int?
    var user_id : Int?
    var forms : [Forms]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        name <- map["name"]
        indications_and_dose <- map["indications_and_dose"]
        contraindications <- map["contraindications"]
        side_effects <- map["side_effects"]
        cautions <- map["cautions"]
        precautions <- map["precautions"]
        interaction <- map["interaction"]
        warnings <- map["warnings"]
        adverse_effects <- map["adverse_effects"]
        lactations <- map["lactations"]
        special_precautions <- map["special_precautions"]
        counselling <- map["counselling"]
        side_effects_or_adverse_reactions <- map["side_effects_or_adverse_reactions"]
        patient_and_carer_advice <- map["patient_and_carer_advice"]
        new <- map["new"]
        user_id <- map["user_id"]
        forms <- map["forms"]
    }

}

struct Forms : Mappable {
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
    var draft : Int?
    var alt_description : String?
    var type : String?

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
        type <- map["type"]
    }

}

