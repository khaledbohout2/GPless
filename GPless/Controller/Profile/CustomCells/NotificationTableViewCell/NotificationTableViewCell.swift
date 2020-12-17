//
//  NotificationTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationTitleLbl: UILabel!
    @IBOutlet weak var notificationContentLbl: UILabel!
    @IBOutlet weak var notificationDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(notification: Notification) {
        
        self.notificationTitleLbl.text = notification.title
        self.notificationDateLbl.setLocalization()
        
        self.notificationContentLbl.text = notification.notificationDescription
        self.notificationContentLbl.setLocalization()
        
        self.notificationDateLbl.text = notification.updatedAt
        self.notificationDateLbl.setLocalization()
    }
    
}
