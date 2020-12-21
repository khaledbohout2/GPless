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
    
    var selectedLanguage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func engilshBtnTapped(_ sender: Any) {
        
        self.englishBtnTapped.isSelected = true
        self.englishBtnTapped.iconColor = hexStringToUIColor(hex: "#FBE159")
        self.englishBtnTapped.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        self.arabicBtn.isSelected = false
        
        self.arabicBtn.iconColor = hexStringToUIColor(hex: "#909090")
        self.arabicBtn.indicatorColor = hexStringToUIColor(hex: "#909090")

        self.selectedLanguage = "en"
    }
    
    @IBAction func arabicBtnTapped(_ sender: Any) {
        
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
            Toast.show(message: "Please select language", controller: self)
            return
        }
        MOLH.setLanguageTo(self.selectedLanguage!)
        restartApp()
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
