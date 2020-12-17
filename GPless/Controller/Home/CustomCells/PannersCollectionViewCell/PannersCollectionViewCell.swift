//
//  PannersCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class PannersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(banner: String) {
        
        let imageBaseLink = SharedSettings.shared.settings?.whatIsTodayLink ?? ""
        let imageLink = banner
        
        self.bannerImageView.sd_setImage(with: URL(string: imageBaseLink + "/" + imageLink))
        
    }

}
