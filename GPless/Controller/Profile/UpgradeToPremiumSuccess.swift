//
//  UpgradeToPremiumSuccess.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class UpgradeToPremiumSuccess: UIViewController {
    
    @IBOutlet weak var congratulationsLbl: UILabel!
    
    @IBOutlet weak var youArePremiumLbl: UILabel!
    
    @IBOutlet weak var doneLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let membershipTypeVC = storyBoard.instantiateViewController(identifier: "MembershipTypeVC")
        self.navigationController?.pushViewController(membershipTypeVC, animated: true)
    }
    
    func localize() {
        
        congratulationsLbl.text = "congratulations".localizableString()
        congratulationsLbl.setLocalization()
        youArePremiumLbl.text = "YouarenowPremium".localizableString()
        youArePremiumLbl.setLocalization()
        doneLbl.setTitle("done".localizableString(), for: .normal)
        doneLbl.setLocalization()

    }
    


}
