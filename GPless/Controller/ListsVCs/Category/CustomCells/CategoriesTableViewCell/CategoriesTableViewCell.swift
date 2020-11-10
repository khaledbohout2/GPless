//
//  CategoriesTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    weak var delegate: VerticalCellDelegate?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCollectionView()
        // Initialization code
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
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewCell", for: indexPath)
        return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewVerticalCell", for: indexPath) as! SubCategoryCollectionViewVerticalCell
            cell.delegate = self
            return cell
            
        }
            
        } else {
            
            if indexPath.row == 0 {
                
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewVerticalCell", for: indexPath)
            return cell
                
            } else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewCell", for: indexPath) as! SubCategoryCollectionViewCell
                return cell
                
            }
                
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: self.contentView.frame.width / 2, height: self.contentView.frame.height)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.navigateToListVC()
        
    }
    
    
}

extension CategoriesTableViewCell: VerticalCellDelegate {
    func navigateToListVC() {
        self.delegate?.navigateToListVC()
    }
    
    
}
