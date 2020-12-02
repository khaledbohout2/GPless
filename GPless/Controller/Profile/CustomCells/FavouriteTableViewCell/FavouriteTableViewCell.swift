//
//  FavouriteTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productDescriptionLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        
      //  self.offerImageView.image = offer.imageLink
        self.productNameLbl.text = offer.name
        self.productDescriptionLbl.text = offer.offerDescription
        self.productPriceLbl.text = "\(offer.priceAfterDiscount!)"
    }
    
}
