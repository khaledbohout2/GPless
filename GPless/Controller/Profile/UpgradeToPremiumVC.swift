//
//  UpgradeToPremiumVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class UpgradeToPremiumVC: UIViewController {
    
    @IBOutlet weak var upgradeToPremiumLbl: UILabel!
    @IBOutlet weak var getMoreOggersLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var premuimSexMonthsBtn: DLRadioButton!
    @IBOutlet weak var premiumOneYearBtn: DLRadioButton!
    
    var selectedMemberShipType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        localize()

        makeBottomCornerRadius(myView: headerView)
        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "upgradeToPremium".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
        // search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    func localize() {
        
        upgradeToPremiumLbl.text = "upgradeToPremium".localizableString()
        upgradeToPremiumLbl.setLocalization()
        getMoreOggersLbl.text = "GetMoreOffers".localizableString()
        getMoreOggersLbl.setLocalization()
        payBtn.setTitle("pay".localizableString(), for: .normal)
        payBtn.setLocalization()

        
    }
    
    //MARK: - IBActions
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func premiumSixMonthsBtnTapped(_ sender: Any) {
        
        self.premiumOneYearBtn.isSelected = false
        
        self.premuimSexMonthsBtn.isSelected = true
        
        self.premiumOneYearBtn.iconColor = hexStringToUIColor(hex: "#909090")

        self.premiumOneYearBtn.indicatorColor = hexStringToUIColor(hex: "#909090")

        
        self.premuimSexMonthsBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.premuimSexMonthsBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.selectedMemberShipType = "12 months"
    }
    
    @IBAction func premiumOneYearBtnTapped(_ sender: Any) {
        
        self.premiumOneYearBtn.isSelected = true
        
        self.premuimSexMonthsBtn.isSelected = false
        
        self.premuimSexMonthsBtn.iconColor = hexStringToUIColor(hex: "#909090")

        self.premuimSexMonthsBtn.indicatorColor = hexStringToUIColor(hex: "#909090")

        self.premiumOneYearBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.premiumOneYearBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.selectedMemberShipType = "6 Months"
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        guard self.selectedMemberShipType != nil else {
            
            Toast.show(message: "Please select membership type", controller: self)
            return
        }
        
        upgradeToPremium()
        
    }
    
}

extension UpgradeToPremiumVC {
    
    func upgradeToPremium() {
        
        let prem = UpgradeToPremium(premuimType: self.selectedMemberShipType!)
        
        _ = Network.request(req: UpgradeToPremiumRequest(prem: prem), completionHandler: { (result) in
            
            switch result {
            case .success(let success):
                print(success)
                if success.state != nil {
                    setUserType(userType: "1")
                let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
                let upgradeToPremiumSuccess = storyBoard.instantiateViewController(identifier: "UpgradeToPremiumSuccess")
                self.navigationController?.pushViewController(upgradeToPremiumSuccess, animated: true)
                } else {
                    Toast.show(message: success.error!, controller: self)
                }

            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
                Toast.show(message: error?.localizedDescription ?? "error", controller: self)
            }
        })
    }
}


