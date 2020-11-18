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
    @IBOutlet weak var areasView: UIView!
    @IBOutlet weak var areasViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var expandAreaBtn: UIButton!
    @IBOutlet weak var expandBrandsBtn: UIButton!
    @IBOutlet weak var brandsView: UIView!
    @IBOutlet weak var sortByBtn: UIButton!
    @IBOutlet weak var sortByViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var brandsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewAreas: UITableView!
    @IBOutlet weak var tableViewBrands: UITableView!
    @IBOutlet weak var tableViewSortBy: UITableView!
    @IBOutlet weak var fromPriceTxtField: UITextField!
    @IBOutlet weak var toPriceTxtField: UITextField!
    @IBOutlet weak var rangeSlider: RangeSlider!
    
    var isAreasExpanded = false
    var isBrandsExpanded = false
    var isSortByExpanded = false
    
    let categories = ["FilterCategory1", "FilterCategory2", "FilterCategory3", "FilterCategory4"]
    let categoriesTitle = ["Electronics", "Fashion", "Travel", "Food"]
    let areas = ["area 1", "area 2", "area 3"]
    let brands = ["brand 1", "brand 2", "brand 3"]
    let sortBy = ["sortBy 1", "sortBy 2", "sortBy 3"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        initCollectionView()
        setUpNavigation()
        setUpTableViews()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpUI() {
        
        fromPriceTxtField.delegate = self
        toPriceTxtField.delegate = self
        fromPriceTxtField.text = "\(Int(rangeSlider.lowerValue))" + " L.E"
        toPriceTxtField.text = "\(Int(rangeSlider.upperValue))" + " L.E"
        rangeSlider.delegate = self
    }
    
    func initCollectionView() {
        
        let categoriesNib = UINib(nibName: "FilterCategoriesCollectionViewCells", bundle: nil)
        categoriesCollectionView.register(categoriesNib, forCellWithReuseIdentifier: "FilterCategoriesCollectionViewCells")
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.navigationItem.title = "Filtter"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#282828"),
                                                                        NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!]
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        
        let backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        backBtn.image = UIImage(named: "ArrowLeft")
       // backBtn.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = backBtn
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpTableViews() {
        
        let nib = UINib(nibName: "ExpandableTableViewCell", bundle: nil)
        tableViewAreas.register(nib, forCellReuseIdentifier: "ExpandableTableViewCell")
        tableViewAreas.delegate = self
        tableViewAreas.dataSource = self
        
        tableViewBrands.register(nib, forCellReuseIdentifier: "ExpandableTableViewCell")
        tableViewBrands.delegate = self
        tableViewBrands.dataSource = self
        
        tableViewSortBy.register(nib, forCellReuseIdentifier: "ExpandableTableViewCell")
        tableViewSortBy.delegate = self
        tableViewSortBy.dataSource = self
        
    }
    
    @IBAction func expandAreasBtnTapped(_ sender: Any) {
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            if !self.isAreasExpanded {
             self.areasViewHeightConstraint?.constant = 180
                self.isAreasExpanded = true
            } else {
                self.areasViewHeightConstraint?.constant = 0
                self.isAreasExpanded = false
            }
             self.view.layoutIfNeeded()
         }, completion: nil)
        
    }
    
    @IBAction func expandBrandsBtnTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            if !self.isBrandsExpanded {
             self.brandsViewHeightConstraint?.constant = 180
                self.isBrandsExpanded = true
            } else {
                self.brandsViewHeightConstraint?.constant = 0
                self.isBrandsExpanded = false
            }
             self.view.layoutIfNeeded()
            
         }, completion: nil)
        
    }
    
    @IBAction func expandSortByBtnTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            if !self.isSortByExpanded {
                
             self.sortByViewHeightConstraint?.constant = 180
                self.isSortByExpanded = true
            } else {
                self.sortByViewHeightConstraint?.constant = 0
                self.isSortByExpanded = false
            }
             self.view.layoutIfNeeded()
            
         }, completion: nil)
        
    }
    
    
    @IBAction func applyBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Lists", bundle: nil)
        let offersListVC =  storyboard.instantiateViewController(identifier: "OffersListVC") as! OffersListVC
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(offersListVC, animated: true)
        
        
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

extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewAreas {
            
            return areas.count
            
        } else if tableView == tableViewBrands {
            
            return brands.count
            
        } else if tableView == tableViewSortBy {
            
            return sortBy.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewAreas {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath) as! ExpandableTableViewCell
            cell.titleLbl.text = areas[indexPath.row]
            cell.delegate = self
            cell.index = indexPath
            cell.tableView = tableView
            
            return cell
            
        } else if tableView == tableViewBrands {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath) as! ExpandableTableViewCell
            cell.titleLbl.text = brands[indexPath.row]
            cell.delegate = self
            cell.index = indexPath
            cell.tableView = tableView
            return cell
            
        } else if tableView == tableViewSortBy {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath) as! ExpandableTableViewCell
            cell.titleLbl.text = sortBy[indexPath.row]
            cell.delegate = self
            cell.index = indexPath
            cell.tableView = tableView
            return cell
            
        } else {
            
            return UITableViewCell()
        }
    }
    
    
}

extension FilterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == fromPriceTxtField {
            
            rangeSlider.lowerValue = Double(textField.text!)!
            
        } else if textField == toPriceTxtField {
            
            rangeSlider.upperValue = Double(textField.text!)!
        }
    }
}

extension FilterVC: CheckRadioBtnProtocol {
    
    func checkBtn(index: IndexPath, tableView: UITableView) {
        
        let cell = tableView.cellForRow(at: index) as! ExpandableTableViewCell
        cell.radioBtn.isSelected = true
        cell.radioBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        cell.radioBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        let tableViewCells = tableView.visibleCells as! [ExpandableTableViewCell]
        
        for cell in tableViewCells {
            
            if cell.index != index {
                
            cell.radioBtn.isSelected = false
            cell.radioBtn.iconColor = hexStringToUIColor(hex: "#909090")
            cell.radioBtn.indicatorColor = hexStringToUIColor(hex: "#909090")
                
            }
        }
    }
    
}

extension FilterVC: RangeSliderDelegate {
    
    func upperValueDidChange() {

        toPriceTxtField.text = "\(Int(rangeSlider.upperValue))" + " L.E"
    }
    
    func lowerValuesDidChange() {
        print("khaled")
        fromPriceTxtField.text = "\(Int(rangeSlider.lowerValue))" + " L.E"
    }
    
    
}
