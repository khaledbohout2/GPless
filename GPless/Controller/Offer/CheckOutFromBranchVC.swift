//
//  CheckOutFromBranch.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class CheckOutFromBranchVC: UIViewController {
    
    @IBOutlet weak var offerTitleLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var newPriceLbl: UILabel!
    @IBOutlet weak var oldPriceLbl: UILabel!
    @IBOutlet weak var branchSelectedLbl: UILabel!
    @IBOutlet weak var selectBranchLbl: UILabel!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var continueLbl: UIButton!
    
    var ids: [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()

        localize()
    }
    
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let enterBranchIDVC = storyBoard.instantiateViewController(identifier: "EnterBranchIDVC") as! EnterBranchIDVC
            enterBranchIDVC.ids = self.ids
        self.navigationController?.pushViewController(enterBranchIDVC, animated: true)

    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "Get Offer"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
    // search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        
    }
    
    func localize() {
        
        self.branchSelectedLbl.text = "branchselected".localizableString()
        branchSelectedLbl.setLocalization()
        self.selectBranchLbl.text = "selectBranch".localizableString()
        selectBranchLbl.setLocalization()
        self.continueLbl.setTitle("Continue".localizableString(), for: .normal)
        continueLbl.setLocalization()
    }
    
    @objc func backTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }
}
