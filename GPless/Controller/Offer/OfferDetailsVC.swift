//
//  GetOfferVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit
import Cosmos

class OfferDetailsVC: UIViewController {
    
    @IBOutlet weak var offerImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var brandView: UIView!
    
    @IBOutlet weak var brnadViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stroesTableView: UITableView!
    
    @IBOutlet weak var brandImageView: UIImageView!
    
    @IBOutlet weak var offerTitleLbl: UILabel!
    
    @IBOutlet weak var offerPriceLbl: UILabel!
    
    @IBOutlet weak var oldPriceLbl: UILabel!
    
    @IBOutlet weak var offerCategoryLbl: UILabel!
    
    @IBOutlet weak var offerDetails: UITextView!
    
    @IBOutlet weak var offerRatingView: CosmosView!
    
    @IBOutlet weak var reviesNumLbl: UILabel!
    
    @IBOutlet weak var pontsLbl: UILabel!
    
    
    
    var isAreasExpanded = false
    var id: String?
    var offer: OfferModel?
    var offerImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    

    func setUp() {
        
        getOfferDetails()
        
        let openStoresGesture = UIGestureRecognizer(target: self, action: #selector(self.openStores))
        
        brandView.addGestureRecognizer(openStoresGesture)
        brandImageView.addGestureRecognizer(openStoresGesture)
        
        stroesTableView.delegate = self
        stroesTableView.dataSource = self
        
        // ExpandableTableViewCell
        
        let nib = UINib(nibName: "ExpandableTableViewCell", bundle: nil)
        
        stroesTableView.register(nib, forCellReuseIdentifier: "ExpandableTableViewCell")
        
        self.tabBarController?.tabBar.isHidden = true
        
        getOfferDetails()
    }
    
    func setUpNavigation() {
        

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "Offer Details"
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
    
    
    func updateUI() {
        
      //  self.offerImages = self.offer?.imageLink
      //  self.stores = self.offer.
      //  self.brandImageView.image = self.offer.
        self.offerTitleLbl.text = self.offer?.name
        self.offerPriceLbl.text = "\(self.offer!.priceAfterDiscount)"
        self.offerCategoryLbl.text = self.offer?.categoryType
        self.offerDetails.text = self.offer?.categoryDescription
     //   self.offerRatingView.rating =
       // self.reviesNumLbl.text = self.offer.
        let oldPrice = "\(self.offer!.priceAfterDiscount)"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0

        let hyphenAttribute = [
            NSAttributedString.Key.paragraphStyle : paragraphStyle,
        ] as [NSAttributedString.Key : Any]

        let attributedString = NSMutableAttributedString(string: oldPrice, attributes: hyphenAttribute)
        self.oldPriceLbl.attributedText = attributedString
        
        self.pontsLbl.text = "Earn \(self.offer?.points) points"
        
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
    
    @objc func openStores (_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            if !self.isAreasExpanded {
             self.brnadViewHeight?.constant = 279
                self.isAreasExpanded = true
            } else {
                self.brnadViewHeight?.constant = 94
                self.isAreasExpanded = false
            }
             self.view.layoutIfNeeded()
         }, completion: nil)
        
    }
    
    @IBAction func expandStoresGesture(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            if !self.isAreasExpanded {
                
             self.brnadViewHeight?.constant = 279
                self.isAreasExpanded = true
                
            } else {
                
                self.brnadViewHeight?.constant = 94
                self.isAreasExpanded = false
            }
             self.view.layoutIfNeeded()
            
         }, completion: nil)
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func favouriteBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func locationBtnTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func bookOfferBtnTapped(_ sender: Any) {
        
        if getUserData() == true {
            
            let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
            let cartVC = storyBoard.instantiateViewController(identifier: "CartVC")
            self.navigationController?.pushViewController(cartVC, animated: true)
            
        } else {
        
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let pleaseLoginVC =  storyboard.instantiateViewController(identifier: "PleaseLoginVC")
        self.addChild(pleaseLoginVC)
        pleaseLoginVC.view.frame = self.view.frame
        self.view.addSubview((pleaseLoginVC.view)!)
        pleaseLoginVC.didMove(toParent: self)
            
        }
        
    }
    
}
extension OfferDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell")
        return cell!
    }

}

extension OfferDetailsVC {
    
    func getOfferDetails() {
        
        Network.request(req: OfferRequest(id: self.id!)) { (result) in
            switch result {
            case .success(let offer):
                print(offer)
                self.offer = offer
                self.updateUI()
            case .cancel(let cancelError):
            print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        }
    }
}



