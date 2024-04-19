//
//  MapRouter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import Foundation
import UIKit


class MapRouter: RouterProtocol {
    
    var rootView: UIViewController?
    var navigation: UINavigationController?
    var data: LocationOriginDto?
    
    func start(navigation: UINavigationController?) {
        let view = MapViewController.instantiate(from: "MapViewController")
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        
        presenter.dataLocation = data
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
extension MapRouter: MapRouterProtocol {
    func informationLocationRouter(title: String?, description: String?, urlImg: String?) {
        //Levantar Modal
        let view = LocationViewController.instantiate(from: "LocationViewController")
        view.imgCoverStr = urlImg
        view.titleStr = title
        view.descriptionStr = description
        view.modalPresentationStyle = .pageSheet
        navigation?.present(view, animated: true)
        view.setViewDetents()
    }
    
    
}
