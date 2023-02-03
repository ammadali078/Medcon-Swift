//
//  GalleryResponse.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 12/02/2022.
//

import Foundation

// MARK: - GalleryResponse
struct GalleryResponse: Codable {
    let status: Int
    let success: Bool
    let message: String?
    let data: [GalleryData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - Datum
struct GalleryData: Codable {
    let id: Int?
    let imageURL, title, datumDescription: String?
    let pageID: Int?
    let categoryID: Int?
    let isBannerImage: Bool?
    let createdDate, modifiedDate, orderID: Int?
    
    var imageFullUrl: String {
        get {
            return EndpointItem.base.baseURL + (imageURL ?? "")
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case imageURL = "ImageUrl"
        case title = "Title"
        case datumDescription = "Description"
        case pageID = "PageId"
        case categoryID = "CategoryId"
        case isBannerImage = "IsBannerImage"
        case createdDate = "CreatedDate"
        case modifiedDate = "ModifiedDate"
        case orderID = "OrderId"
    }
}

