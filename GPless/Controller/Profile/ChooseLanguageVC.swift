//
//  ChooseLanguageVC.swift
//  GPless
//
//  Created by Khaled Bohout on 12/1/20.
//

import UIKit
import MOLH

class ChooseLanguageVC: UIViewController {
    
    @IBOutlet weak var englishBtnTapped: DLRadioButton!
    @IBOutlet weak var arabicBtn: DLRadioButton!
    @IBOutlet weak var englishLbl: UILabel!
    @IBOutlet weak var arabicLbl: UILabel!
    
    var selectedLanguage: String?
    let languagePrefix = Locale.preferredLanguages[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCurrentLanguage()
    }
    
    
    func setCurrentLanguage() {
        
        if languagePrefix == "en" {
            
            englishLbl.textColor = hexStringToUIColor(hex: "#000000")
            arabicLbl.textColor = hexStringToUIColor(hex: "#939393")
            
            self.englishBtnTapped.isSelected = true
            self.englishBtnTapped.iconColor = hexStringToUIColor(hex: "#FBE159")
            self.englishBtnTapped.indicatorColor = hexStringToUIColor(hex: "#FBE159")
            
            self.arabicBtn.isSelected = false
            
            self.arabicBtn.iconColor = hexStringToUIColor(hex: "#909090")
            self.arabicBtn.indicatorColor = hexStringToUIColor(hex: "#909090")

            self.selectedLanguage = "en"
            
        } else {
            
            arabicLbl.textColor = hexStringToUIColor(hex: "#000000")
            englishLbl.textColor = hexStringToUIColor(hex: "#939393")
            
            self.arabicBtn.isSelected = true
            self.arabicBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
            self.arabicBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
            
            self.englishBtnTapped.isSelected = false
            
            self.englishBtnTapped.iconColor = hexStringToUIColor(hex: "#909090")
            self.englishBtnTapped.indicatorColor = hexStringToUIColor(hex: "#909090")

            self.selectedLanguage = "ar"
        }
    }
    
    @IBAction func engilshBtnTapped(_ sender: Any) {
        
        englishLbl.textColor = hexStringToUIColor(hex: "#000000")
        arabicLbl.textColor = hexStringToUIColor(hex: "#939393")
        
        self.englishBtnTapped.isSelected = true
        self.englishBtnTapped.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.englishBtnTapped.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.arabicBtn.isSelected = false
        
        self.arabicBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.arabicBtn.indicatorColor = hexStringToUIColor(hex: "#909090")

        self.selectedLanguage = "en"
    }
    
    @IBAction func arabicBtnTapped(_ sender: Any) {
        
        arabicLbl.textColor = hexStringToUIColor(hex: "#000000")
        englishLbl.textColor = hexStringToUIColor(hex: "#939393")
        
        self.arabicBtn.isSelected = true
        self.arabicBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.arabicBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.englishBtnTapped.isSelected = false
        
        self.englishBtnTapped.iconColor = hexStringToUIColor(hex: "#909090")
        self.englishBtnTapped.indicatorColor = hexStringToUIColor(hex: "#909090")

        self.selectedLanguage = "ar"
    }
    

    @IBAction func updateBtnTapped(_ sender: Any) {
        
        guard self.selectedLanguage != nil else {
            Toast.show(message: "Please select language".localizableString(), controller: self)
            return
        }
        
        if selectedLanguage != languagePrefix {
        
        MOLH.setLanguageTo(self.selectedLanguage!)
        restartApp()
        self.tabBarController?.tabBar.isHidden = false
            
        } else {
            
            self.view.removeFromSuperview()
        }
    }
    
}
