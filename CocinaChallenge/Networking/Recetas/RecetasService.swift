//
//  RecetasService.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation


class RecetasService: RecetasServiceProtocol {
    var parcer = RecetasParser()
    var servicesManager: ServiceManagerProtocol =  ServiceManager(urlSession: URLSession.init(configuration: .ephemeral))
    
    func getRecetas(completion: @escaping (ServiceResponse<RecipesDTO>) -> Void) {
        let url = "http://demo0874283.mockable.io/recipes"
        let header = parcer.getParameterHeader()
        let timeInterval = TimeInterval(120)

        
        servicesManager.request(url: url, header: header, timeOut: timeInterval, httpMethod: .GET, body: JSON(), completion: completion)
    }
}

