//
//  HomeViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//
import UIKit

class HomeViewController: UIViewController {
    private let contentView = HomeView()
    private let viewModel = HomeViewModel()
    private var selectedCategoryIndex: IndexPath? {
        didSet {
            if let selectedCategoryIndex = selectedCategoryIndex {
                scrollToRecipesSection(for: selectedCategoryIndex.row)
            }
        }
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupDataSource()
        registerCells()
    }
    
    private func setupDataSource() {
        contentView.mainCollectionView.dataSource = self
        contentView.mainCollectionView.delegate = self
    }
    
    private func registerCells() {
        contentView.mainCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        contentView.mainCollectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
    }
    
    private func scrollToRecipesSection(for categoryIndex: Int) {
        let indexPath = IndexPath(item: categoryIndex, section: Section.allCases.firstIndex(of: .foodRecipes)!)
        contentView.mainCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func updateSelectedCategoryBasedOnVisibleSection() {
        guard let visibleIndexPaths = contentView.mainCollectionView.indexPathsForVisibleItems.first else { return }
        let sectionLayoutKind = Section.allCases[visibleIndexPaths.section]
        
        switch sectionLayoutKind {
        case .foodCategories:
            selectedCategoryIndex = visibleIndexPaths
            contentView.mainCollectionView.reloadSections(IndexSet(integer: Section.allCases.firstIndex(of: .foodCategories)!))
        default:
            break
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionLayoutKind = Section.allCases[section]
        
        switch sectionLayoutKind {
        case .foodCategories:
            return viewModel.categories.count
        case .foodRecipes:
            return viewModel.recipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionLayoutKind = Section.allCases[indexPath.section]
        
        switch sectionLayoutKind {
        case .foodCategories:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.reuseIdentifier,
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            
            let category = viewModel.categories[indexPath.row]
            let isSelected = indexPath == selectedCategoryIndex
            cell.configure(with: category, isSelected: isSelected)
            return cell
            
        case .foodRecipes:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecipeCell.reuseIdentifier,
                for: indexP
