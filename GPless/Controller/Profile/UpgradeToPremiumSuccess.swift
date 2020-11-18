//
//  UpgradeToPremiumSuccess.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class UpgradeToPremiumSuccess: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let membershipTypeVC = storyBoard.instantiateViewController(identifier: "MembershipTypeVC")
        self.navigationController?.pushViewController(membershipTypeVC, animated: true)
    }
    


}
