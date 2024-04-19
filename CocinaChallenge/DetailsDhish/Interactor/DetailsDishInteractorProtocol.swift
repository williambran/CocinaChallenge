//
//  DetailsDishInteractorProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import Foundation


protocol DetailsDishInteractorProtocol {
    var presenter: DetailsRecetaInteractorOutputProtocol? {get set}
    func request()
}

protocol DetailsRecetaInteractorOutputProtocol {
    
}
