//
//  FeatureBrandsCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class FeatureBrandsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var brandImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(brand: Brand) {
        
        print(brand.photoLink)
        
        self.brandImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.usersPhotoLink)! + "/" + brand.photoLink!))
        
    }

}
