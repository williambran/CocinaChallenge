//
//  QueryListPresenter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import Foundation


class DetailsDishPresenter: PresenterProtocol, DetailsDishPresenterProtocol {

    
    
    var view: DetailsDishViewProtocol?
    var interactor: DetailsDishInteractorProtocol?
    var router: DetailsDishRouterProtocol?
    var dataRecipes: DishesDTO?
    
    
    func gotToMapView(data: LocationOriginDto?) {
        router?.mapRouter(data: data)
    }

}

extension DetailsDishPresenter: DetailsRecetaInteractorOutputProtocol {}
