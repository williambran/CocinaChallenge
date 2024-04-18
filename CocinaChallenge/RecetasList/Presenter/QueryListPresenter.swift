//
//  QueryListPresenter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import Foundation


class QueryListPresenter: PresenterProtocol {
    
    var view: HomeScreenViewProtocol?
    var interactor: HomeScreenInteractorProtocol?
    var router: HomeScreenRouterProtocol?
    
    
}
extension QueryListPresenter : QueryListPresenterProtocol {}
