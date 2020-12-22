//
//  MembershipTypeVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class MembershipTypeVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var planeLbl: UILabel!
    @IBOutlet weak var planeDetailsLbl: UILabel!
    @IBOutlet weak var showOtherPlansBtn: UIButton!
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    var endPremium: String!
    var plane: String!
    var userImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeBottomCornerRadius(myView: headerView)
        setUpNavigation()
        localize()
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "MemberShipType".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
    }
    
    func localize() {
        
        showOtherPlansBtn.setTitle("showOtherPlans".localizableString(), for: .normal)
        
        showOtherPlansBtn.setLocalization()
        
        self.planeLbl.text = plane
        self.dateLbl.text = endPremium
        
        if let userImage = userImage  {

            let baseUserImage = SharedSettings.shared.settings?.usersPhotoLink ?? ""
            let userImage = userImage

            self.userAvatar.sd_setImage(with: URL(string: baseUserImage + "/" + userImage))

        } else {

            self.userAvatar.image = UIImage(systemName: "person.fill")
        }
    }
    
    @objc func backTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showOtherPlansBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let upgradeToPremiumVC = storyBoard.instantiateViewController(identifier: "UpgradeToPremiumVC")
        self.navigationController?.pushViewController(upgradeToPremiumVC, animated: true)
    }
    

}
