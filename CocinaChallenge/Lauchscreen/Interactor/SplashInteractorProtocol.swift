//
//  LaucherScreenInteractorProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation


protocol SplashInteractorProtocol {
    var presenter: SplashInteractorOutputProtocol? { get set }
    func setupDB()
}
protocol SplashInteractorOutputProtocol {
    func configFinish()
}
