//
//  SubCategoryCollectionViewVerticalCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class SubCategoryCollectionViewVerticalCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriesSubTableView: UITableView!
    
    weak var delegate: VerticalCellDelegate?
    var categories = [CategoryElement]()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initTableView()
        // Initialization code
    }
    
    func configureCell(categories: [CategoryElement]) {
        
        self.categories = categories
        self.categoriesSubTableView.reloadData()
    }
    
    func initTableView() {
        
        let nib = UINib(nibName: "CategoriesSubTableViewCell", bundle: nil)
        categoriesSubTableView.register(nib, forCellReuseIdentifier: "CategoriesSubTableViewCell")
        categoriesSubTableView.delegate = self
        categoriesSubTableView.dataSource = self
    }

}

extension SubCategoryCollectionViewVerticalCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesSubTableViewCell", for: indexPath) as! CategoriesSubTableViewCell
        cell.categoryImage.image = UIImage(named: "image")
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.navigateToListVC()
    }
    
    
}

extension SubCategoryCollectionViewVerticalCell: VerticalCellDelegate {
    
    func navigateToListVC() {
        
        self.delegate?.navigateToListVC()
    }
    
    
}

protocol VerticalCellDelegate: class {
    func navigateToListVC()
}
