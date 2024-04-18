//
//  MainCoordinator.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation
import UIKit


class MainRouter: RouterProtocol {

 
    

    var rootView: UIViewController?
    var navigation: UINavigationController?
    var window: UIWindow?
    
    init(window: UIWindow? ) {
        self.window = window
    }
    
    func start(navigation: UINavigationController?) {
        self.navigation = navigation
        runMain()
    }
    
    


    private func runMain() {
        let route = SplashRouter()
        route.start(navigation: navigation)
        if let nav = navigation {
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        } else {
            window?.rootViewController = route.rootView
            window?.makeKeyAndVisible()

        }
        
    }
    
}
