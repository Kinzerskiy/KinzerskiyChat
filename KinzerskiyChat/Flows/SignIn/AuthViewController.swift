//
//  AuthViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 24.06.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: UIImage(imageLiteralResourceName: "up (1)"), contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign with")
    let alreadyOnBoardLabel = UILabel(text: "Already on board?")
    
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonBlack())
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleButton.customizedGoogleButton()
        view.backgroundColor = .white
        setUpConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtontapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtontapped), for: .touchUpInside)
    }
    
    @objc private func emailButtontapped() {
        print("")
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtontapped() {
        print("")
        present(loginVC, animated: true, completion: nil)
    }
}

//MARK: - Setup constrsints
extension AuthViewController {
    private func setUpConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyOnBoardLabel, button: loginButton)
        
        let stackView = UIStackView.init(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 15)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        let logoHeight: CGFloat = 200
        let logoWidth: CGFloat = 200
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: logoHeight),
            logoImageView.widthAnchor.constraint(equalToConstant: logoWidth)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


//MARK: SwiftUI
import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: AuthViewController, context: Context) {
        }
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
    }
}
