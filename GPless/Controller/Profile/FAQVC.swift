//
//  FAQVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class FAQVC: UIViewController {
    
    
    @IBOutlet weak var fAQTableView: UITableView!
    
    var dict = [String: [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setUpNavigation()
        getFAQs()
        // Do any additional setup after loading the view.
    }
    
    func initTableView() {
        
        fAQTableView.delegate = self
        fAQTableView.dataSource = self
        let nib = UINib(nibName: "FAQTableViewCell", bundle: nil)
        fAQTableView.register(nib, forCellReuseIdentifier: "FAQTableViewCell")
        
        fAQTableView.rowHeight = UITableView.automaticDimension
        fAQTableView.estimatedRowHeight = 50
        
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "FAQs".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
    
    }
    
    func getFAQs() {
        
        let FAQs = SharedSettings.shared.settings?.faqs
        
        dict["What is Gpless application?"] = FAQs?.whatIsGplessApplication
        
        dict["How to use Gpless app ?"] = FAQs?.howToUseGplessApp
        
        dict["How to use Gpless’ live support team ?"] = FAQs?.howToUseGplessLiveSupportTeam
        
        dict["How many offers can I get free?"] = FAQs?.howManyOffersCanIGetFree
        
        dict["What are the premium account benefits ?"] = FAQs?.whatAreThePremiumAccountBenefits
        
        fAQTableView.reloadData()
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
extension FAQVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
        
        cell.configureCell(question: Array(dict.keys)[indexPath.row], answers: Array(dict.values)[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width / 1.8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let termsAndConditionsVC = storyBoard.instantiateViewController(identifier: "TermsAndConditionsVC")
        self.navigationController?.pushViewController(termsAndConditionsVC, animated: true)
    }
    
    
}
