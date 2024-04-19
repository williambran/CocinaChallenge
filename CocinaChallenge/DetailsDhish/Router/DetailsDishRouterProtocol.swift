//
//  DetailsDishRouterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import Foundation


protocol DetailsDishRouterProtocol {
    func mapRouter(data: LocationOriginDto?)
    var data: DishesDTO? {get set}
}
