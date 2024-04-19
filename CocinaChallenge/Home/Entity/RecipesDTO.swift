//
//  RecetasDTO.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation


struct RecipesDTO: Codable {
    var dishes: [DishesDTO]?
}

struct DishesDTO: Codable, Hashable {
    var name: String?
    var description: String?
    var urlImg: String?
    var origin: LocationOriginDto?
    var ingredients: [String]?
    var preparationSteps: [String]?
    
    static func == (lhs: DishesDTO, rhs: DishesDTO) -> Bool {
        return lhs.name == rhs.name
    }
}
