//
//  MapPresenter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import Foundation


class MapPresenter: PresenterProtocol , MapPresenterProtocol{

    

    weak var view: MapViewProtocol?
    weak var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    var dataLocation: LocationOriginDto?
    
    func showInformation(title: String?, description: String?, urlImg: String?) {
        router?.informationLocationRouter(title: title, description: description, urlImg: urlImg)
    }
    
}
extension MapPresenter: MapInteractorOutputProtocol{}

