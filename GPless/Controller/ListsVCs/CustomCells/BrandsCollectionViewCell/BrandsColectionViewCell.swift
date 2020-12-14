//
//  BrandsColectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class BrandsColectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(brand: Brand) {
        self.brandImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.usersPhotoLink ?? "") + "/" + (brand.photoLink ?? "")))

    }
    
}
