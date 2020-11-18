//
//  EditProfileVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class EditProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "Edit Profile"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

    

    @IBAction func saveBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let upgradeToPremiumVC = storyBoard.instantiateViewController(identifier: "UpgradeToPremiumVC")
        self.navigationController?.pushViewController(upgradeToPremiumVC, animated: true)
    }
    

}