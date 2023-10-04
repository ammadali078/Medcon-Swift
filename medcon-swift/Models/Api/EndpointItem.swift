//
//  EndpointItem.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 10/02/2022.
//

import Alamofire

enum EndpointItem {
    
    // MARK: User actions
    case register
    case login
    case newsAndJournals
    case newsAndJournalsMsl
    case videoLibrary
    case galleryImages
    case album
    case sendEmail
    case base
}

// MARK: - Extensions
// MARK: - EndPointType
extension EndpointItem: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
//            case .dev: return "http://medcon-webapi-beta.digitrends.pk"
            case .dev: return "http://medconwebapi-v3.digitrends.pk"
            case .production: return "http://medconwebapi-v3.digitrends.pk"
//            case .production: return "http://medcon-webapi-beta.digitrends.pk"
        }
    }
    
    
    var version: String {
        return ""
    }
    
    var path: String {
        switch self {
        case .register:
            return "/Account/Register"
        case .login:
            return "/Account/Login"
        case .newsAndJournals:
            return "/api/NewAndJournals/Index?type=All"
        case .newsAndJournalsMsl:
            return "/api/NewAndJournals/Index?type=MSL"
        case .videoLibrary:
            return "/api/VideoLibrary/Index?type=All"
        case .galleryImages:
            return "/api/Gallery/Images"
        case .album:
            return "/api/Album/Index"
        case .base:
            return ""
        case .sendEmail:
            return "/SendEmail/SendEmail"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register, .login, .sendEmail:
            return .post
        case .newsAndJournals, .newsAndJournalsMsl, .videoLibrary, .galleryImages, .album, .base:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        ["Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest"]
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.version + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
