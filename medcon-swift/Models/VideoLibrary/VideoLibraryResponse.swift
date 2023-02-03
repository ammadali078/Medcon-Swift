//
//  VideoLibraryResponse.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 12/02/2022.
//

import Foundation

// MARK: - VideoLibraryResponse
struct VideoLibraryResponse: Codable {
    let status: Int
    let success: Bool
    let message: String?
    let data: [VideoLibraryData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - Datum
struct VideoLibraryData: Codable {
    let categoryName: String?
    let categoryID: Int?
    let videos: [Video]

    enum CodingKeys: String, CodingKey {
        case categoryName = "CategoryName"
        case categoryID = "CategoryId"
        case videos = "Videos"
    }
}

// MARK: - Video
struct Video: Codable {
    let id: Int?
    let title, videoURL, imageURL: String?
    let pageID, typeID: Int?
    let isTrending, isFirstPage: Bool?
    let createdDate: Int?
    let modifiedDate, orderID: Int?
    let categoryID: Int?
    
    var imageFullUrl: String {
        get {
            return EndpointItem.base.baseURL + (imageURL ?? "")
        }
    }
    
    var videoFullUrl: String {
        get {
            return EndpointItem.base.baseURL + (videoURL ?? "")
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case videoURL = "VideoUrl"
        case imageURL = "ImageUrl"
        case pageID = "PageId"
        case typeID = "TypeId"
        case isTrending = "IsTrending"
        case isFirstPage = "IsFirstPage"
        case createdDate = "CreatedDate"
        case modifiedDate = "ModifiedDate"
        case orderID = "OrderId"
        case categoryID = "CategoryId"
    }
}

extension Video: VideoTableViewCellDataSource {
    func getImageUrl() -> String {
        return EndpointItem.base.baseURL + (imageURL ?? "")
    }
    
    func getTitleText() -> String {
        return title ?? ""
    }
    
    func getVideoUrl() -> String {
        return EndpointItem.base.baseURL + (videoURL ?? "")
    }
    
    
}
