//
//  HomoScreenInteractor.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation


class HomeScreenInteractor: HomeScreenInteractorProtocol {
    weak var presenter: HomeScreenInteractorOutputProtocol?
    
    struct Dependencies {
        static var services: RecetasServiceProtocol = RecetasService()
    }
    
    
    func request() {
        Dependencies.services.getRecetas {  [weak self]  in
            switch $0 {
            case .success(data: let data):
                self?.presenter?.resultDishes(dishes: data.dishes ?? [] )
            case .noSuccess(error: let error): break
            case  .badResquest: break
            case .notFound: break
            }
        }
    }
}
