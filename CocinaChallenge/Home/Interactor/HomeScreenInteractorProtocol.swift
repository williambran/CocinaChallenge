//
//  HomeScreenInteractorProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation


protocol HomeScreenInteractorProtocol: AnyObject {
    var presenter: HomeScreenInteractorOutputProtocol? {get set}
    func request()
}

protocol HomeScreenInteractorOutputProtocol: AnyObject {
    func resultDishes(dishes: [DishesDTO])
}
