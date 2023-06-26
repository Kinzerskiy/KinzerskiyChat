//
//  ListViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 26.06.2023.
//

import UIKit



struct KChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: KChat, rhs: KChat) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class ListViewController: UIViewController {
    
    let activeChats = Bundle.main.decode([KChat].self, from: "activeChats.json")
    
    let waitingChats = Bundle.main.decode([KChat].self, from: "waitingChats.json")
    
    enum Section: Int, CaseIterable {
        case waitingChats, activeChats 
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, KChat>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        setupDataSource()
        reloadData()
    }
    
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid2")
      
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, KChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
                
                switch section {
                case .activeChats:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
                    cell.backgroundColor = .systemBlue
                    return cell
                    
                case .waitingChats:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid2", for: indexPath)
                    cell.backgroundColor = .systemRed
                    return cell
                }
            })
    }
    
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, KChat>()
        snapshot.appendSections([.waitingChats, .activeChats])
        
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)
       
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}

//MARK: Setup Collection Layout
extension ListViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .activeChats:
                return self.createActiveChats()
            case .waitingChats:
                return self.createWaitingChats()
            }
        }
        return layout
    }
    
    private func createWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
     private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
         section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}

//MARK: UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}



//MARK: SwiftUI
import SwiftUI

struct ListVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainTabBarController()
        
        func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) -> MainTabBarController {
            return viewController
        }
    }
}
