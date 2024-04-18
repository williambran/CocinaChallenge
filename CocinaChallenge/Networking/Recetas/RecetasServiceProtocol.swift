//
//  RecetasServiceProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation


protocol RecetasServiceProtocol {
    func getRecetas(completion: @escaping(ServiceResponse<RecipesDTO>)->Void)
}
