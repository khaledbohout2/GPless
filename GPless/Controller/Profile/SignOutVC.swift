//
//  SignOutVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/29/20.
//

import UIKit

class SignOutVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        
        logout()
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(identifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    

    @IBAction func noBtnTapped(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}