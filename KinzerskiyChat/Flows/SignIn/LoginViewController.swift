//
//  LoginViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 26.06.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    let loginWithLabel = UILabel(text: "Login with")
    let ordLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountdLabel = UILabel(text: "Need an account?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailTextField = OneLineTextfield(font: .avenir20())
    let passwordTextField = OneLineTextfield(font: .avenir20())
    
    let logInButton = UIButton(title: "Log in", titleColor: .white, backgroundColor: .buttonBlack())
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .avenir20()
        button.setTitleColor(.buttonRed(), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleButton.customizedGoogleButton()
        view.backgroundColor = .white
        setupConstraints()
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logInButtonTapped() {
        AuthManager.shared.login(email: emailTextField.text, password: passwordTextField.text) { (result) in
            switch result {
                
            case .success(let user):
                self.showAlert(with: "succssess", message: "you are authorized")
            case .failure(let error):
                self.showAlert(with: "error!", message: error.localizedDescription)
            }
        }
    }
    
}

//MARK: Setup constraints
extension LoginViewController {
    
    private func setupConstraints() {
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel,
                                                            emailTextField],
                                         axis: .vertical,
                                         spacing: 0)
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,
                                                            passwordTextField],
                                         axis: .vertical,
                                         spacing: 0)
        
        
        logInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [loginWithView,
                                                      ordLabel,
                                                       emailStackView,
                                                       passwordStackView,
                                                       logInButton],
                                    axis: .vertical, spacing: 20)
        
        signInButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountdLabel, signInButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            bottomStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
        ])
    }
}


//MARK: SwiftUI
import SwiftUI

struct LoginProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        }
        
        let viewController = LoginViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginProvider.ContainerView>) -> LoginViewController {
            return viewController
        }
    }
}


