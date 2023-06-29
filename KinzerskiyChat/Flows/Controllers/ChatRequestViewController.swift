//
//  ChatRequestViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 29.06.2023.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}


//MARK: SwiftUI
import SwiftUI

struct ChatRequestProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = ChatRequestViewController()
        
        func updateUIViewController(_ uiViewController: ChatRequestViewController, context: Context) {
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChatRequestProvider.ContainerView>) -> ChatRequestViewController {
            return viewController
        }
    }
}
