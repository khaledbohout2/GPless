//
//  categoriesCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit
import SDWebImage

class categoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(category: CategoryElement) {
        
        self.categoryTitleLbl.text = category.categoryName
        self.categoryTitleLbl.setLocalization()
        let categoryLink = SharedSettings.shared.settings?.categoriesLink ?? ""
        let photoLink = category.photoLink ?? ""
        categoryImageView.sd_setImage(with: URL(string: categoryLink + "/" + photoLink), placeholderImage: UIImage(named: ""))
        
        
    }

}
