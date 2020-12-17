//
//  HomeVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var pannersCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var freeOffersCollectionView: UICollectionView!
    @IBOutlet weak var paidOffersCollectionView: UICollectionView!
    @IBOutlet weak var featureBrandsCollectionView: UICollectionView!
    @IBOutlet weak var hotOffersCollectionView: UICollectionView!
    @IBOutlet weak var indicatorContainer: UIView!
    @IBOutlet weak var indicatorActitvity: UIActivityIndicatorView!
    
    @IBOutlet weak var whtsInTodayLbl: UILabel!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var viewAllCategoriesBtn: UIButton!
    @IBOutlet weak var freeOffersLbl: UILabel!
    @IBOutlet weak var viewAllFreeOffersLbl: UIButton!
    @IBOutlet weak var paidOffersLbl: UILabel!
    @IBOutlet weak var ViewAllPaidOfffersBtn: UIButton!
    @IBOutlet weak var viewAllFeaturedBrandsLbl: UIButton!
    @IBOutlet weak var featuredBrandsLbl: UILabel!
    @IBOutlet weak var hotOffersLbl: UILabel!
    @IBOutlet weak var viewAllHotOffersBtn: UIButton!
    
    
    var categories = [CategoryElement]()
    var freeOffers = [OfferModel]()
    var paidOffers = [OfferModel]()
    var hotOffers = [OfferModel]()
    var brands = [Brand]()
    var pannersArr = [String]()
    var categoryIndex = "1"
    
    var brandColors = ["#2BB49D", "#4089E8", "#E95FA4", "#F6C677"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
                
        initCollectionViews()
        setUpNavigation()
        
        if Reachable.isConnectedToNetwork() {
            
        getHomeData()
        getCategories()
            
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.pannersCollectionView.scrollToItem(at:IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
    
        let logo = UIImage(named: "navigationTitle")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let search = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchTapped))
        search.image = UIImage(named: "navigationSearch")
        search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.rightBarButtonItem = search
        
    }
    
    func localize() {
        
        whtsInTodayLbl.text = "whatsinToday".localizableString()
        whtsInTodayLbl.setLocalization()
        
        categoriesLbl.text = "categories".localizableString()
        categoriesLbl.setLocalization()
        
        viewAllCategoriesBtn.setTitle("viewall".localizableString(), for: .normal)
        viewAllCategoriesBtn.setLocalization()
        
        freeOffersLbl.text = "freeOffers".localizableString()
        freeOffersLbl.setLocalization()
        
        viewAllFreeOffersLbl.setTitle("viewall".localizableString(), for: .normal)
        viewAllFreeOffersLbl.setLocalization()
        
        paidOffersLbl.text = "paidOffers".localizableString()
        paidOffersLbl.setLocalization()
        
        ViewAllPaidOfffersBtn.setTitle("viewall".localizableString(), for: .normal)
        ViewAllPaidOfffersBtn.setLocalization()
        viewAllFeaturedBrandsLbl.setTitle("viewall".localizableString(), for: .normal)
        viewAllFeaturedBrandsLbl.setLocalization()
        
        featuredBrandsLbl.text = "featureBrands".localizableString()
        featuredBrandsLbl.setLocalization()
        
        hotOffersLbl.text = "hotOffers".localizableString()
        hotOffersLbl.setLocalization()
        
        viewAllHotOffersBtn.setTitle("viewall".localizableString(), for: .normal)
        viewAllHotOffersBtn.setLocalization()
    }
    
    @objc func searchTapped() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeSearchVC =  storyboard.instantiateViewController(identifier: "HomeSearchVC") as! HomeSearchVC
        self.addChild(homeSearchVC)
        homeSearchVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview((homeSearchVC.view)!)
        homeSearchVC.didMove(toParent: self)
            
            self.view.addConstraints([
                NSLayoutConstraint(item: homeSearchVC.view!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: homeSearchVC.view!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: homeSearchVC.view!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: homeSearchVC.view!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
                ])
        
    }
    
    func initCollectionViews() {
        
        let pannersNib = UINib(nibName: "PannersCollectionViewCell", bundle: nil)
        pannersCollectionView.register(pannersNib, forCellWithReuseIdentifier: "PannersCollectionViewCell")
        pannersCollectionView.delegate = self
        pannersCollectionView.dataSource = self
        pannersCollectionView.scrollToItem(at:IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        
        
        
        let categoriesNib = UINib(nibName: "categoriesCollectionViewCell", bundle: nil)
        categoriesCollectionView.register(categoriesNib, forCellWithReuseIdentifier: "categoriesCollectionViewCell")
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        let featureBrandsNib = UINib(nibName: "FeatureBrandsCollectionViewCell", bundle: nil)
        featureBrandsCollectionView.register(featureBrandsNib, forCellWithReuseIdentifier: "FeatureBrandsCollectionViewCell")
        featureBrandsCollectionView.delegate = self
        featureBrandsCollectionView.dataSource = self
        
        
        let popularOffersNib = UINib(nibName: "PopularOffersCollectionViewCell", bundle: nil)
        hotOffersCollectionView.register(popularOffersNib, forCellWithReuseIdentifier: "PopularOffersCollectionViewCell")
        hotOffersCollectionView.delegate = self
        hotOffersCollectionView.dataSource = self
        
        
        
        let paidOffersNib = UINib(nibName: "PaidOffersCollectionViewCell", bundle: nil)
        paidOffersCollectionView.register(paidOffersNib, forCellWithReuseIdentifier: "PaidOffersCollectionViewCell")   
        paidOffersCollectionView.delegate = self
        paidOffersCollectionView.dataSource = self
        
        let hotOfferNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        freeOffersCollectionView.register(hotOfferNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        freeOffersCollectionView.delegate = self
        freeOffersCollectionView.dataSource = self
        
//        let layout = hotOffersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumInteritemSpacing = 0 // The minimum spacing to use between items in the same row.
//        hotOffersCollectionView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        

        
    }
    
    func reloadCollectionViews() {
        
        featureBrandsCollectionView.reloadData()
        freeOffersCollectionView.reloadData()
        paidOffersCollectionView.reloadData()
        hotOffersCollectionView.reloadData()
        pannersCollectionView.reloadData()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func viewAllCategoriesBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Lists", bundle: nil)
        let categoriesListVC = storiBoard.instantiateViewController(identifier: "CategoriesListVC") as! CategoriesListVC
        self.navigationController?.pushViewController(categoriesListVC, animated: true)
    }
    
    @IBAction func ViewAllFreeOffersBtnTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func viewAllPaidOffersBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Lists", bundle: nil)
        let paidOffersListVC = storiBoard.instantiateViewController(identifier: "PaidOffersListVC") as! PaidOffersListVC
        paidOffersListVC.type = "paid"
        self.navigationController?.pushViewController(paidOffersListVC, animated: true)
    }
    
    
    @IBAction func viewAllFeaturedBrands(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Lists", bundle: nil)
        let brandsListVC = storiBoard.instantiateViewController(identifier: "BrandsListVC") as! BrandsListVC
        self.navigationController?.pushViewController(brandsListVC, animated: true)
        
    }
    
    @IBAction func viewAllHotOffersTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Lists", bundle: nil)
        let paidOffersListVC = storiBoard.instantiateViewController(identifier: "PaidOffersListVC") as! PaidOffersListVC
        paidOffersListVC.type = "free"
        self.navigationController?.pushViewController(paidOffersListVC, animated: true)
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == pannersCollectionView {
            
            return pannersArr.count
            
        } else if collectionView == categoriesCollectionView {
            
            return categories.count
            
        } else if  collectionView == featureBrandsCollectionView {
            
            return brands.count
            
        }  else if collectionView == freeOffersCollectionView {
            
            return freeOffers.count
            
        } else if collectionView == paidOffersCollectionView {
            
            return paidOffers.count
            
        } else if collectionView == hotOffersCollectionView {
            
            return hotOffers.count
            
        } else {
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == pannersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PannersCollectionViewCell", for: indexPath) as! PannersCollectionViewCell
            cell.configureCell(banner: self.pannersArr[indexPath.row])
            
            return cell
            
        } else if collectionView == categoriesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCollectionViewCell", for: indexPath) as! categoriesCollectionViewCell
            
            cell.configureCell(category: self.categories[indexPath.row])
            
            return cell
            
        } else if collectionView == hotOffersCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularOffersCollectionViewCell", for: indexPath) as! PopularOffersCollectionViewCell
            
            cell.configureCell(offer: self.hotOffers[indexPath.row])
            
            return cell
            
        } else if collectionView == paidOffersCollectionView  {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersCollectionViewCell", for: indexPath) as! PaidOffersCollectionViewCell
            cell.configureCell(offer: self.paidOffers[indexPath.row])
            return cell
            
        } else if collectionView == featureBrandsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureBrandsCollectionViewCell", for: indexPath) as! FeatureBrandsCollectionViewCell
            cell.configureCell(brand: self.brands[indexPath.row], color: brandColors[indexPath.row])
            
            return cell
            
        } else if collectionView == freeOffersCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotOffersCollectionViewCell", for: indexPath) as! HotOffersCollectionViewCell
            cell.configureCell(offer: self.freeOffers[indexPath.row])
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == pannersCollectionView {
            
            return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.height)
            
        } else if collectionView == categoriesCollectionView || collectionView == featureBrandsCollectionView {
            
            return CGSize(width: (collectionView.frame.width - 18) / 4 , height: collectionView.frame.height)
            
        } else if collectionView == hotOffersCollectionView {
            
            return CGSize(width: collectionView.frame.width / 1.75, height: collectionView.frame.height + 24)
            
        } else if collectionView == paidOffersCollectionView || collectionView == freeOffersCollectionView {
            
            return CGSize(width: (collectionView.frame.width - 18) / 2, height: (collectionView.frame.height) / 2)
            
        } else {
            
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoriesCollectionView {
            if indexPath.row == 3 {
                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                let foodOffersListVC = storyBoard.instantiateViewController(identifier: "FoodOffersListVC")
                self.navigationController?.pushViewController(foodOffersListVC, animated: true)
            }
        } else if collectionView == paidOffersCollectionView {
            
            let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
            let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC") as! OfferDetailsVC
            offerDetailsVC.id = "\(paidOffers[indexPath.row].id!)"
            self.navigationController?.pushViewController(offerDetailsVC, animated: true)
            
        } else if collectionView == hotOffersCollectionView {
            
            let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
            let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC") as! OfferDetailsVC
            offerDetailsVC.id = "\(hotOffers[indexPath.row].id!)"
            self.navigationController?.pushViewController(offerDetailsVC, animated: true)
            
        } else if collectionView == freeOffersCollectionView {
            let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
            let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC") as! OfferDetailsVC
            offerDetailsVC.id = "\(freeOffers[indexPath.row].id!)"
            self.navigationController?.pushViewController(offerDetailsVC, animated: true)
            
        }
    }
}

