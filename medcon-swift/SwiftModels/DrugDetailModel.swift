//
//  DrugDetailModel.swift
//  medcon-swift
//
//  Created by Macbook on 30/05/2023.
//

import Foundation
import ObjectMapper

struct DrugDetailModel : Mappable {
    var nlmDisclaimer : String?
    var fullInteractionTypeGroup : [FullInteractionTypeGroup]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        nlmDisclaimer <- map["nlmDisclaimer"]
        fullInteractionTypeGroup <- map["fullInteractionTypeGroup"]
    }

}
struct FullInteractionTypeGroup : Mappable {
    var sourceDisclaimer : String?
    var sourceName : String?
    var fullInteractionType : [FullInteractionType]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        sourceDisclaimer <- map["sourceDisclaimer"]
        sourceName <- map["sourceName"]
        fullInteractionType <- map["fullInteractionType"]
    }

}
struct FullInteractionType : Mappable {
    var comment : String?
    var minConcept : [MinConcept]?
    var interactionPair : [InteractionPair]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        comment <- map["comment"]
        minConcept <- map["minConcept"]
        interactionPair <- map["interactionPair"]
    }

}
struct MinConcept : Mappable {
    var rxcui : String?
    var name : String?
    var tty : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        rxcui <- map["rxcui"]
        name <- map["name"]
        tty <- map["tty"]
    }

}
struct InteractionPair : Mappable {
    var interactionConcept : [InteractionConcept]?
    var severity : String?
    var description : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        interactionConcept <- map["interactionConcept"]
        severity <- map["severity"]
        description <- map["description"]
    }

}
struct InteractionConcept : Mappable {
    var minConceptItem : MinConceptItem?
    var sourceConceptItem : SourceConceptItem?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        minConceptItem <- map["minConceptItem"]
        sourceConceptItem <- map["sourceConceptItem"]
    }

}
struct MinConceptItem : Mappable {
    var rxcui : String?
    var name : String?
    var tty : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        rxcui <- map["rxcui"]
        name <- map["name"]
        tty <- map["tty"]
    }

}
struct SourceConceptItem : Mappable {
    var id : String?
    var name : String?
    var url : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
    }

}

