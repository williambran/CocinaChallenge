//
//  GenericResponse.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation


struct GenericResponse {
    var code: String
    var message: String
    var result: Any?
    var error: Any?
    
    static func parseResponse(code: Int, data: Data?, error: Error?) -> GenericResponse {
        guard let json = data?.toJSON,
        let code = json["code"] as? String,
        let result = json["result"],
        let message = json["message"] as? String else { return processError(code: code) }
        
        return GenericResponse(code: code, message: message, result: result)
        
        
    }
    
    var resultJson: JSON? {
        guard let anyData = self.result, let json = anyData as? JSON else { return nil }
        return json
    }
    
     static func processError(code: Int) -> GenericResponse {
        return GenericResponse(code: "\(code)", message: "Error", result: [])
    }
}
