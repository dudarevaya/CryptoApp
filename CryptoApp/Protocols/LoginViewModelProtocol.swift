//
//  LoginViewModelProtocol.swift
//  CryptoApp
//
//  Created by Яна Дударева on 21.10.2022.
//

import Foundation
import UIKit

protocol LoginViewModelProtocol {
    func saveData(vc: UIViewController, complition: () -> Void)
    func checkErrorLogin(textField: UITextField, errorLabel: UILabel)
    func checkErrorPassword(textField: UITextField, errorLabel: UILabel)
}
