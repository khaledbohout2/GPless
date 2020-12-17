//
//  UpgradeToPremiumVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class UpgradeToPremiumVC: UIViewController {
    
    @IBOutlet weak var upgradeToPremiumLbl: UILabel!
    @IBOutlet weak var getMoreOggersLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var payBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        localize()

        makeBottomCornerRadius(myView: headerView)
        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "Offer Details"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
        // search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    func localize() {
        
        upgradeToPremiumLbl.text = "upgradeToPremium".localizableString()
        upgradeToPremiumLbl.setLocalization()
        getMoreOggersLbl.text = "GetMoreOffers".localizableString()
        getMoreOggersLbl.setLocalization()
        payBtn.setTitle("pay".localizableString(), for: .normal)
        payBtn.setLocalization()

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    @IBAction func doneBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let upgradeToPremiumSuccess = storyBoard.instantiateViewController(identifier: "UpgradeToPremiumSuccess")
        self.navigationController?.pushViewController(upgradeToPremiumSuccess, animated: true)
    }
    
}
