//
//  LaucherScreenInteractor.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import Foundation


class SplashInteractor: SplashInteractorProtocol {
    var presenter: SplashInteractorOutputProtocol?
    
    func setupDB() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){ [weak self] in
            self?.presenter?.configFinish()
        }
    }
    
    
}
