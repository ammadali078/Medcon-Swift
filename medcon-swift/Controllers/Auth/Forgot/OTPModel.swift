//
//  OTPModel.swift
//  medcon-swift
//
//  Created by Macbook on 27/08/2023.
//

import Foundation
import ObjectMapper

struct OTPModel : Mappable {
    var status : Int?
    var success : Bool?
    var message : String?
    var data : OTPData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}

struct OTPData : Mappable {
    var Tokencode : String?
   

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        Tokencode <- map["Tokencode"]
       
    }

}
