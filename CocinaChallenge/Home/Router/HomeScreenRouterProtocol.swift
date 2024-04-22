//
//  HomeScreenRouterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation
import UIKit


protocol HomeScreenRouterProtocol: AnyObject {
    func goDetailsViewController(_ dataRecipes: DishesDTO)
   // var rootView: UIViewController? {get set}
    var navigation: UINavigationController? {get set}
    func start(navigation: UINavigationController?) 
}
