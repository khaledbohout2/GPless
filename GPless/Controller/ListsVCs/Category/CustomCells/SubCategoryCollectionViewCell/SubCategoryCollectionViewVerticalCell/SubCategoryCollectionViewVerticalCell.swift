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
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesSubTableViewCell", for: indexPath) as! CategoriesSubTableViewCell
        
        
        let category = categories[indexPath.row]
        
        let categoryLink = (SharedSettings.shared.settings?.categoriesLink) ?? ""
        let photoLink = category.photoLink ?? ""
        cell.categoryImage.sd_setImage(with: URL(string: categoryLink + "/" + photoLink))
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.navigateToListVC(category: categories[indexPath.row])
    }
    
    
}

extension SubCategoryCollectionViewVerticalCell: VerticalCellDelegate {
    
    func navigateToListVC(category: CategoryElement) {
        
        self.delegate?.navigateToListVC(category: category)
    }
    
    
}

protocol VerticalCellDelegate: class {
    func navigateToListVC(category: CategoryElement)
}
