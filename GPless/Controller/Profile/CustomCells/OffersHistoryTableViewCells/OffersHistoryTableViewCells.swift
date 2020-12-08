//
//  OffersHistoryTableViewCells.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class OffersHistoryTableViewCells: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerNameLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var savedMoneyLbl: UILabel!
    @IBOutlet weak var reOrderBtn: UIButton!
    @IBOutlet weak var offerPriceLbl: UILabel!
    @IBOutlet weak var originalPriceLbl: UILabel!
    
    var offer: OfferModel!
    
    var delegate: OffersHistoryProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        
        self.offer = offer
        
        self.offerImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.offersLink) ?? "" + "/" + (offer.imageLink ?? "")))
        self.offerNameLbl.text = offer.name
        self.storeNameLbl.text = offer.vendorName
        self.savedMoneyLbl.text = "\(offer.priceBeforeDiscount! - offer.priceAfterDiscount!)"
        self.offerPriceLbl.text = "\(offer.priceAfterDiscount!)"
        self.originalPriceLbl.text = "\(offer.priceBeforeDiscount!)"
    }
    
    
    
    @IBAction func reOrderBtnTapped(_ sender: Any) {
        self.delegate?.reorder(offer: self.offer)
    }
    
    @IBAction func rateBtnTapped(_ sender: Any) {
        self.delegate?.rate(offer: self.offer)
    }
    
}

protocol OffersHistoryProtocol {
    
    func reorder(offer: OfferModel)
    func rate(offer: OfferModel)
}
