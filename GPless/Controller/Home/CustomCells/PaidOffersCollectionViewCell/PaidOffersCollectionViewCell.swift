//
//  PaidOffersCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class PaidOffersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLbl: UILabel!
    @IBOutlet weak var timeLeftLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var priceBtnTapped: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        
        self.offerImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.offersLink ?? "") + "/" + (offer.imageLink ?? "")))
        self.offerTitleLbl.text = offer.name
        self.offerTitleLbl.setLocalization()
        self.timeLeftLbl.text = offer.deletedAt
        self.timeLeftLbl.setLocalization()
        self.storeNameLbl.text = offer.vendorName
        self.storeNameLbl.setLocalization()
        self.priceBtnTapped.setTitle("\(offer.priceAfterDiscount!)", for: .normal)
        self.priceBtnTapped.setLocalization()
    }

}
