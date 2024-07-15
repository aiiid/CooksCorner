//
//  HomeView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//
import UIKit
import SnapKit

class HomeView: BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainCollectionView.collectionViewLayout = configureMainCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        mainCollectionView.collectionViewLayout = configureMainCollectionViewLayout()
    }
    
    private func configureMainCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            return self.categorySection()
        }
        return layout
    }
    
    private func categorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
