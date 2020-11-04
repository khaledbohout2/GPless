//
//  FilterVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/4/20.
//

import UIKit
import SwiftRangeSlider

class FilterVC: UIViewController {
    
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    let categories = ["FilterCategory1", "FilterCategory2", "FilterCategory3", "FilterCategory4"]
    
    let categoriesTitle = ["Electronics", "Fashion", "Travel", "Food"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        setUpNavigation()
        


        // Do any additional setup after loading the view.
    }
    
    func initCollectionView() {
        
        let categoriesNib = UINib(nibName: "FilterCategoriesCollectionViewCells", bundle: nil)
        categoriesCollectionView.register(categoriesNib, forCellWithReuseIdentifier: "FilterCategoriesCollectionViewCells")
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
    }
    
    func setUpNavigation() {
        
        self.navigationItem.title = "Filtter"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#282828"),
                                                                        NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!]
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        
        let backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        backBtn.image = UIImage(named: "Iconly-Light-Arrow - Left")
        backBtn.tintColor = hexStringToUIColor(hex: "")
        navigationItem.backBarButtonItem = backBtn
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    

}

extension FilterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoriesCollectionViewCells", for: indexPath) as! FilterCategoriesCollectionViewCells
        cell.categoryImageView.image = UIImage(named: categories[indexPath.row])
        cell.categoryTitleLbl.text = categoriesTitle[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 85, height: 110)
        
    }
    
    
    
}
