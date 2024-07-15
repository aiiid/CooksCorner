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
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupDataSource()
    }
    
    private func setupDataSource() {
        contentView.mainCollectionView.dataSource = self
        contentView.mainCollectionView.delegate = self
        contentView.mainCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.reuseIdentifier,
            for: indexPath
        ) as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        let category = viewModel.categories[indexPath.row]
        cell.configure(with: category)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
