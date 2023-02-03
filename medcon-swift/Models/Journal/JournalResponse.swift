//
//  JournalResponse.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 12/02/2022.
//

import Foundation

// MARK: - JournalResponse
struct JournalResponse: Codable {
    let status: Int?
    let success: Bool
    let message: String?
    var data: [JournalData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - Datum
struct JournalData: Codable {
    let categoryName: String?
    let categoryID: Int?
    var newsJournal: [NewsJournal]

    enum CodingKeys: String, CodingKey {
        case categoryName = "CategoryName"
        case categoryID = "CategoryId"
        case newsJournal = "NewsJournal"
    }
}

// MARK: - NewsJournal
struct NewsJournal: Codable {
    let id: Int?
    let title, imageURL, html, newsJournalDescription: String?
    let categoryID: Int?
    let isPopular: Bool?
    let createdDate, modifiedDate: Int?
    let orderID: Int?
    let externalLink: String?
    let mediaURL: String?
    let type: String?
    //type : News
    let p3Number: String?
    let reference: String?

    var imageFullUrl: String {
        get {
            return EndpointItem.base.baseURL + (imageURL ?? "")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case imageURL = "ImageURL"
        case html = "Html"
        case newsJournalDescription = "Description"
        case categoryID = "CategoryId"
        case isPopular = "IsPopular"
        case createdDate = "CreatedDate"
        case modifiedDate = "ModifiedDate"
        case orderID = "OrderId"
        case externalLink = "ExternalLink"
        case mediaURL = "MediaURL"
        case type = "Type"
        case p3Number = "P3Number"
        case reference = "Reference"
    }
}

extension NewsJournal: ArticleTableViewCellDataSource {
    func getReferenceDetails() -> String {
        return "\(p3Number ?? "") \n \(reference ?? "")"
    }
    
    func getImageUrl() -> String {
        return EndpointItem.base.baseURL + (imageURL ?? "")
    }
    
    func getTitleText() -> String {
        return title ?? ""
    }
    
    func getDescriptionText() -> String {
        return newsJournalDescription ?? ""
    }
    
    func getHtmlText() -> String {
        return html ?? ""
    }
    
    func getTypeText() -> String {
        return type ?? ""
    }
}
