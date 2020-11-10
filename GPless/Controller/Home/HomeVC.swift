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
    
    @IBOutlet weak var popularOffersCollectionView: UICollectionView!
    
    @IBOutlet weak var paidOffersCollectionView: UICollectionView!
    
    @IBOutlet weak var featureBrandsCollectionView: UICollectionView!
    
    @IBOutlet weak var hotOffersCollectionView: UICollectionView!
    
    let categories = ["category1", "category2", "category3", "category4"]
    let categoriesTitle = ["Electronics", "Fashion", "Travel", "Food"]
    let brands = ["Brand1", "Brand2", "Brand3" , "Brand4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionViews()
        setUpNavigation()

    }
    
    func setUpNavigation() {
        
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
    
    @objc func searchTapped() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeSearchVC =  storyboard.instantiateViewController(identifier: "HomeSearchVC") as? HomeSearchVC
        self.addChild(homeSearchVC!)
        homeSearchVC?.view.frame = self.view.frame
        self.view.addSubview((homeSearchVC?.view)!)
        homeSearchVC?.didMove(toParent: self)
        
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
        popularOffersCollectionView.register(popularOffersNib, forCellWithReuseIdentifier: "PopularOffersCollectionViewCell")
        popularOffersCollectionView.delegate = self
        popularOffersCollectionView.dataSource = self
        
        
        
        let paidOffersNib = UINib(nibName: "PaidOffersCollectionViewCell", bundle: nil)
        paidOffersCollectionView.register(paidOffersNib, forCellWithReuseIdentifier: "PaidOffersCollectionViewCell")   
        paidOffersCollectionView.delegate = self
        paidOffersCollectionView.dataSource = self
        
        let hotOffersNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        hotOffersCollectionView.register(hotOffersNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        hotOffersCollectionView.delegate = self
        hotOffersCollectionView.dataSource = self
        
        let layout = hotOffersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0 // The minimum spacing to use between items in the same row.
        hotOffersCollectionView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    //MARK: - IBActions
    
    @IBAction func viewAllCategoriesBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Lists", bundle: nil)
        let categoriesListVC = storiBoard.instantiateViewController(identifier: "CategoriesListVC") as! CategoriesListVC
        self.navigationController?.pushViewController(categoriesListVC, animated: true)
    }
    
    @IBAction func ViewAllPopularOffersBtnTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func viewAllPaidOfeersBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Lists", bundle: nil)
        let paidOffersListVC = storiBoard.instantiateViewController(identifier: "PaidOffersListVC") as! PaidOffersListVC
        self.navigationController?.pushViewController(paidOffersListVC, animated: true)
    }
    
    
    @IBAction func viewAllFeaturedBrands(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Lists", bundle: nil)
        let paidOffersListVC = storiBoard.instantiateViewController(identifier: "BrandsListVC") as! BrandsListVC
        self.navigationController?.pushViewController(paidOffersListVC, animated: true)
        
    }
    
    
    @IBOutlet weak var viewAllHotOffersBtnTapped: UICollectionView!
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == pannersCollectionView {
            
            return 3
            
        } else if collectionView == categoriesCollectionView || collectionView == featureBrandsCollectionView {
            
            return 4
            
        } else if collectionView == popularOffersCollectionView {
            
            return 2
            
        } else if collectionView == paidOffersCollectionView || collectionView == hotOffersCollectionView {
            
            return 4
            
        } else {
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == pannersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PannersCollectionViewCell", for: indexPath)
            
            return cell
            
        } else if collectionView == categoriesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCollectionViewCell", for: indexPath) as! categoriesCollectionViewCell
            cell.categoryImageView.image = UIImage(named: categories[indexPath.row])
            cell.categoryTitleLbl.text = categoriesTitle[indexPath.row]
            return cell
            
        } else if collectionView == popularOffersCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularOffersCollectionViewCell", for: indexPath)
            return cell
            
        } else if collectionView == paidOffersCollectionView  {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersCollectionViewCell", for: indexPath)
            return cell
            
        } else if collectionView == featureBrandsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureBrandsCollectionViewCell", for: indexPath) as! FeatureBrandsCollectionViewCell
            cell.brandImageView.image = UIImage(named: brands[indexPath.row])
            return cell
            
        } else if collectionView == hotOffersCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotOffersCollectionViewCell", for: indexPath)
            return cell
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == pannersCollectionView {
            
            return CGSize(width: collectionView.frame.width - 54, height: collectionView.frame.height)
            
        } else if collectionView == categoriesCollectionView || collectionView == featureBrandsCollectionView {
            
            return CGSize(width: 85, height: 110)
            
        } else if collectionView == popularOffersCollectionView {
            
            return CGSize(width: 212, height: 176)
            
        } else if collectionView == paidOffersCollectionView || collectionView == hotOffersCollectionView {
            
            return CGSize(width: collectionView.frame.width / 2, height: 162)
            
        } else {
            
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoriesCollectionView {
            if indexPath.row == 3 {
                let storyBoard = UIStoryboard(name: "Lists", bundle: nil)
                let foodOffersListVC = storyBoard.instantiateViewController(identifier: "FoodOffersListVC")
                self.navigationController?.pushViewController(foodOffersListVC, animated: true)
            }
        }
    }
    
}
