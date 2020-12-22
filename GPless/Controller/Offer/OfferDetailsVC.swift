//
//  GetOfferVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit
import Cosmos
import SDWebImage

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
    @IBOutlet weak var offerPriseBtn: UIButton!
    @IBOutlet weak var remainingTimeBtn: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var selectBranchLbl: UILabel!
    @IBOutlet weak var timesLeftLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var bookOfferTapped: UIButton!
    
    var mySubview = UIView()
    var indicator = UIActivityIndicatorView()
    
    var isAreasExpanded = false
    var id: String!
    var offer: OfferModel?
    var offerImages = [String]()
    var branches = [Branch]()
    var selectedBranch: Branch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpNavigation()
        localize()
        
        addLoadingView(mySubview: mySubview, indicator: indicator, view: view)
        
        if Reachable.isConnectedToNetwork() {
            
        getOfferDetails()
            
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }
        
        setUpCollectionView()

    }
    

    func setUp() {
        
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
    
    func setUpCollectionView() {
        offerImagesCollectionView.delegate = self
        offerImagesCollectionView.dataSource = self
        let nib = UINib(nibName: "OfferImagesCollectionViewCell", bundle: nil)
        offerImagesCollectionView.register(nib, forCellWithReuseIdentifier: "OfferImagesCollectionViewCell")
    }

    func updateUI() {
        
        self.offerImages.append(offer?.imageLink ?? "")
        self.offerImagesCollectionView.reloadData()
        
        self.storeNameLbl.text = self.offer?.vendorName
        
        let baseBrand = SharedSettings.shared.settings?.usersPhotoLink ?? ""
        let brandImage = offer?.vendorPhoto ?? ""
        
        self.brandImageView.sd_setImage(with: URL(string: baseBrand + "/" + brandImage))
        
        self.offerTitleLbl.text = self.offer?.name
        self.offerTitleLbl.setLocalization()
        
        self.offerPriceLbl.text = "\(self.offer!.priceAfterDiscount!)"
        
        self.offerCategoryLbl.text = self.offer!.categoryType
        self.offerCategoryLbl.setLocalization()
        
        self.offerDetails.text = self.offer!.offerDetailsDescription
        
        self.offerRatingView.rating = Double((self.offer?.avgRate)!)
        self.reviesNumLbl.text = "\(self.offer!.reviews!)"
        let oldPrice = "\(self.offer!.priceAfterDiscount!)"
        
        self.offerPriseBtn.setTitle("getofferby".localizableString() + "\(self.offer!.premuimPaid!)" + "L.E".localizableString(), for: .normal)
        self.offerPriseBtn.setLocalization()
        
        self.remainingTimeBtn.text = self.offer!.remainingTime
        
        if let offerUsage = self.offer!.offerUsage {
            
            self.timesLeftLbl.text = "\(offerUsage)" + "itemLeft".localizableString()
        } else {
            self.timesLeftLbl.text = "unLimited".localizableString()
        }
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0

        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.oldPriceLbl.attributedText = attributeString
        
        self.pontsLbl.text = "earn".localizableString() + "\(self.offer!.points!) " + "points".localizableString()
        
        let languagePrefix = Locale.preferredLanguages[0]
        if languagePrefix == "ar" {
            
            offerPriseBtn.contentHorizontalAlignment = .right
        }
        
        if getUserType() == "0" {
            
            bookOfferTapped.setTitle("bookOffer".localizableString(), for: .normal)
            bookOfferTapped.setLocalization()
            
            
            
        } else {
            
            bookOfferTapped.setTitle("getOffer".localizableString(), for: .normal)
            bookOfferTapped.setLocalization()
                        
            offerPriseBtn.setTitle("premiumOffer".localizableString(), for: .normal)
        }
        
    }
    
    func localize() {
        
        selectBranchLbl.text = "selectBranch".localizableString()
        selectBranchLbl.setLocalization()
  
    }
    
    //MARK: - IBActions

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
        
        let gpless = "gpless://offerID=\(offer!.id!)"
        
        let items: [Any] = ["check this awesome offer from GPLess", URL(string: gpless)!]
        
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(ac, animated: true)
    }
    
    @IBAction func favouriteBtnTapped(_ sender: Any) {
        
        if Reachable.isConnectedToNetwork() {
            
            if getUserData() {
            
            rateOffer()
                
            } else {
                
                Toast.show(message: "pleaseLogin", controller: self)
            }
            
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }

    }
    
    @IBAction func locationBtnTapped(_ sender: Any) {
        
        guard selectedBranch != nil else {
            Toast.show(message: "please select Branch", controller: self)
            return
        }
        
        let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(selectedBranch.latitude!),\(selectedBranch.longitude!)")
        UIApplication.shared.open(url!)
        
    }
    
    @IBAction func bookOfferBtnTapped(_ sender: Any) {
        
        if getUserData() == true {
            
            guard self.selectedBranch != nil else {
                Toast.show(message: "Please select branch", controller: self)
                return
            }
            
            let storyboard = UIStoryboard(name: "Offer", bundle: nil)
            let goToBranchVC =  storyboard.instantiateViewController(identifier: "GoToBranchVC") as! GoToBranchVC
            
            goToBranchVC.offer = self.offer
            goToBranchVC.selectedBranch = selectedBranch

            self.addChild(goToBranchVC)
          //  pleaseLoginVC.view.frame = self.view.frame
            goToBranchVC.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview((goToBranchVC.view)!)
            goToBranchVC.didMove(toParent: self)
                
                self.view.addConstraints([
                    NSLayoutConstraint(item: goToBranchVC.view!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: goToBranchVC.view!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: goToBranchVC.view!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: goToBranchVC.view!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
                    ])
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
        return branches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell") as! ExpandableTableViewCell
        cell.titleLbl.text = branches[indexPath.row].name
        cell.delegate = self
        cell.index = indexPath
        cell.tableView = tableView
        return cell
    }

}

extension OfferDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferImagesCollectionViewCell", for: indexPath) as! OfferImagesCollectionViewCell
        let baseImageLink = (SharedSettings.shared.settings?.offersLink) ?? ""
        let imageLink = offerImages[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: baseImageLink + "/" + imageLink))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height)
    }
    
    
}

