//
//  MapPresenterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import Foundation

protocol MapPresenterProtocol {
    var dataLocation: LocationOriginDto? {get set}
    func showInformation(title: String?, description: String?, urlImg: String? )

}


