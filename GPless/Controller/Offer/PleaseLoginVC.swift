//
//  PleaseLogin.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class PleaseLoginVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: mainView)
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)


        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC =  storyboard.instantiateViewController(identifier: "SignInVC")
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signUpVC =  storyboard.instantiateViewController(identifier: "SignUpVC")
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    



}
