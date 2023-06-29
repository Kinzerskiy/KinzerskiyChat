//
//  ProfileViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 29.06.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    let containerView = UIView()
    let imageView = UIImageView(image: UIImage(imageLiteralResourceName: "human4"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Peter", font: .systemFont(ofSize: 20, weight: .light))
    let aboutMeLabel = UILabel(text: "You have an opportunity to chat with the best man in the world!", font: .systemFont(ofSize: 16, weight: .light))
    let myTextfield = InsertableTextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        setupConstraints()
        castomizeElements()
       
        
    }
    
    private func castomizeElements() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextfield.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .mainWhite()
        containerView.layer.cornerRadius = 30
        aboutMeLabel.numberOfLines = 0
        
        if let button = myTextfield.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
        
        
    }
    
     @objc private func sendMessage() {
        print(#function)
    }
}


extension ProfileViewController {
    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMeLabel)
        containerView.addSubview(myTextfield)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206)
            
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
            
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant:  35),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant:  10),
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            myTextfield.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant:  10),
            myTextfield.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            myTextfield.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            myTextfield.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}


//MARK: SwiftUI
import SwiftUI

struct ProfileProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = ProfileViewController()
        
        func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileProvider.ContainerView>) -> ProfileViewController {
            return viewController
        }
    }
}
