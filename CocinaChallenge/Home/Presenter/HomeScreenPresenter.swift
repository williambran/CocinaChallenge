//
//  HomeScreenPresenter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation

class HomeScreenPresenter: PresenterProtocol {
    
    var view: HomeScreenViewProtocol?
    var interactor: HomeScreenInteractorProtocol?
    var router: HomeScreenRouterProtocol?
    
    
}
extension HomeScreenPresenter : HomeScreenPresenterProtocol {
    func showListSuggestion() {
       // router?.showListSugestion(vc: view) Pendiente si da tiempo
    }
    
    func goBack() {
        
    }
    
    func getListRecetas() {
        interactor?.request()
    }
}

extension HomeScreenPresenter: HomeScreenInteractorOutputProtocol{
    func resultDishes(dishes: [DishesDTO]) {
        view?.loadData(dishes: dishes)
        
    }
    
    
}
