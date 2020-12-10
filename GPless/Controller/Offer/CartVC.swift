//
//  CartVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var itemDataView: UIView!
    @IBOutlet weak var footerView: UIView!
    //Item Data View
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var itemBrandLbl: UILabel!
    @IBOutlet weak var offerPriceLbl: UILabel!
    @IBOutlet weak var NewPriceLbl: UILabel!
    @IBOutlet weak var getOfferBtn: UIButton!
    
    var offer : OfferModel!
    var count = 1
    var selectedBranch: Branch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)
        makeTopCornerRadius(myView: footerView)
        setUpNavigation()
        updateUI()
       // installOpacity()

    }
    
    func installOpacity() {
        
        itemDataView.layer.shadowColor = hexStringToUIColor(hex: "#00000033").cgColor
        itemDataView.layer.shadowOpacity = 1
        itemDataView.layer.shadowOffset = CGSize(width: 0, height: 2)
        itemDataView.layer.shadowRadius = 4
        
        itemImageView.layer.shadowColor = hexStringToUIColor(hex: "#00000033").cgColor
        itemImageView.layer.shadowOpacity = 1
        itemImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        itemImageView.layer.shadowRadius = 4
    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "Check Out Offer"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
     //   search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        
        
    }
    
    func updateUI() {
        
        self.itemImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.offersLink) ?? "" + "/" + (offer.imageLink ?? "")))
        self.itemTitleLbl.text = offer.name
        self.itemBrandLbl.text = offer.vendorName
        self.offerPriceLbl.text = "\(offer.priceAfterDiscount!)"
        self.NewPriceLbl.text = "\(offer.priceBeforeDiscount!)"
        self.getOfferBtn.setTitle(offer.offerDetailsDescription, for: .normal)
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func minusBtnTapped(_ sender: Any) {
        
        var count = Int(countLbl.text!)!
        if count > 1 {
            count -= 1
            self.countLbl.text = String(count)
            self.count = count
        }
    }
    
    @IBAction func plusBtnTapped(_ sender: Any) {
        
        var count = Int(countLbl.text!)!
        
            count += 1
            self.countLbl.text = String(count)
        self.count = count
        
        
    }
    
    @IBAction func payOfferBtnTapped(_ sender: Any) {
        
        if Reachable.isConnectedToNetwork() {
        
        userGetOffer()
            
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }
        
    }
    
}

extension CartVC {
    
    func userGetOffer() {
        
        let branchId = "\(self.selectedBranch!.id!)"
        
        _ = Network.request(req: UserGetOfferRequest(id: "\(self.offer!.id!)", count: self.count, branchId: branchId), completionHandler: { (result) in
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
