//
//  HomeScreenInteractorProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation


protocol HomeScreenInteractorProtocol {
    var presenter: HomeScreenInteractorOutputProtocol? {get set}
    func request()
}

protocol HomeScreenInteractorOutputProtocol {
    func resultDishes(dishes: [DishesDTO])
}
