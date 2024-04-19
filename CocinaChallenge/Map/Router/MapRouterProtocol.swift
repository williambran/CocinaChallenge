//
//  MapRouterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import Foundation


protocol MapRouterProtocol {
    var data: LocationOriginDto? { get set }
    func informationLocationRouter(title: String?, description: String?, urlImg: String?) 

}
