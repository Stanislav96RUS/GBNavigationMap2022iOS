//
//  AppCoordinator.swift
//  GBNavigationMap2022iOS
//
//  Created by Stanislav on 27.11.2022.
//

import Foundation
import UIKit
import AVFoundation

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigation: UINavigationController
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    func start() {
        goToLoginPage()
    }
    
    func goToLoginPage(isLogOut: Bool = false) {
        
        if isLogOut {
            navigation.popViewController(animated: true)
            return
        }
        
        instantiateLoginViewController()
        
    }
    
    private func instantiateLoginViewController() {
        
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        
        let loginViewModel = LoginViewModel()
        loginViewModel.appCoordinator = self
        loginViewController.viewModel = loginViewModel
        navigation.pushViewController(loginViewController, animated: true)
        
    }
    
    func goToUserPage() {
        guard let userViewController = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
        
        let userViewModel = UserViewModel()
        userViewModel.appCoordinator = self
        userViewController.viewModel = userViewModel
        navigation.pushViewController(userViewController, animated: true)
    }
    
    func funcShowSelfyModule(image: UIImage) {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SelfyViewController") as? SelfyViewController else { return }
        
        controller.image = image
        
        navigation.pushViewController(controller, animated: true)
        
    }
    
    func showPhotoModule() {
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return }
        
        //        self?.showSelfyModule(image: image)
        
        navigation.pushViewController(controller, animated: true)
        
    }
    
//    func showMainModule() {
//
//        guard let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
//
//        controller.onMap = { [weak self] usseles in self?.showMapModule(usseles: usseles)
//        }
//        controller.onLogount = { [weak self] in self?.onFinishFlow?()
//        }
//        controller.onTakePicture = { [weak self] image in self?.funcShowSelfyModule(image: image)
//        }
//        let rootController = UINavigationController(rootViewController: controller)
//
//        setAsRoot(rootController)
//
//        self.rootController = rootController
//
//        controller.onPhoto = { [weak self] in self?.showPhotoModule()
//        }
//
//
//    }
}
