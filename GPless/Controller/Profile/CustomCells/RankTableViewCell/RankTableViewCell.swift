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
        
        let userBaseLink = SharedSettings.shared.settings?.usersPhotoLink ?? ""
        let imageLink = user.photoLink ?? ""
        
        self.userAvatarImageView.sd_setImage(with: URL(string: userBaseLink + "/" + imageLink))
        self.userNameLbl.text = user.accountName
        self.userNameLbl.setLocalization()
        self.userPointsLbl.text = "\(user.value!)"
        self.userPointsLbl.setLocalization()
        self.userRankLbl.text = "\(user.rank!)"
        self.userRankLbl.setLocalization()
    }
    
}
