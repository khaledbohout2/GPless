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

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func localize() {
        
        signOutLbl.text = "signOut".localizableString()
        areYouSureLbl.text = "areYouSureLbl".localizableString()
        yesBtn.setTitle("yes".localizableString(), for: .normal)
        noBtn.setTitle("no".localizableString(), for: .normal)
        
    }
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        
        logout()
        self.view.removeFromSuperview()
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.selectedIndex = 0

    }
    

    @IBAction func noBtnTapped(_ sender: Any) {
        
    }
}
