//
//  SignUpVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerImageView)
        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        //SelectMembershipVC
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let selectMembershipVC = storyBoard.instantiateViewController(identifier: "SelectMembershipVC")
        self.navigationController?.pushViewController(selectMembershipVC, animated: true)
        
        
    }
    



}
