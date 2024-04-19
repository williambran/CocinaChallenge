//
//  MapInteractorProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import Foundation


protocol MapInteractorProtocol {
    var presenter: MapInteractorOutputProtocol? {get set}
    func request()
}
protocol MapInteractorOutputProtocol {}