extension OfferDetailsVC {
    
    func getOfferDetails() {
        
        _ = Network.request(req: OfferRequest(id: self.id)) { (result) in
            switch result {
            case .success(let offerDetails):
                print(offerDetails)
                self.offer = offerDetails.offer
                self.branches = offerDetails.branches!
                self.stroesTableView.reloadData()
                self.updateUI()
                self.mySubview.isHidden = true
                self.indicator.stopAnimating()
            case .cancel(let cancelError):
            print(cancelError!)
                self.mySubview.isHidden = true
                self.indicator.stopAnimating()
                Toast.show(message: "Sorry, some error happenned, please try again later", controller: self)
            case .failure(let error):
                print(error!)
            }
        }
    }
    
    func rateOffer() {
       
        _ = Network.request(req: FavouriteRequest(id: "\(self.offer!.id!)"), completionHandler: { (result) in
            switch result {
            case .success(let success):
                print(success)
                if success == 0 {
                    Toast.show(message: "faild to favourite, please try again later", controller: self)
                    self.mySubview.isHidden = true
                    self.indicator.stopAnimating()

                } else {
                    self.favouriteBtn.setImage(UIImage(named: "Group 215"), for: .normal)
                }
            case .cancel(let cancelError):
                print(cancelError!)
                self.mySubview.isHidden = true
                self.indicator.stopAnimating()
                Toast.show(message: "Sorry, some error happenned, please try again later", controller: self)
            case .failure(let error):
                print(self.offer!.id!)
                print(error!)
                self.mySubview.isHidden = true
                self.indicator.stopAnimating()
                Toast.show(message: "Sorry, some error happenned, please try again later", controller: self)
            }
        })
    }
}

extension OfferDetailsVC : CheckRadioBtnProtocol {
    
    func checkBtn(index: IndexPath, tableView: UITableView) {
        
        let cell = tableView.cellForRow(at: index) as! ExpandableTableViewCell
        cell.radioBtn.isSelected = true
        cell.radioBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        cell.radioBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        self.selectedBranch = branches[index.row]
    }
    
    
}



