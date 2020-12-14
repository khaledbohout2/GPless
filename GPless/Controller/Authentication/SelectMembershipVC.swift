//
//  SelectMembershipVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class SelectMembershipVC: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var freeBtn: DLRadioButton!
    @IBOutlet weak var premuimSexMonthsBtn: DLRadioButton!
    @IBOutlet weak var premiumOneYearBtn: DLRadioButton!
    
    var selectedMemberShipType: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = " "
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        
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
        
        self.selectedMemberShipType = "premium"
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
        
        self.selectedMemberShipType = "premium"
    }
    

    @IBAction func doneBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(identifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    

}