//MARK: - APIs
extension HomeVC {

    func getHomeData() {
        
        indicatorActitvity.startAnimating()
            
        _ = Network.request(req: HomeOffersRequest(), completionHandler: { (result) in
            switch result {
            
            case .success(let homeOffers):
                
                self.indicatorActitvity.stopAnimating()
                self.indicatorContainer.isHidden = true
                self.brands = homeOffers.featured!
                self.freeOffers = homeOffers.freeOffers!
                self.paidOffers = homeOffers.paidOffers!
                self.hotOffers = homeOffers.populerOffers!
                self.pannersArr = homeOffers.photos!
                self.reloadCollectionViews()
                
            case .cancel(let cancelError):
                print(cancelError!)
                
                self.indicatorActitvity.stopAnimating()
                self.indicatorContainer.isHidden = true
                Toast.show(message: "Sorry, some error happened, please try again", controller: self)
                
            case .failure(let error):
                print(error!)
            }
        })
            
    }
    
    func getCategories() {
        
        _ = Network.request(req: CategoriesRequest(index: self.categoryIndex), completionHandler: { (result) in
           switch result {
           case .success(let response):
           print(response)
            self.categories = response.categories!
            self.categoriesCollectionView.reloadData()
           case .cancel(let cancelError):
           print(cancelError!)
           case .failure(let error):
           print(error!)
            }
        })
    }
}
