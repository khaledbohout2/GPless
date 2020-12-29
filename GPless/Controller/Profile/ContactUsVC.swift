//
//  ContactUsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class ContactUsVC: UIViewController {

    @IBOutlet weak var callUsView: UIView!
    @IBOutlet weak var emailUsView: UIView!
    @IBOutlet weak var liveSupportView: UIView!
    @IBOutlet weak var callUsLbl: UILabel!
    @IBOutlet weak var callUsDetailsLbl: UILabel!
    @IBOutlet weak var emailUsLbl: UILabel!
    @IBOutlet weak var emailUsDetailsLbl: UILabel!
    @IBOutlet weak var liveSupportLbl: UILabel!
    @IBOutlet weak var liveSupportDescriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGestures()
        setUpNavigation()
        localize()

    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "contactUs".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        
    }
    
    func localize() {
        
        callUsLbl.text = "callUs".localizableString()
        callUsLbl.setLocalization()
        
        callUsDetailsLbl.text = "callUsDescription".localizableString()
        callUsDetailsLbl.setLocalization()
        
        emailUsLbl.text = "emailUs".localizableString()
        emailUsLbl.setLocalization()
        
        emailUsDetailsLbl.text = "emailUsDescription".localizableString()
        emailUsDetailsLbl.setLocalization()
        
        liveSupportLbl.text = "liveSupport".localizableString()
        liveSupportLbl.setLocalization()
        
        liveSupportDescriptionLbl.text = "liveSupportDescription".localizableString()
        liveSupportDescriptionLbl.setLocalization()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

    func initGestures() {
        
        let callUsGesture = UITapGestureRecognizer(target: self, action: #selector(self.callUsTapped))
        
        callUsView.addGestureRecognizer(callUsGesture)
        
        let emailGesture = UITapGestureRecognizer(target: self, action: #selector(self.emailUsTapped))
        
        emailUsView.addGestureRecognizer(emailGesture)
        
        
        let liveSupportUsGesture = UITapGestureRecognizer(target: self, action: #selector(self.liveSupportTapped))
        
        liveSupportView.addGestureRecognizer(liveSupportUsGesture)

    }
    
    @objc func callUsTapped(_ sender: UITapGestureRecognizer) {
        
       // dialNumber(number: SharedSettings.shared.settings?.mobile! ?? "")
    }
    
    @objc func emailUsTapped(_ sender: UITapGestureRecognizer) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let emailUsVC = storyBoard.instantiateViewController(identifier: "EmailUsVC")
        self.navigationController?.pushViewController(emailUsVC, animated: true)
    }
    
    
    @objc func liveSupportTapped(_ sender: UITapGestureRecognizer) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let liveSupportVC = storyBoard.instantiateViewController(identifier: "LiveSupportVC")
        self.navigationController?.pushViewController(liveSupportVC, animated: true)
    }

}
