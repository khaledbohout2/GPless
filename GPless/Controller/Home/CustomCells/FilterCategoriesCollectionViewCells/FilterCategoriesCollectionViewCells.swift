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
        self.categoryTitleLbl.setLocalization()
        let categoryLink = SharedSettings.shared.settings?.categoriesLink ?? ""
        let imageLink = category.photoLink ?? ""
        self.categoryImageView.sd_setImage(with: URL(string: categoryLink + "/" + imageLink))
    }

}
