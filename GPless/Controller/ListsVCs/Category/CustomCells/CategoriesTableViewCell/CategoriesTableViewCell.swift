//
//  CategoriesTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    var categories = [CategoryElement]()
    
    weak var delegate: VerticalCellDelegate?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCollectionView()
        // Initialization code
    }
    
    func configureCell(categories: [CategoryElement]) {
        
        self.categories = categories
        self.subCategoriesCollectionView.reloadData()
    }
    
    func initCollectionView() {
        
        let nib = UINib(nibName: "SubCategoryCollectionViewCell", bundle: nil)
        subCategoriesCollectionView.register(nib, forCellWithReuseIdentifier: "SubCategoryCollectionViewCell")
        
        let verticalNib = UINib(nibName: "SubCategoryCollectionViewVerticalCell", bundle: nil)
        subCategoriesCollectionView.register(verticalNib, forCellWithReuseIdentifier: "SubCategoryCollectionViewVerticalCell")
        
        subCategoriesCollectionView.delegate = self
        subCategoriesCollectionView.dataSource = self
    }
    
}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.index % 2 == 0 {
        
        if indexPath.row == 0 {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewCell", for: indexPath) as! SubCategoryCollectionViewCell
            // index 0
            cell.categoryImageView.image = UIImage(named: "foregrt password")
        return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewVerticalCell", for: indexPath) as! SubCategoryCollectionViewVerticalCell
            if categories.count == 3 {
            let categories = [self.categories[1], self.categories[2]]
            cell.configureCell(categories: categories)
            }
            cell.delegate = self
            return cell
            
        }
            
        } else {
            
            if indexPath.row == 0 {
                
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewVerticalCell", for: indexPath) as! SubCategoryCollectionViewVerticalCell
                print(categories.count)
                if categories.count == 3 {
                let categories = [self.categories[0], self.categories[1]]
                cell.configureCell(categories: categories)
                }
            return cell
                
            } else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewCell", for: indexPath) as! SubCategoryCollectionViewCell
                // index 2
                cell.categoryImageView.image = UIImage(named: "foregrt password")
                return cell
                
            }
                
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: self.contentView.frame.width / 2, height: self.contentView.frame.height)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.navigateToListVC(category: categories[indexPath.row])

    }
    
}

extension CategoriesTableViewCell: VerticalCellDelegate {
    func navigateToListVC(category: CategoryElement) {
        self.delegate?.navigateToListVC(category: category)
    }
    
    
}
