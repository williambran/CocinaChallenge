//
//  HomeScreenProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation



protocol HomeScreenViewProtocol: AnyObject {
    func loadData(dishes: [DishesDTO])
    
}
