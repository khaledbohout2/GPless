//
//  FilterCategoriesCollectionViewCells.swift
//  GPless
//
//  Created by Khaled Bohout on 11/4/20.
//

import UIKit

class FilterCategoriesCollectionViewCells: UICollectionViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    @IBOutlet weak var categoryImageContainerView: UIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(category: CategoryElement) {
        
        self.categoryTitleLbl.text = category.categoryName
   //     self.categoryImageView.image = 
    }

}
