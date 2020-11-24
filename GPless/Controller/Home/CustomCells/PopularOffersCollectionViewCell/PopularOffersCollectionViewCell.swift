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
       // self.storeNameLbl.text = offer.
        self.priceBtn.setTitle("\(offer.priceAfterDiscount!)", for: .normal)
    }
    
    
    @IBAction func priceBtnTapped(_ sender: Any) {
        
    }
    
}
