//
//  SetUpProfileViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 26.06.2023.
//

import UIKit

class SetUpProfileViewController: UIViewController {
    
    
    let fillImageview = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
}

//MARK: Setup constraints
extension SetUpProfileViewController {
    private func setupConstraints() {
        
        fillImageview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(fillImageview)
        
        NSLayoutConstraint.activate([
            fillImageview.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            fillImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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


