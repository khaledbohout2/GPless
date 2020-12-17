//
//  PointsCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class PointsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageImageView: UIImageView!
    @IBOutlet weak var offerDetailsLbl: UILabel!
    @IBOutlet weak var pointsCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        
        let baseOfferLink = SharedSettings.shared.settings?.offersLink ?? ""
        let imageLink = offer.imageLink ?? ""
        self.productImageImageView.sd_setImage(with: URL(string: baseOfferLink + "/" + imageLink))
        self.offerDetailsLbl.text = offer.name
        self.pointsCountLbl.text = "\(offer.points!)"
    }

}
