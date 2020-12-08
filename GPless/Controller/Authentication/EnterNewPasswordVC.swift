//
//  EnterNewPasswordVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class EnterNewPasswordVC: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "ForgotPassword"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
       // search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    @IBAction func doneBtnTapped(_ sender: Any) {
        
     //   SignUpMobile
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signUpMobile = storyBoard.instantiateViewController(identifier: "SignUpMobile")
        self.navigationController?.pushViewController(signUpMobile, animated: true)
        
    }
    
}
