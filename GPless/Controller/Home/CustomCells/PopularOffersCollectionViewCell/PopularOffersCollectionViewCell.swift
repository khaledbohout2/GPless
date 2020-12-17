//
//  PopularOffersCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class PopularOffersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var priceBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        
        self.offerTitleLbl.text = offer.name
        self.offerTitleLbl.setLocalization()
        self.storeNameLbl.text = offer.vendorName
        self.storeNameLbl.setLocalization()
        self.priceBtn.setTitle("\(offer.priceAfterDiscount!)", for: .normal)
        self.priceBtn.setLocalization()
        self.offerImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.offersLink ?? "") + "/" + (offer.imageLink ?? "")))
    }
    
    
    @IBAction func priceBtnTapped(_ sender: Any) {
        
    }
    
}
