//
//  LoginViewModel.swift
//  GBNavigationMap2022iOS
//
//  Created by Stanislav on 27.11.2022.
//

import Foundation

class LoginViewModel {
    weak var appCoordinator: AppCoordinator?
    
    func goToUserScreen() {
        appCoordinator?.goToMapPage()
    }
}
