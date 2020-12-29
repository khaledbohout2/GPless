//
//  SettingVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class SettingVC: UITableViewController {
    
    @IBOutlet weak var termsAndConditionsLbl: UILabel!
    @IBOutlet weak var FAQsLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var privacyPolicyLbl: UILabel!
    @IBOutlet weak var gotoPageBtn: UIButton!
    @IBOutlet weak var gotosecondBtn: UIButton!
    @IBOutlet weak var gotoThirdBtn: UIButton!
    @IBOutlet weak var gotoForthBtn: UIButton!
    
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        localize()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "settings".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        
        let search = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchTapped))
        search.image = UIImage(named: "navigationSearch")
        search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.rightBarButtonItem = search
        
    }
    
    func localize() {
        
        termsAndConditionsLbl.text = "termsAndConditiond".localizableString()
        termsAndConditionsLbl.setLocalization()
        
        FAQsLbl.text = "FAQs".localizableString()
        FAQsLbl.setLocalization()
        
        languageLbl.text = "Language".localizableString()
        languageLbl.setLocalization()
        
        privacyPolicyLbl.text = "privacyPolicy".localizableString()
        privacyPolicyLbl.setLocalization()
        
        gotoPageBtn.setTitle(">".localizableString(), for: .normal)
        gotosecondBtn.setTitle(">".localizableString(), for: .normal)
        gotoThirdBtn.setTitle(">".localizableString(), for: .normal)
        gotoForthBtn.setTitle(">".localizableString(), for: .normal)
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchTapped() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeSearchVC =  storyboard.instantiateViewController(identifier: "HomeSearchVC") as? HomeSearchVC
        self.addChild(homeSearchVC!)
        homeSearchVC?.view.frame = self.view.frame
        self.view.addSubview((homeSearchVC?.view)!)
        homeSearchVC?.didMove(toParent: self)
        
    }
    


}

extension SettingVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            //terms and conditions
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let termsAndConditionsVC = storyBoard.instantiateViewController(identifier: "TermsAndConditionsVC") as! TermsAndConditionsVC
            self.navigationController?.pushViewController(termsAndConditionsVC, animated: true)
            
        } else if indexPath.row == 1 {
            
            //FAQs
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let fAQVC = storyBoard.instantiateViewController(identifier: "FAQVC")
            self.navigationController?.pushViewController(fAQVC, animated: true)
            
        } else if indexPath.row == 2 {
            
            //language
            
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let chooseLanguageVC =  storyboard.instantiateViewController(identifier: "ChooseLanguageVC")
            self.addChild(chooseLanguageVC)
            chooseLanguageVC.view.frame = self.view.frame
            self.view.addSubview((chooseLanguageVC.view)!)
            chooseLanguageVC.didMove(toParent: self)
            
        } else if indexPath.row == 3 {
            
            //Privacy Policy
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let privacyPolicyVC = storyBoard.instantiateViewController(identifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            self.navigationController?.pushViewController(privacyPolicyVC, animated: true)
            
        }
    }
}

