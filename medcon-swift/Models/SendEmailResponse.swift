//
//  SendEmailResponse.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 24/03/2022.
//

import Foundation

class SendEmailResponse: Codable {
    let message: String
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status
    }

    init(message: String, status: Bool) {
        self.message = message
        self.status = status
    }
}
