//
//  PleaseLogin.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class PleaseLoginVC: UIViewController {
    
    var fromProfile = false
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var signUpLbl: UIButton!
    @IBOutlet weak var signInLbl: UIButton!
    @IBOutlet weak var youMustLoginLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        makeTopCornerRadius(myView: mainView)
        
        if !fromProfile {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        signUpLbl.setTitle("signup".localizableString(), for: .normal)
        signInLbl.setTitle("Sign in".localizableString(), for: .normal)
        youMustLoginLbl.text = "youmustLogin".localizableString()
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC =  storyboard.instantiateViewController(identifier: "SignInVC")
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signUpMobile =  storyboard.instantiateViewController(identifier: "SignUpMobile")
        self.navigationController?.pushViewController(signUpMobile, animated: true)
    }
    
    



}
