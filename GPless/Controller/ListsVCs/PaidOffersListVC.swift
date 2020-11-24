//
//  PaidOffersListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class PaidOffersListVC: UIViewController {
    
    
    @IBOutlet weak var paidOffersCollectionView: UICollectionView!
    
    var gridView = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        setUpNavigation()

    }
    
    func initCollectionView() {
        
        let paidOffersNib = UINib(nibName: "PaidOffersCollectionViewCell", bundle: nil)
        let paidOffersVerticalNib = UINib(nibName: "PaidOffersVerticalCollectionViewCell", bundle: nil)
        paidOffersCollectionView.register(paidOffersNib, forCellWithReuseIdentifier: "PaidOffersCollectionViewCell")
        paidOffersCollectionView.register(paidOffersVerticalNib, forCellWithReuseIdentifier: "PaidOffersVerticalCollectionViewCell")
        paidOffersCollectionView.delegate = self
        paidOffersCollectionView.dataSource = self

    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "Paid Offers"
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
            
            if let flowLayout = paidOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            gridView = !gridView
            
        } else {
            
            if let flowLayout = paidOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            gridView = !gridView
            
        }
        paidOffersCollectionView.reloadData()
        
    }
    
    @IBAction func filterBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Home", bundle: nil)
        let filterVC = storiBoard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.pushViewController(filterVC, animated: true)
        
    }
    
    
}

extension PaidOffersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if gridView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersCollectionViewCell", for: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC")
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)
    }
    
    
}


