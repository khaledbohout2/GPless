//
//  RankTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var userPointsLbl: UILabel!
    
    @IBOutlet weak var userRankLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
