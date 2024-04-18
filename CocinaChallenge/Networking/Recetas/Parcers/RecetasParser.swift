//
//  RecetasParser.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation



struct RecetasParser {
    
    
    func getParameterHeader() -> [String:String] {
        var header: [String:String] = [:]
        header["Content-Type"] = "application/json"
        header["api_key"] = "wikiwonka123456789"
        return header
    }
    
    func parse(data: GenericResponse) -> RecipesDTO? {
        guard let json = data.resultJson , let recetasData = try? JSONDecoder().decode(RecipesDTO.self, from: JSONSerialization.data(withJSONObject: json)) else { 
            return nil }
        return recetasData
    }
    
    
}
