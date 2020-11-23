//
//  ImageNotificationTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class ImageNotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notificationImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
