//
//  AcronymService.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import Foundation

class AcronymService {
    
    static let shared = { AcronymService() }()
    
     func getListFor(acronym: String, success: @escaping (Int, [Acronym]) -> (), failure: @escaping (Error) -> ()) {
        
        let urlString = self.configureApiCall(Endpoints.PATH, "sf", acronym)
        
        APIClient.shared.getArray(urlString: urlString, success: { (code, arrayOfAcronym) in
            success(code, arrayOfAcronym)
            
        }) { (error) in
            failure(error)
        }
    }
    
    func configureApiCall(_ baseURL: String, _ parameter: String, _ value: String) -> String {
        return baseURL + "?" + parameter + "=" + value
    }
}
