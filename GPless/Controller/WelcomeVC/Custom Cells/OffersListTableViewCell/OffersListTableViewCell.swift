//
//  OffersListTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 12/9/20.
//

import UIKit
import Cosmos

class OffersListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var offerPointsLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var savedMoneyLbl: UILabel!
    @IBOutlet weak var priceBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 118
    
    func configureCell(offer: OfferModel) {
        
        let baseOfferUrl = SharedSettings.shared.settings?.offersLink ?? ""
        let offerImage = offer.imageLink ?? ""
        
        let urlString = baseOfferUrl + "/" + offerImage
        
        self.offerImageView.sd_setImage(with: URL(string: urlString))
        self.offerTitleLbl.text = offer.name
        self.offerTitleLbl.setLocalization()
        
        self.storeNameLbl.text = offer.vendorName
        self.storeNameLbl.setLocalization()
        
        self.offerPointsLbl.text = "\(offer.points!)"
        self.offerPointsLbl.setLocalization()
        
        self.ratingView.rating = Double(offer.avgRate ?? 0) 
        
        self.savedMoneyLbl.text = "saving".localizableString() +  "\(offer.discount!)"
        self.savedMoneyLbl.setLocalization()
        
        self.priceBtn.setTitle("\(offer.priceAfterDiscount!)", for: .normal)
        
    }

    
}
