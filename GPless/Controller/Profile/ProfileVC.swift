//
//  ProfileVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class ProfileVC: UITableViewController {
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)

        profileTableView.delegate = self
        profileTableView.dataSource = self
        self.title = "My Acount"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let editProfileVC = storyBoard.instantiateViewController(identifier: "EditProfileVC")
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    


}
