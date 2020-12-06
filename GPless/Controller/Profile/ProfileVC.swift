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
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var pontsCountLbl: UILabel!
    
    @IBOutlet weak var rankNumLbl: UILabel!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    var userInfo: Profile?
    var userImageLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if getUserData() == true {
            
            makeBottomCornerRadius(myView: headerView)
            profileTableView.delegate = self
            profileTableView.dataSource = self
            self.title = "My Acount"
            getUserInfo()
            
        } else {
        
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let pleaseLoginVC =  storyboard.instantiateViewController(identifier: "PleaseLoginVC") as! PleaseLoginVC
            pleaseLoginVC.fromProfile = true
            self.navigationController?.pushViewController(pleaseLoginVC, animated: true)
        }
        

    }
    
    func updateUI() {
        
        self.profileImageView.image = UIImage(systemName: "person.fill")
        self.pontsCountLbl.text = "\(userInfo!.points!)"
        self.rankNumLbl.text = "\(userInfo!.rank!)"
        self.userNameLbl.text = self.userInfo!.accountName
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           // my paid offers
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let moneySavedVC = storyBoard.instantiateViewController(identifier: "MoneySavedVC")
            self.navigationController?.pushViewController(moneySavedVC, animated: true)
        } else if indexPath.row == 1 {
            // top rated
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let rankVC = storyBoard.instantiateViewController(identifier: "RankVC") as! RankVC
            self.navigationController?.pushViewController(rankVC, animated: true)
            
        } else if indexPath.row == 2 {
            //Money Saved
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let moneySavedVC = storyBoard.instantiateViewController(identifier: "MoneySavedVC")
            self.navigationController?.pushViewController(moneySavedVC, animated: true)
            
        } else if indexPath.row == 3 {
            //Favorite Offers
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let favouriteVC = storyBoard.instantiateViewController(identifier: "FavouriteVC")
            self.navigationController?.pushViewController(favouriteVC, animated: true)
            
        } else if indexPath.row == 4 {
            //Help
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let contactUsVC = storyBoard.instantiateViewController(identifier: "ContactUsVC")
            self.navigationController?.pushViewController(contactUsVC, animated: true)
            
        } else if indexPath.row == 5 {
            //Settings
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let settingVC = storyBoard.instantiateViewController(identifier: "SettingVC")
            self.navigationController?.pushViewController(settingVC, animated: true)
            
        } else if indexPath.row == 6 {
            //Logout
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let signOutVC =  storyboard.instantiateViewController(identifier: "SignOutVC")
            self.addChild(signOutVC)
            signOutVC.view.frame = self.view.frame
            self.view.addSubview((signOutVC.view)!)
            signOutVC.didMove(toParent: self)
        }
    }
    
    
    
    @IBAction func editProfileBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let editProfileVC = storyBoard.instantiateViewController(identifier: "EditProfileVC")
        self.navigationController?.pushViewController(editProfileVC, animated: true)
        
    }
    
}

extension ProfileVC {
    
    func getUserInfo() {
        
        _ = Network.request(req: GetUserDetailsRequest(), completionHandler: { (result) in
            switch result {
            case .success(let userInfo):
                print(userInfo)
                self.userInfo = userInfo
                self.updateUI()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
    func getSettings() {
        
        _ = Network.request(req: SettingsRequet(index: "1"), completionHandler: { (result) in
            switch result {
            case .success(let settings):
                print(settings)
                self.userImageLink = settings.usersPhotoLink
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }

}
