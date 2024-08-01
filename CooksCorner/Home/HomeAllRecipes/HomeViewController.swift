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
    private var selectedCategoryIndex: IndexPath?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        registerCells()
        bindViewModel()
        viewModel.fetchRecipes()
        fetchUserProfile()
    }
    
    private func bindViewModel() {
        viewModel.updateUI = { [weak self] in
            self?.contentView.mainCollectionView.reloadData()
        }
    }
    
    private func setupDataSource() {
        contentView.mainCollectionView.dataSource = self
        contentView.mainCollectionView.delegate = self
    }
    
    private func registerCells() {
        contentView.mainCollectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: HeaderView.sectionHeaderElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier
        )
        contentView.mainCollectionView.register(
            CategoryNameCell.self,
            forCellWithReuseIdentifier: CategoryNameCell.reuseIdentifier
        )
        contentView.mainCollectionView.register(
            CategoryRecipeCell.self,
            forCellWithReuseIdentifier: CategoryRecipeCell.reuseIdentifier
        )
    }
    
    private func fetchUserProfile() {
        NetworkManager.shared.fetchUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                print("Profile fetched successfully")
                // You can store this profile somewhere if needed, e.g., in a singleton or pass to the ProfileViewController
            case .failure(let error):
                print("Failed to fetch profile: \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewController: CategoryRecipeCellDelegate {
    func didSelectRecipe(_ recipe: RecipeModel) {
        NetworkManager.shared.getRecipeById(id: recipe.id) { [weak self] result in
            switch result {
            case .success(let recipeDetail):
                let detailViewController = RecipeDetailViewController(recipe: recipeDetail)
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            case .failure(let error):
                print("Failed to fetch recipe details: \(error.localizedDescription)")
            }
        }
    }

    private func searchAuthorByName(name: String) {
        NetworkManager.shared.searchAuthorByName(name: name) { [weak self] result in
            switch result {
            case .success(let authors):
                guard let author = authors.first else {
                    print("No authors found")
                    return
                }
                self?.fetchAuthorDetails(by: author.id)
            case .failure(let error):
                print("Failed to search author: \(error.localizedDescription)")
            }
        }
    }

    private func fetchAuthorDetails(by id: Int) {
        NetworkManager.shared.getAuthorById(id: id) { [weak self] result in
            switch result {
            case .success(let authorDetail):
                let authorProfileViewModel = AuthorProfileViewModel(detailModel: authorDetail)
                let authorProfileViewController = AuthorProfileViewController(viewModel: authorProfileViewModel)
                self?.navigationController?.pushViewController(authorProfileViewController, animated: true)
            case .failure(let error):
                print("Failed to fetch author details: \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == HeaderView.sectionHeaderElementKind,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath
              ) as? HeaderView else {
            fatalError("Cannot create header view")
        }
        header.configure(with: "Category")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionLayoutKind = Section.allCases[indexPath.section]
        
        switch sectionLayoutKind {
        case .foodCategories:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryNameCell.reuseIdentifier,
                for: indexPath
            ) as? CategoryNameCell else {
                return UICollectionViewCell()
            }
            
            let category = viewModel.categories[indexPath.row]
            let isSelected = indexPath == selectedCategoryIndex
            cell.configure(with: category, isSelected: isSelected)
            return cell
            
        case .foodRecipes:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryRecipeCell.reuseIdentifier,
                for: indexPath
            ) as? CategoryRecipeCell else {
                return UICollectionViewCell()
            }
            let category = viewModel.categories[indexPath.row]
            cell.delegate = self
            cell.configure(with: category)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionLayoutKind = Section.allCases[indexPath.section]
        
        switch sectionLayoutKind {
        case .foodCategories:
            selectedCategoryIndex = indexPath
            collectionView.reloadSections(IndexSet(integer: Section.allCases.firstIndex(of: .foodCategories)!))
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateSelectedCategoryBasedOnVisibleSection()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updateSelectedCategoryBasedOnVisibleSection()
        }
    }
    
    private func updateSelectedCategoryBasedOnVisibleSection() {
        guard let visibleIndexPaths = contentView.mainCollectionView.indexPathsForVisibleItems.first else { return }
        let sectionLayoutKind = Section.allCases[visibleIndexPaths.section]
        
        switch sectionLayoutKind {
        case .foodRecipes:
            let categoryIndex = visibleIndexPaths.item
            selectedCategoryIndex = IndexPath(item: categoryIndex, section: Section.allCases.firstIndex(of: .foodCategories)!)
            contentView.mainCollectionView.reloadSections(IndexSet(integer: Section.allCases.firstIndex(of: .foodCategories)!))
        default:
            break
        }
    }
}
