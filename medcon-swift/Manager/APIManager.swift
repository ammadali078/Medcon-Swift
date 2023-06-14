//
//  APIManager.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 10/02/2022.
//

import Alamofire

enum NetworkEnvironment {
    case dev
    case production
}

protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
    
}

class APIManager  {
    
    // MARK: - Vars & Lets
    
    private let sessionManager: Session
    static let networkEnviroment: NetworkEnvironment = .production
    
    // MARK: - Vars & Lets
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    func call(type: EndPointType, params: Parameters? = nil, handler: @escaping (()?, _ error: AlertMessage?)->()) {
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
            if let JSONString = String(data: data.data!, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            switch data.result {
            case .success(_):
                handler((), nil)
                break
            case .failure(_):
                handler(nil, self.parseApiError(data: data.data))
                break
            }
        }
    }
    
    private func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            return AlertMessage(title: "Alert", body: "Something went wrong, please try again.")
        }
        return AlertMessage(title: "Alert", body: "Something went wrong, please try again.")
    }
}

extension APIManager {
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
            switch data.result {
            case .success(_):
                let decoder = JSONDecoder()
                if let jsonData = data.data {
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                        print("*** RESPONSE ***")
                        print(JSONString)
                    }
                    
                    let result = try! decoder.decode(T.self, from:  jsonData)
                    handler(result, nil)
                }
                break
            case .failure(_):
                handler(nil, self.parseApiError(data: data.data))
                break
            }
        }
    }
    
    func downloadFile(type: EndPointType, reference: URLSessionDownloadDelegate, params: Parameters? = nil, handler: @escaping (String?)->()) {
        
        let url = type.url
        
        let urlSession = URLSession(configuration: .default, delegate: reference, delegateQueue: OperationQueue())
        do {
            let req = try URLRequest.init(url: url, method: type.httpMethod, headers: type.headers)
            
            let downloadTask = urlSession.downloadTask(with: req)
            downloadTask.resume()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

struct AlertMessage {
    
    var title = "Constants.defaultAlertTitle.localized()"
    var body = "Constants.defaultAlertMessage.localized()"
    
}

class ErrorObject: Codable {
    let message: String
    let error: String
}
