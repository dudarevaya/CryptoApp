//
//  LoginViewModel.swift
//  CryptoApp
//
//  Created by Яна Дударева on 20.10.2022.
//

import Foundation
import UIKit

class LoginViewModel: LoginViewModelProtocol {
    
    func saveData(vc: UIViewController, complition: () -> Void) {
        complition()
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLogged)
    }
    
    func checkErrorLogin(textField: UITextField, errorLabel: UILabel) {
        for _ in textField.text ?? "" {
            if textField.text?.count ?? 0 < 4 {
                errorLabel.text = "login must contain at least 4 characters"
                errorLabel.textColor = .systemRed
            } else {
                errorLabel.text = ""
            }
        }
    }
    
    func checkErrorPassword(textField: UITextField, errorLabel: UILabel) {
        for _ in textField.text ?? "" {
            if textField.text?.count ?? 0 < 4 {
                errorLabel.text = "password must contain at least 4 characters"
                errorLabel.textColor = .systemRed
            } else {
                errorLabel.text = ""
            }
        }
    }
}
