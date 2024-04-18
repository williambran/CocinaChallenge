//
//  HomeScreenRouter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation
import UIKit


class HomeScreenRouter: RouterProtocol {
    
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
        rootView = view
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
    func showListSugestion(vc: UIViewController) {
        guard let contentSuggestionView = rootView?.contenListView else { return }
        rootView?.add(child: vc, container: contentSuggestionView)
    }
    
    func goDetails() {
        
    }
    

    
    
}



