//
//  DetailsDishViewProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import Foundation

protocol DetailsDishViewProtocol: AnyObject {
    var dataSource: DishesDTO? {get set}
}
