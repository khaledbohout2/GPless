//
//  GoToBranchVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class GoToBranchVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    var selectedBranch: Branch!
    var offer: OfferModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        makeTopCornerRadius(myView: mainView)

        // Do any additional setup after loading the view.
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
