//
//  DetailsDishRouter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import Foundation
import UIKit


class DetailsDishRouter: RouterProtocol {
    
    
    var rootView: UIViewController?
    var navigation: UINavigationController?
    var data: DishesDTO?

    init(data: DishesDTO? = nil){
        self.data = data
    }
    
    func start(navigation: UINavigationController?) {
        let view = DetailsDishViewController.instantiate(from: "DetailsDishViewController")
        let interactor = DetailsDishInteractor()
        let presenter = DetailsDishPresenter()
        
        presenter.dataRecipes = data
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = self
        view.presenter = presenter
        
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
extension DetailsDishRouter: DetailsDishRouterProtocol {
    
    func mapRouter(data: LocationOriginDto? ) {
        let router = MapRouter()
        router.data = data
        router.start(navigation: navigation)
    }
    
    
    
}
