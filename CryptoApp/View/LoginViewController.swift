//
//  ViewController.swift
//  CryptoApp
//
//  Created by Яна Дударева on 06.10.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var login, password: String?
    var viewModel: LoginViewModelProtocol?
    
    //MARK: Outlets
    
    private lazy var loginLabel: UILabel = {
        var label = UILabel()
        label.text = "Login:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Password:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter login"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = .center
        
        textField.addTarget(self, action: #selector(checkErrorLogin(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var errorLoginLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter password"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = .center
        
        textField.addTarget(self, action: #selector(checkErrorPassword(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var errorPasswordLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        var button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(errorLoginLabel)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(errorPasswordLabel)
        stackView.addArrangedSubview(saveButton)
        stackView.setCustomSpacing(20, after: errorPasswordLabel)
        return stackView
    }()
    
    //MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        viewModel = LoginViewModel()
        
        setUpButton()
        setupViews()
        setupConstraints()
    }
    
    //MARK: Actions
    
    @objc func editingChanged(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        saveButton.alpha = 0.5
        saveButton.isEnabled = ![loginTextField, passwordTextField].compactMap {
            $0.text?.isEmpty
        }.contains(true)
        if (loginTextField.text!.count >= 4 && passwordTextField.text!.count >= 4) {
            saveButton.alpha = 1.0
        }
    }
    
    @objc func checkErrorLogin(_ textField: UITextField) {
        viewModel?.checkErrorLogin(textField: textField, errorLabel: errorLoginLabel)
    }
    
    @objc func checkErrorPassword(_ textField: UITextField) {
        viewModel?.checkErrorPassword(textField: textField, errorLabel: errorPasswordLabel)
    }
    
    @objc func saveData() {
        viewModel?.saveData(vc: self) {
            login = loginTextField.text
            password = passwordTextField.text
            let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            sceneDelegate.goToTableViewController(selfVC: self)
        }
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: SetupViews
    
    func setUpButton() {
        saveButton.isEnabled = false
        [loginTextField, passwordTextField].forEach {
            $0?.addTarget(self,
                          action: #selector(editingChanged(_:)),
                          for: .editingChanged)
            }
    }
    
    private func setupViews() {
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

