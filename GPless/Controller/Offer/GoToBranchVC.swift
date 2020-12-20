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
    @IBOutlet weak var deliveryBtn: UIButton!
    
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
        continueToGetOffer.setTitle("continuetoGetOffer".localizableString(), for: .normal)
        continueToGetOffer.setLocalization()

    }
    
    
    @IBAction func gotoBranchBtnTapped(_ sender: Any) {
        
        let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(selectedBranch.latitude!),\(selectedBranch.longitude!)")
        UIApplication.shared.open(url!)
        
    }
    
    
    @IBAction func getOfferBtnTapped(_ sender: Any) {
        
        if getUserType() == "0" {
        
                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                let cartVC = storyBoard.instantiateViewController(identifier: "CartVC") as! CartVC
                    cartVC.offer = self.offer
                    cartVC.selectedBranch = selectedBranch
                self.navigationController?.pushViewController(cartVC, animated: true)
            
        } else {
            
            userGetOffer()
            
            
        }
    }
    
    
    @IBAction func deleveryBtnTapped(_ sender: Any) {
        
        dialNumber(number : selectedBranch.phone!)
    }
    

}

extension GoToBranchVC {
    
    func userGetOffer() {
        
        let branchId = "\(self.selectedBranch!.id!)"
        
        _ = Network.request(req: UserGetOfferRequest(id: "\(self.offer!.id!)", count: 1, branchId: branchId), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                if response.state == "done" {
                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                let checkOutFromBranchVC = storyBoard.instantiateViewController(identifier: "CheckOutFromBranchVC") as! CheckOutFromBranchVC
                    checkOutFromBranchVC.ids = response.ids
                self.navigationController?.pushViewController(checkOutFromBranchVC, animated: true)
                } else {
                    Toast.show(message: response.message!, controller: self)
                }
            case .cancel(let cancelError):
                print(cancelError!)
                Toast.show(message: cancelError.debugDescription, controller: self)
            case .failure(let error):
                print(error!)
                Toast.show(message: error.debugDescription, controller: self)
            }
        })
    }

}
