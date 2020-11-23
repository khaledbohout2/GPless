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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
