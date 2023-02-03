//
//  AlbumResponse.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 12/02/2022.
//

import Foundation

// MARK: - AlbumResponse
struct AlbumResponse: Codable {
    let status: Int?
    let success: Bool
    let message: String?
    let data: [AlbumData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - Datum
struct AlbumData: Codable {
    let albumName: String?
    let albumID: Int?
    let gallery: [Gallery]

    enum CodingKeys: String, CodingKey {
        case albumName = "AlbumName"
        case albumID = "AlbumId"
        case gallery = "Gallery"
    }
}

extension AlbumData: GalleryTableViewCellDataSource {
    func getImagesUrl() -> [String] {
        return gallery.map { ($0.imageFullUrl) }
    }
    
    func getImageUrl() -> String {
        return gallery.first?.imageFullUrl ?? ""
    }
    
    func getTitleText() -> String {
        return albumName ?? ""
    }
    
    
}

// MARK: - Gallery
struct Gallery: Codable {
    let id: Int?
    let title, imageURL: String?
    let html, orderID, categoryID: String?
    let createdDate: Int?
    let modifiedDate: Int?
    let albumID: Int?
    
    var imageFullUrl: String {
        get {
            return EndpointItem.base.baseURL + (imageURL ?? "")
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case imageURL = "ImageUrl"
        case html = "Html"
        case orderID = "OrderId"
        case categoryID = "CategoryId"
        case createdDate = "CreatedDate"
        case modifiedDate = "ModifiedDate"
        case albumID = "AlbumId"
    }
}
