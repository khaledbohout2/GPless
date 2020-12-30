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
    @IBOutlet weak var countLbl: UILabel!
    
    
    var ids: [Int]!
    var vendorCode: String!
    var selectedBranch: Branch!
    var offer: OfferModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        localize()
        updateUI()
    }
    
    func updateUI() {
        
        self.offerTitleLbl.text = offer?.name
        self.storeNameLbl.text = offer?.vendorName
        self.newPriceLbl.text = "\(offer?.priceAfterDiscount)"
        self.oldPriceLbl.text = "\(offer?.priceBeforeDiscount)"
        self.branchName.text = offer?.vendorName
        
        let baseBrand = SharedSettings.shared.settings?.usersPhotoLink ?? ""
        let brandImage = offer?.vendorPhoto ?? ""
        
        self.brandImageView.sd_setImage(with: URL(string: baseBrand + "/" + brandImage))
        
    }
    
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        if getUserType() == "0" {
        
        confirmOffer()
            
        } else {
            
            userGetOffer()
        }

    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "getOffer".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
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
    
    
    @IBAction func minusBtnTapped(_ sender: Any) {
        
        if getUserType() == "0" {
            
        } else {
        
        var count = Int(self.countLbl.text!)!
        if count > 1 {
            count -= 1
            self.countLbl.text = "\(count)"
          }
       }
    }
    
    @IBAction func plusBtnTapped(_ sender: Any) {
        
        if getUserType() == "0" {
            
        } else {
        
        var count = Int(self.countLbl.text!)!
        
            count += 1
            self.countLbl.text = "\(count)"
        
       }
    }
}

extension CheckOutFromBranchVC {
    
    
    func confirmOffer() {
        
        print(self.ids!)
        print(self.vendorCode!)
        
        let confirmOffer = ConfirmOffer(ids: self.ids!, branchCode: "\(self.vendorCode!)")
//        var par = [String: Any]()
//        
//        
//        do {
//            let jsonData = try JSONEncoder().encode(confirmOffer)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonString)
//
//            let decodedConfirmOffer = try JSONDecoder().decode(ConfirmOffer.self, from: jsonData)
//
//            print(decodedConfirmOffer)
//            
//            let decoded = try! decodedConfirmOffer.asDictionary()
//            
//       //     print(decoded)
//            
//            par = decoded
//
//        } catch { print(error) }
        
        _ = Network.request(req: ConfirmOfferRequest(confirmOffer: confirmOffer) , completionHandler: { (result) in
            switch result {
            
            case .success(let response):
                
                if response.error == nil {
                    print(response)
                    let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                    let orderSuccesfullVC = storyBoard.instantiateViewController(identifier: "OrderSuccesfullVC")
                    self.navigationController?.pushViewController(orderSuccesfullVC, animated: true)
                    
                } else {
                    
                    print(response.error!)
                    
                    let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                    let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
                    self.navigationController?.pushViewController(paymentErrorVC, animated: true)
                }
            
            case .cancel(let cancelError):
                print(cancelError!)
                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
                self.navigationController?.pushViewController(paymentErrorVC, animated: true)
            case .failure(let error):
                print(error!)
                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
                self.navigationController?.pushViewController(paymentErrorVC, animated: true)
            }
        })
    }
    
    func userGetOffer() {
        
        let branchId = "\(self.selectedBranch!.id!)"
        
        print(branchId)
        
        print("\(self.offer!.id!)")
        
        _ = Network.request(req: UserGetOfferRequest(id: "\(self.offer!.id!)", count: Int(self.countLbl.text!)!, branchId: branchId), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                if response.state == "done" {
                    
                    self.ids = response.ids
                    self.confirmOffer()
                    
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
