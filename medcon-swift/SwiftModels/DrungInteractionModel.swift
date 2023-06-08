//
//  DrungInteractionModel.swift
//  medcon-swift
//
//  Created by Macbook on 26/05/2023.
//

import Foundation
import ObjectMapper

struct DrungInteractionModel : Mappable {
    var approximateGroup : ApproximateGroup?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        approximateGroup <- map["approximateGroup"]
    }

}
struct ApproximateGroup : Mappable {
    var inputTerm : String?
    var candidate : [Candidate]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        inputTerm <- map["inputTerm"]
        candidate <- map["candidate"]
    }

}
struct Candidate : Mappable {
    var rxcui : String?
    var rxaui : String?
    var score : String?
    var rank : String?
    var name : String?
    var source : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        rxcui <- map["rxcui"]
        rxaui <- map["rxaui"]
        score <- map["score"]
        rank <- map["rank"]
        name <- map["name"]
        source <- map["source"]
    }

}
