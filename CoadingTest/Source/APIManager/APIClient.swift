//
//  APIClient.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class APIClient {
    
    var baseURL: URL?
    var custError: Error?
    
    static let shared = { APIClient(baseUrl: APIManager.shared.baseURL) }()
    
    required init(baseUrl: String){
        self.baseURL = URL(string: baseUrl)
    }
    
    func getArray<T>(urlString: String,
                     success: @escaping (Int, [T]) -> (),
                     failure: @escaping (Error) -> ()) where T: BaseMappable {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        guard let url = NSURL(string: urlString , relativeTo: self.baseURL as URL?) else {
            return
        }
        
        let urlString = url.absoluteString!
        
        Alamofire
            .request(urlString,
                     method: .get,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .responseArray { (dataResponse: DataResponse<[T]>) in
                
                guard let serverResponse = dataResponse.response,
                    let resultValue = dataResponse.result.value else {
                    self.custError = NSError(domain: "Bad Request", code: 400, userInfo: ["message":"Request sent is inappropriate"])
                    failure(self.custError!)
                        return
                }
                
                switch serverResponse.statusCode {
                case 200, 201:
                    success(serverResponse.statusCode, resultValue)
                    
                    case 400:
                        self.custError = NSError(domain: "Bad Request", code: serverResponse.statusCode, userInfo: ["message":"Request sent is inappropriate"])
                    case 401 :
                        self.custError = NSError(domain: "Unauthorized", code: serverResponse.statusCode, userInfo: ["message":"Request failed to authenticate with the server"])
                    case 403 :
                        self.custError = NSError(domain: "Forbidden", code: serverResponse.statusCode, userInfo: ["message":"client authenticated but does not have permission to access the requested resource"])
                    case 404 :
                        self.custError = NSError(domain: "Not Found", code: serverResponse.statusCode, userInfo: ["message":"the requested resource does not exist"])
                    case 500 :
                        self.custError = NSError(domain: "Internal Server Error", code: serverResponse.statusCode, userInfo: ["message":"a generic error occurred on the server"])
                    case 503 :
                        self.custError = NSError(domain: " Service Unavailable ", code: serverResponse.statusCode, userInfo: ["message":"The requested service is not available"])
                    default:
                        self.custError = NSError(domain: "Error!", code: serverResponse.statusCode, userInfo: ["message":"Something went wrong, please try letter"])
                    
                }
                
        }
        
    }
    
}
