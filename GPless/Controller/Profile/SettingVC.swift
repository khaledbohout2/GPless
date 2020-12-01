//
//  SettingVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class SettingVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "Settings"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        
        let search = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchTapped))
        search.image = UIImage(named: "navigationSearch")
        search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.rightBarButtonItem = search
        
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
            let termsAndConditionsVC = storyBoard.instantiateViewController(identifier: "TermsAndConditionsVC")
            self.navigationController?.pushViewController(termsAndConditionsVC, animated: true)
            
        } else if indexPath.row == 1 {
            
            //FAQs
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let fAQVC = storyBoard.instantiateViewController(identifier: "FAQVC")
            self.navigationController?.pushViewController(fAQVC, animated: true)
            
        } else if indexPath.row == 2 {
            
            //language
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let chooseLanguageVC = storyBoard.instantiateViewController(identifier: "ChooseLanguageVC")
            self.navigationController?.pushViewController(chooseLanguageVC, animated: true)
            
        } else if indexPath.row == 3 {
            
            //Privacy Policy
            let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
            let privacyPolicyVC = storyBoard.instantiateViewController(identifier: "PrivacyPolicyVC")
            self.navigationController?.pushViewController(privacyPolicyVC, animated: true)
            
        }

    }
}
