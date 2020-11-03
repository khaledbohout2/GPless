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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionViews()

        // Do any additional setup after loading the view.
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
        
        setUpNavigation()

        
        let pannersNib = UINib(nibName: "PannersCollectionViewCell", bundle: nil)
        pannersCollectionView.register(pannersNib, forCellWithReuseIdentifier: "PannersCollectionViewCell")
        pannersCollectionView.delegate = self
        pannersCollectionView.dataSource = self
        
        
        
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
        
    }

}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == pannersCollectionView {
            
            return 3
            
        } else if collectionView == categoriesCollectionView || collectionView == featureBrandsCollectionView {
            
            return 6
            
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
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCollectionViewCell", for: indexPath)
            return cell
            
        } else if collectionView == popularOffersCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularOffersCollectionViewCell", for: indexPath)
            return cell
            
        } else if collectionView == paidOffersCollectionView  {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersCollectionViewCell", for: indexPath)
            return cell
            
        } else if collectionView == featureBrandsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureBrandsCollectionViewCell", for: indexPath)
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
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            
        } else if collectionView == categoriesCollectionView || collectionView == featureBrandsCollectionView {
            
            return CGSize(width: 85, height: 110)
            
        } else if collectionView == popularOffersCollectionView {
            
            return CGSize(width: 212, height: 176)
            
        } else if collectionView == paidOffersCollectionView || collectionView == hotOffersCollectionView {
            return CGSize(width: 173, height: 162)
        } else {
            
            return CGSize(width: 0, height: 0)
        }
    }
    
    
    
    
}
