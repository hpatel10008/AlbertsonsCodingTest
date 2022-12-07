//
//  APIManager.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import Foundation

class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "http://www.nactem.ac.uk/"
    }()
}
