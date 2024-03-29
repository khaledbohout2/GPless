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
        let iconsLink = SharedSettings.shared.settings?.iconsLink ?? ""
        let imageLink = category.icon ?? ""
        self.categoryImageView.sd_setImage(with: URL(string: iconsLink + "/" + imageLink))
    }

}
