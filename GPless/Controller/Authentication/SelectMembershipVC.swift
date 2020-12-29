//
//  SelectMembershipVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class SelectMembershipVC: UIViewController {
    
    @IBOutlet weak var memberShipTypeLbl: UILabel!
    @IBOutlet weak var selectMembershibLbl: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var freeBtn: DLRadioButton!
    @IBOutlet weak var premuimSexMonthsBtn: DLRadioButton!
    @IBOutlet weak var premiumOneYearBtn: DLRadioButton!
    
    @IBOutlet weak var freeLbl: UILabel!
    @IBOutlet weak var freeDescriptionLbl: UILabel!
    @IBOutlet weak var premiumLbl: UILabel!
    @IBOutlet weak var premiumDescriptionLbl: UILabel!
    @IBOutlet weak var premiumOneYearLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    var selectedMemberShipType: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)
        setUpNavigation()

        localize()
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = " "
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        
    }
    
    func localize() {
        
        memberShipTypeLbl.text = "membershipType" .localizableString()
        selectMembershibLbl.text = "pleaseChooseyourMembership".localizableString()
        
        freeLbl.text = "free".localizableString()
        freeDescriptionLbl.text = "free".localizableString()
        let sexMonthsFees = SharedSettings.shared.settings?.sixMonthsMembershipFees ?? ""
        premiumLbl.text = "premiumSixmonthes".localizableString() + sexMonthsFees
        premiumDescriptionLbl.text = "premiumSixmonthes".localizableString()
        
        let oneYearFees = SharedSettings.shared.settings?.oneYearMembershipFees ?? ""
        
        premiumOneYearLbl.text = "PremiumOneYear".localizableString() + oneYearFees
        doneBtn.setTitle("done".localizableString(), for: .normal)
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func freeBtnTapped(_ sender: Any) {
        
        self.freeBtn.isSelected = true
        self.freeBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.freeBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.premiumOneYearBtn.isSelected = false
        self.premuimSexMonthsBtn.isSelected = false
        
        self.premiumOneYearBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.premuimSexMonthsBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.premiumOneYearBtn.indicatorColor = hexStringToUIColor(hex: "#909090")
        self.premuimSexMonthsBtn.indicatorColor = hexStringToUIColor(hex: "#909090")
        
        self.selectedMemberShipType = "free"
    }
    
    @IBAction func premiumSexMonthsBtnTapped(_ sender: Any) {
        
        self.premuimSexMonthsBtn.isSelected = true
        
        self.premiumOneYearBtn.isSelected = false
        self.freeBtn.isSelected = false
        
        self.premiumOneYearBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.freeBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.premiumOneYearBtn.indicatorColor = hexStringToUIColor(hex: "#909090")
        self.freeBtn.indicatorColor = hexStringToUIColor(hex: "#909090")
        
        self.premuimSexMonthsBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.premuimSexMonthsBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.selectedMemberShipType = "6 Months"
    }
    
    @IBAction func premiumYearBtnTapped(_ sender: Any) {
        
        self.premiumOneYearBtn.isSelected = true
        
        self.premuimSexMonthsBtn.isSelected = false
        self.freeBtn.isSelected = false
        
        self.premuimSexMonthsBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.freeBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.premuimSexMonthsBtn.indicatorColor = hexStringToUIColor(hex: "#909090")
        self.freeBtn.indicatorColor = hexStringToUIColor(hex: "#909090")
        
        self.premiumOneYearBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.premiumOneYearBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.selectedMemberShipType = "12 months"
    }
    

    @IBAction func doneBtnTapped(_ sender: Any) {
        
        guard self.selectedMemberShipType != nil else {
            return
        }
        
        upgradeToPremium()
    }
}

extension SelectMembershipVC {
    
    func upgradeToPremium() {
        
        let prem = UpgradeToPremium(premuimType: self.selectedMemberShipType!)
        
        _ = Network.request(req: UpgradeToPremiumRequest(prem: prem), completionHandler: { (result) in
            
            switch result {
            case .success(let success):
                print(success)
                setUserType(userType: "1")
                self.navigationController?.popToRootViewController(animated: true)
                self.tabBarController?.selectedIndex = 0
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
                Toast.show(message: error?.localizedDescription ?? "error", controller: self)
            }
        })
    }
}
