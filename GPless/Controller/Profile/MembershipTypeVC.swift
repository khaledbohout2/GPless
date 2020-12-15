//
//  MembershipTypeVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class MembershipTypeVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var planeLbl: UILabel!
    
    @IBOutlet weak var planeDetailsLbl: UILabel!
    @IBOutlet weak var showOtherPlansBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeBottomCornerRadius(myView: headerView)
        setUpNavigation()
        localize()
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "MemberShip Type"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    func localize() {
        
        showOtherPlansBtn.setTitle("showOtherPlans", for: .normal)
    }
    
    @objc func backTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    

    

    @IBAction func showOtherPlansBtnTapped(_ sender: Any) {
        
        
//        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
//        let pointsVC = storyBoard.instantiateViewController(identifier: "PointsVC")
//        self.navigationController?.pushViewController(pointsVC, animated: true)
    }
    

}
