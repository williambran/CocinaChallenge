//
//  EncodingProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation


protocol EncodingProtocol {
    func encoding(dic: JSON)->Data?
}
struct DictionaryEncode:EncodingProtocol {
    static let shared = DictionaryEncode()
    
    func encoding(dic: JSON) -> Data? {
        return try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
    }
}
