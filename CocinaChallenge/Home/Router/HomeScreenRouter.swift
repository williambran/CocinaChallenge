//
//  HomeScreenRouter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation
import UIKit


class HomeScreenRouter {
    
    var rootView: HomeScreenViewController?
    var navigation: UINavigationController?
    
    func start(navigation: UINavigationController?) {
        let view = HomeScreenViewController.instantiate(from: "HomeScreenViewController")
        let presenter = HomeScreenPresenter()
        let interactor = HomeScreenInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = self
        interactor.presenter = presenter
        
        if let nav = navigation {
            self.navigation = nav
            self.navigation?.pushViewController(view, animated: false)
        } else {
            self.navigation = UINavigationController(rootViewController: view)
            rootView?.present(self.navigation!, animated: true)
        }
    }
    

    
}

extension HomeScreenRouter: HomeScreenRouterProtocol {
    

    
    func goDetailsViewController(_ dataRecipes: DishesDTO) {
        let router = DetailsDishRouter(data: dataRecipes)
        router.start(navigation: navigation)
    }
}



