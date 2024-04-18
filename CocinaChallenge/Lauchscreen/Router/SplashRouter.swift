//
//  RouterLaucher.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation
import UIKit


class SplashRouter: RouterProtocol {
    
    var rootView: UIViewController?
    var navigation: UINavigationController?
    
    
    func start(navigation: UINavigationController?) {
        let view = SplashViewController.instantiate(from: "SplashStoryboard")
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = self
        view.presenter = presenter
        rootView = view
        self.navigation = navigation
        if let nav =  navigation {
            self.navigation = nav
            self.navigation?.pushViewController(view, animated: true)
        } else {
            self.navigation = UINavigationController(rootViewController: view)
            rootView?.present(self.navigation!, animated: true)
        }
    }
}

extension SplashRouter: SplashRouterProtocol {

    
    func goLogin() {
    }
    
    func goHome() {
        //instanciar nuevos routers
        

    }
    func goOnBoarding() {
        let router = HomeScreenRouter()
        router.start(navigation: navigation)
    }

}
