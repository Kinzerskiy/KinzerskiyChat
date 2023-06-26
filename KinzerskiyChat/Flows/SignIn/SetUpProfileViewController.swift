//
//  SetUpProfileViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 26.06.2023.
//

import UIKit

class SetUpProfileViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Set up profile", font: .avenir26())
    
    let fullNameLabel = UILabel(text: "Full name")
    let aboutMeLabel = UILabel(text: "About me")
    let sexlLabel = UILabel(text: "Sex")
    
    let fullNameTextField = OneLineTextfield(font: .avenir20())
    let aboutMeTextField = OneLineTextfield(font: .avenir20())
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonBlack(), cornerRadius: 12)
    
    let fullImageview = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
}

//MARK: Setup constraints
extension SetUpProfileViewController {
    private func setupConstraints() {
        
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField],
                                            axis: .vertical,
                                            spacing: 0)
        
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField],
                                            axis: .vertical,
                                            spacing: 0)
        
        let sexStackView = UIStackView(arrangedSubviews: [sexlLabel, sexSegmentedControl],
                                            axis: .vertical,
                                            spacing: 12)
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
            fullNameStackView,
            aboutMeStackView,
            sexStackView,
            goToChatsButton
        ],
                                    axis: .vertical,
                                    spacing: 40)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        fullImageview.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(fullImageview)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fullImageview.topAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: 100),
            fullImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageview.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
       
        
    }
}


//MARK: SwiftUI
import SwiftUI

struct SetUpProfileProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: SetUpProfileViewController, context: Context) {
        }
        
        let viewController = SetUpProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetUpProfileProvider.ContainerView>) -> SetUpProfileViewController {
            return viewController
        }
    }
}


