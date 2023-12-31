//
//  PeopleViewController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 26.06.2023.
//

import UIKit

class PeopleViewController: UIViewController {
    
    let users = Bundle.main.decode([KUser].self, from: "users.json")
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, KUser>!
    
    enum Section: Int, CaseIterable {
        case users
        func description(usersCount: Int) -> String {
            switch self {
            case .users:
                return "\(usersCount) people nearby"
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData(with: nil)
        
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reusedId)
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reusedId)
      
        
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
    
    private func reloadData(with serachText: String?) {
        let filtered = users.filter { (user) -> Bool in
            user.contains(filter: serachText)
            
        }
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, KUser>()
        snapshot.appendSections([.users])
        snapshot.appendItems(filtered, toSection: .users)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension PeopleViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, KUser>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind")}
            
            switch section {
                
            case .users:
                return self.configure(collectionView: collectionView, cellType: UserCell.self, with: user, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reusedId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header")}
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind") }
            
            let items = self.dataSource.snapshot().itemIdentifiers(inSection: .users)

            sectionHeader.configure(text: section.description(usersCount: items.count),
                                    font: .systemFont(ofSize: 36, weight: .light),
                                    textColor: .darkGray)
            
            return sectionHeader
        }
    }
}

//MARK: UISearchBar Delegate
extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(with: searchText)
    }
}

extension PeopleViewController {
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .users:
                return self.createUsersSection()
            }
        }
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.interSectionSpacing = 20
            layout.configuration = config
            return layout
        }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
       
        return sectionHeader
    }
    
    private func createUsersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let spacing = CGFloat(15)
        
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 15, bottom: 0, trailing: 15)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
 
}

//MARK: SwiftUI
import SwiftUI

struct PeopleVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainTabBarController()
        
        func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PeopleVCProvider.ContainerView>) -> MainTabBarController {
            return viewController
        }
    }
}
