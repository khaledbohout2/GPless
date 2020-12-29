//
//  CategoryOffersListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/9/20.
//

import UIKit

class CategoryOffersListVC: UIViewController {
    
    
    @IBOutlet weak var foodOffersCollectionView: UICollectionView!
    var gridView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        setUpNavigation()

    }
    
    func initCollectionView() {
        
        let hotOffersNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        let PaidOffersVerticalNib = UINib(nibName: "PaidOffersVerticalCollectionViewCell", bundle: nil)
        
        foodOffersCollectionView.register(hotOffersNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        foodOffersCollectionView.register(PaidOffersVerticalNib, forCellWithReuseIdentifier: "PaidOffersVerticalCollectionViewCell")
        foodOffersCollectionView.delegate = self
        foodOffersCollectionView.dataSource = self

    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

       // self.title = "Food Offers"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        
        let search = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchTapped))
        search.image = UIImage(named: "navigationSearch")
        search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.rightBarButtonItem = search
        
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
    
    
    @IBAction func switchListingBtnTapped(_ sender: Any) {
        
        if gridView {
            
            if let flowLayout = foodOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            gridView = !gridView
            
        } else {
            
            if let flowLayout = foodOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            gridView = !gridView
            
        }
        foodOffersCollectionView.reloadData()
        
    }
    

    
    @IBAction func filterBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Home", bundle: nil)
        let filterVC = storiBoard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    
}

extension CategoryOffersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if gridView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotOffersCollectionViewCell", for: indexPath)
        return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersVerticalCollectionViewCell", for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if gridView {
            
        return CGSize(width: collectionView.frame.width / 2, height: 162)
            
        } else {
            
            return CGSize(width: collectionView.frame.width, height: 116)
        }
    }
    
    
}
