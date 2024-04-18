//
//  LaucherScreenPresenter.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation



class SplashPresenter: PresenterProtocol {

    
    var view: SplashViewProtocol?
    var interactor: SplashInteractorProtocol?
    var router: SplashRouterProtocol?
    
}


extension SplashPresenter: SplashPresenterProtocol {
    func finishProcesing() {
        //Validar si es primelra vez
        if UserDefaults.standard.bool(forKey: "firstSesion") {
            router?.goOnBoarding()
        } else {
            router?.goOnBoarding()
        }
    }
    

    func processing() {
        interactor?.setupDB()
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func configFinish() {
        view?.animatedIcon()
    }
}


    

