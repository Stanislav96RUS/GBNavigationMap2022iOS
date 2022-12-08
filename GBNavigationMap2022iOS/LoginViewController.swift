//
//  LoginViewController.swift
//  GBNavigationMap2022iOS
//
//  Created by Stanislav on 27.11.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel?
    
    var onPhoto: (() -> Void)?
    
    @IBAction func takePicture(_ sender: Any) {
//        onPhoto?()
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return }
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)

    }

    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.autocorrectionType = .no
        }
    }
    
    @IBOutlet weak var inputButton: UIButton!
    
    let realmService = RealmService()
    
    private func configureLoginBindings() {
        Observable
            .combineLatest(
                self.loginTextField.rx.text,
                self.passwordTextField.rx.text
            )
            .map { login, password in
                return !(login ?? "").isEmpty && (password ?? "").count >= 6
            }
            .bind { [weak inputButton] inputFilled in
                inputButton?.isEnabled = inputFilled
            }
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { return }
        
        if let users = self.realmService.read(object: UserModel.self, filter: "login == '\(login)'") as? [UserModel],
           let user = users.first,
           user.password == password {
            viewModel?.goToUserScreen()
        } else {
            self.showLoginError()
        }
    }
    
    @IBAction func didTapRegistrationButton(_ sender: UIButton) {

        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { return }
        
        if let users = self.realmService.read(object: UserModel.self, filter: "login == '\(login)'") as? [UserModel],
           let user = users.first {
            print("Пользователю \(user.login) будет изменен пароль")
        }
        
        let user = UserModel(login: login, password: password)
        self.realmService.add(model: user)
        
        viewModel?.goToUserScreen()
    }
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Введите корректные данные", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   
    
}

extension LoginViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func imagePickerController(
        _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
            
            picker.dismiss(animated: true) { [weak self] in
            
                guard let image = self?.extractImage(from: info) else { return }
            
//                self?.onTakePicture?(image)
                
            }
        }
    
    private func extractImage(from info: [String: Any]) -> UIImage? {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            return image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            return image
            
        } else {
                return nil
        }
    }
}
