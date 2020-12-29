//
//  SignOutVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/29/20.
//

import UIKit

class SignOutVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var signOutLbl: UILabel!
    @IBOutlet weak var areYouSureLbl: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        
        localize()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func localize() {
        
        signOutLbl.text = "signOut".localizableString()
        signOutLbl.setLocalization()
        areYouSureLbl.text = "areYouSureLbl".localizableString()
        areYouSureLbl.setLocalization()
        yesBtn.setTitle("yes".localizableString(), for: .normal)
        yesBtn.setLocalization()
        noBtn.setTitle("no".localizableString(), for: .normal)
        noBtn.setLocalization()
    }
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        
        logout()
        self.view.removeFromSuperview()
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.selectedIndex = 0

    }
    

    @IBAction func noBtnTapped(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}
