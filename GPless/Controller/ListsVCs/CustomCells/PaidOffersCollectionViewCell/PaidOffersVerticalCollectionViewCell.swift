//
//  PaidOffersVerticalCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit
import Cosmos

class PaidOffersVerticalCollectionViewCell: UICollectionViewCell {

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
    
    func configureCell(offer: OfferModel) {
       // self.offerImageView.image =
        self.offerTitleLbl.text = offer.name
       // self.storeNameLbl.text = offer.store
        self.offerPointsLbl.text = "\(offer.points!)"
     //   self.ratingView.rating = offer.
        self.savedMoneyLbl.text = "\(offer.discount!)"
        self.priceBtn.setTitle("\(offer.priceAfterDiscount!)", for: .normal)
        
    }
    
    @IBAction func priceBtnTapped(_ sender: Any) {
        
    }
    
}
