//
//  LaucherScreenViewProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation

protocol ViewProtocol {
    associatedtype presenterProtocol
    var presenter: presenterProtocol? {get set}
}


protocol SplashViewProtocol {
    //implementar funciones o variables que ayuden
    func testView()
    func animatedIcon()
}
