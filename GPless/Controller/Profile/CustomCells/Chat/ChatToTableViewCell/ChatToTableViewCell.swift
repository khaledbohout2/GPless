//
//  ChatToTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class ChatToTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
