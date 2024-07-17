//
//  RecipeDetailViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    private let detailView = RecipeDetailView()
    private let recipe: RecipeModel
    
    override func loadView() {
        view = detailView
    }
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
        setupDataSource()
    }
    private func loadContent() {
        detailView.ingridientsTableView.reloadData()
        detailView.set(recipe: recipe)
    }
    
    private func setupDataSource() {
        detailView.ingridientsTableView.dataSource = self
        detailView.ingridientsTableView.delegate = self
    }
    
    
    
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        cell.textLabel!.text = "Title text"
        cell.accessoryType = .checkmark
        return cell
//        let review = tour.reviews[indexPath.row]
//        cell.configure(with: review)
        
    }
}
