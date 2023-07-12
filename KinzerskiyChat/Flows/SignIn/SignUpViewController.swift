//
//  SignUpViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 26.06.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    let welcomeLabel = UILabel(text: "Hello!", font: .avenir26())
    
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswordLabel = UILabel(text: "Confirm password")
    let alreadyOnBoardLabel = UILabel(text: "Already on board?")
    
    let emailTextField = OneLineTextfield(font: .avenir20())
    let passwordTextField = OneLineTextfield(font: .avenir20())
    let confirmPasswordTextField = OneLineTextfield(font: .avenir20())
    
    let signUpbutton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonBlack(), cornerRadius: 12)
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .avenir20()
        button.setTitleColor(.buttonRed(), for: .normal)
        return button
    }()
    
    weak var delegate: AuthNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpConstraints()
        signUpbutton.addTarget(self, action: #selector(signUpbuttonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginpButtonTapped), for: .touchUpInside)

    }
    
    
    
    @objc private func signUpbuttonTapped() {
        
        AuthManager.shared.register(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text) { (result) in
            switch result {
                
            case .success(let user):
               
                self.showAlert(with: "Succssess!", message: "You are registred") {
                    self.present(SetUpProfileViewController(currentUser: user), animated: true, completion: nil)
                }
                
            case .failure(let error):
                self.showAlert(with: "error!", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func loginpButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }
}

extension SignUpViewController {
    private func setUpConstraints() {
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 0)
        
        signUpbutton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView,
                                                       passwordStackView,
                                                       confirmPasswordStackView,
                                                       signUpbutton],
                                          axis: .vertical,
                                          spacing: 40)
        loginButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnBoardLabel, loginButton],
                                          axis: .horizontal,
                                          spacing: 10)
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

struct SignUpProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: SignUpViewController, context: Context) {
        }
        
        let viewController = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpProvider.ContainerView>) -> SignUpViewController {
            return viewController
        }
    }
}

extension UIViewController {
    func showAlert(with title: String, message: String, completion: @escaping ()  -> Void = { } ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
