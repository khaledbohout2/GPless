//
//  GoToBranchVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class GoToBranchVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var toGetOfferLbl: UILabel!
    @IBOutlet weak var gotoBranchBtn: UIButton!
    @IBOutlet weak var continueToGetOffer: UIButton!
    
    var selectedBranch: Branch!
    var offer: OfferModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        makeTopCornerRadius(myView: mainView)

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        toGetOfferLbl.text = "youmustbeintheBranch".localizableString()
        toGetOfferLbl.setLocalization()
        gotoBranchBtn.setTitle("gotoBranch".localizableString(), for: .normal)
        gotoBranchBtn.setLocalization()
        continueToGetOffer.setTitle("continuetoGetOffer".lowercased(), for: .normal)
        continueToGetOffer.setLocalization()

    }
    
    
    @IBAction func gotoBranchBtnTapped(_ sender: Any) {
        
        let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(selectedBranch.latitude!),\(selectedBranch.longitude!)")
        UIApplication.shared.open(url!)
        
    }
    
    
    @IBAction func getOfferBtnTapped(_ sender: Any) {
        
                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                let cartVC = storyBoard.instantiateViewController(identifier: "CartVC") as! CartVC
                    cartVC.offer = self.offer
                    cartVC.selectedBranch = selectedBranch
                self.navigationController?.pushViewController(cartVC, animated: true)
    }
    

}
