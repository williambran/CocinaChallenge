//
//  LaunchScreenPresenterProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation
import UIKit

protocol PresenterProtocol: AnyObject {
    associatedtype viewProtocol
    associatedtype routerProtocol
    associatedtype interactorProtocol
    
    var view: viewProtocol? { get set }
    var router: routerProtocol? { get set }
    var interactor: interactorProtocol? { get set }
}

protocol SplashPresenterProtocol {
    func finishProcesing()
    func processing()
}
