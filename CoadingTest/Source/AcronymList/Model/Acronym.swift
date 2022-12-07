//
//  Acronym.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import Foundation
import ObjectMapper

// MARK: - AlbAcrToFull
struct Acronym: Mappable {
    var sf: String?
    var lfs: [LF]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        sf <- map["sf"]
        lfs <- map["lfs"]
    }
    

}

// MARK: - LF
struct LF: Mappable {
    var lf: String?
    var freq, since: Int?
    var vars: [LF]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        lf <- map["lf"]
        freq <- map["freq"]
        since <- map["since"]
        vars  <- map["vars"]
    }
}
