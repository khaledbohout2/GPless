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

    func configureCell(user: UserRank) {
        
      //  self.userAvatarImageView.image = user.photoLink
        self.userNameLbl.text = user.accountName
        self.userPointsLbl.text = "\(user.value!)"
        self.userRankLbl.text = "\(user.rank!)"
    }
    
}
