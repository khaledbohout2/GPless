//
//  EnterNewPasswordVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class EnterNewPasswordVC: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var confirmPassTXF: UITextField!
    @IBOutlet weak var confirmNewPassLbl: UILabel!
    @IBOutlet weak var enterNewPassLbl: UILabel!
    @IBOutlet weak var newPassTXF: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)
        setUpNavigation()
        localize()

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
    
    func localize() {
        
        doneBtn.setTitle("done", for: .normal)
        doneBtn.setLocalization()
        confirmPassTXF.placeholder = "password".localizableString()
        // confirmPassTXF.setLocalization()
        confirmNewPassLbl.text = "confirmNewPassword".localizableString()
        confirmNewPassLbl.setLocalization()
        enterNewPassLbl.text = "enterNewPassword".localizableString()
        enterNewPassLbl.setLocalization()
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
