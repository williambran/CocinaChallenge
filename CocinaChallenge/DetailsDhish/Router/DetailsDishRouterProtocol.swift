//
//  DetailsDishRouterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import Foundation
import UIKit


protocol DetailsDishRouterProtocol: AnyObject {
    func mapRouter(data: LocationOriginDto?)
    var data: DishesDTO? {get set}
}
