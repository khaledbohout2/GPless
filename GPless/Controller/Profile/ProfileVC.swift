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
    
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var upgradeToPremiumLbl: UILabel!
    
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var upgradeToPremiumView: UIView!
    
    @IBOutlet weak var myPaidOffersLbl: UILabel!
    @IBOutlet weak var gotoPaidBtn: UIButton!
    @IBOutlet weak var topRatedLbl: UILabel!
    @IBOutlet weak var topRatedBtn: UIButton!
    @IBOutlet weak var moneySavedLbl: UILabel!
    @IBOutlet weak var moneySavedBtn: UIButton!
    @IBOutlet weak var favouriteOffersBtn: UILabel!
    @IBOutlet weak var fouvouriteBtn: UIButton!
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var settingsLbl: UILabel!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var logOutLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    var mySubview = UIView()
    var indicator = UIActivityIndicatorView()
    
    var userInfo: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        addGestures()
        
        if getUserData() == true {

            makeBottomCornerRadius(myView: headerView)
            profileTableView.delegate = self
            profileTableView.dataSource = self
            self.title = "My Acount"
            
            if Reachable.isConnectedToNetwork() {
                
            getUserInfo()
                
            } else {
                
                Toast.show(message: "No Internet", controller: self)
                indicator.stopAnimating()
            }
            
        } else {
        
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let pleaseLoginVC =  storyboard.instantiateViewController(identifier: "PleaseLoginVC") as! PleaseLoginVC
            pleaseLoginVC.fromProfile = true
            self.navigationController?.pushViewController(pleaseLoginVC, animated: true)
        }
    }
    
    func localize() {

        pointsLbl.text = "Points".localizableString()
        pointsLbl.setLocalization()
        
        rankLbl.text = "Rank".localizableString()
        rankLbl.setLocalization()
        
        upgradeToPremiumLbl.text = "upgradetoPremium".localizableString()
        upgradeToPremiumLbl.setLocalization()

        myPaidOffersLbl.text = "myPaidOffers".localizableString()
        myPaidOffersLbl.setLocalization()
        
        topRatedLbl.text = "topRated".localizableString()
        topRatedLbl.setLocalization()
        
        moneySavedLbl.text = "moneySaved".localizableString()
        moneySavedLbl.setLocalization()
        
        favouriteOffersBtn.text = "favoriteOffers".localizableString()
        favouriteOffersBtn.setLocalization()
        
        helpLbl.text = "help".localizableString()
        helpLbl.setLocalization()
        
        settingsLbl.text = "Settings".localizableString()
        settingsLbl.setLocalization()
        
        logOutLbl.text = "Logout".localizableString()
        logOutLbl.setLocalization()
        
        gotoPaidBtn.setTitle(">".localizableString(), for: .normal)
        topRatedBtn.setTitle(">".localizableString(), for: .normal)
        moneySavedBtn.setTitle(">".localizableString(), for: .normal)
        fouvouriteBtn.setTitle(">".localizableString(), for: .normal)
        helpBtn.setTitle(">".localizableString(), for: .normal)
        settingsBtn.setTitle(">".localizableString(), for: .normal)
        logoutBtn.setTitle(">".localizableString(), for: .normal)
    }
    
    func addGestures() {
        
        let pointsGesture = UITapGestureRecognizer(target: self, action: #selector(self.pointsTapped))
        let rankGesture = UITapGestureRecognizer(target: self, action: #selector(self.rankTapped))
        
        self.pointsView.addGestureRecognizer(pointsGesture)
        self.rankView.addGestureRecognizer(rankGesture)
    }
    
    func updateUI() {
        
        self.userNameLbl.text = userInfo?.accountName
        self.profileImageView.image = UIImage(systemName: "person.fill")
        self.pontsCountLbl.text = "\(userInfo!.points!)"
        self.rankNumLbl.text = "\(userInfo!.rank!)"
        self.userNameLbl.text = self.userInfo!.accountName
        
    }
    
    @objc func pointsTapped () {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let pointsVC = storyBoard.instantiateViewController(identifier: "PointsVC")
        self.navigationController?.pushViewController(pointsVC, animated: true)
    }
    @objc func rankTapped () {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let rankVC = storyBoard.instantiateViewController(identifier: "RankVC")
        self.navigationController?.pushViewController(rankVC, animated: true)
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
                self.indicator.stopAnimating()
                self.mySubview.isHidden = true
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                self.indicator.stopAnimating()
                print(error!)
            }
        })
    }
}
