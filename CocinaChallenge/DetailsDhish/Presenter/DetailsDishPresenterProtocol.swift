//
//  QueryListPresenterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import Foundation


protocol DetailsDishPresenterProtocol: AnyObject {
    var dataRecipes: DishesDTO? {get set}
    func gotToMapView(data: LocationOriginDto?)
}
