//
//  OrderSuccesfullVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit

class OrderSuccesfullVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: mainView)


    }
    
    
    @IBAction func tryAgianBtnTapped(_ sender: Any) {
        
        //SignInVC
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(identifier: "SignInVC")
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    



}
