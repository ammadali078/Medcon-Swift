//
//  FcmModel.swift
//  medcon-swift
//
//  Created by Macbook on 15/08/2023.
//

import Foundation
import ObjectMapper

struct FcmModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}
