//
//  AcronymViewModel.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import Foundation

class AcronymViewModel {
    
    var acrList: [Acronym]?
    var acrSearched: String?
    var longFormList: [LF] = []
    
    func getListForAcronym(acronym:String, completion: @escaping (Bool, Error?) -> ()) {
        AcronymService.shared.getListFor(acronym: acronym, success: { (code, acronymList) in
            if let acr = acronymList.first, let sf = acr.sf, let lfs = acr.lfs {
                self.acrList = acronymList
                self.acrSearched = sf
                self.longFormList = lfs
                completion(true,nil)
            }
        }, failure: { (error) in
            completion(false,error)
        })
    }
}

