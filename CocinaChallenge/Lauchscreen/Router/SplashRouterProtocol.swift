//
//  LaucherScreenRouterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation
import UIKit

protocol RouterProtocol: AnyObject {
    associatedtype T
    var rootView: T? {get}
    var navigation: UINavigationController? {get}
    func start(navigation: UINavigationController?)
}


protocol SplashRouterProtocol {
    func goHome()
    func goLogin()
    func goOnBoarding()
}
