//
//  HomeView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//
import UIKit
import SnapKit

enum Section: String, CaseIterable {
    case foodCategories = "Food categories"
    case foodRecipes = "Food Recipes"
}

class HomeView: BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainCollectionView.collectionViewLayout = generateLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        mainCollectionView.collectionViewLayout = generateLayout()
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [self] sectionIndex, environment in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .foodCategories:
                return foodCategorySection()
            case .foodRecipes:
                return foodRecipeSection()
            }
        }
    }
    
    private func foodCategorySection() -> NSCollectionLayoutSection {
        let padding = Constants.Padding.medium
        let interGroupSpacing = Constants.Padding.medium
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.05)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 5, trailing: padding)
        section.interGroupSpacing = interGroupSpacing
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    //    private func foodRecipeSection() -> NSCollectionLayoutSection {
    //            let itemSize = NSCollectionLayoutSize(
    //                widthDimension: .fractionalWidth(1.0),
    //                heightDimension: .fractionalHeight(1.0)
    //            )
    //            let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //            
    //            let groupSize = NSCollectionLayoutSize(
    //                widthDimension: .fractionalWidth(1.0),
    //                heightDimension: .fractionalHeight(1.0)
    //            )
    //            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //            
    //            let section = NSCollectionLayoutSection(group: group)
    //            section.orthogonalScrollingBehavior = .groupPaging
    //            
    //            return section
    //        }
    
    private func foodRecipeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(10)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

