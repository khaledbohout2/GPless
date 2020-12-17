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
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var categoryBtn: UILabel!
    @IBOutlet weak var mallLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var fromBtn: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var freeLbl: UILabel!
    @IBOutlet weak var premiumLbl: UILabel!
    @IBOutlet weak var sortByLbl: UILabel!
    @IBOutlet weak var applyBtn: UIButton!
    
    var isAreasExpanded = false
    var isBrandsExpanded = false
    var isSortByExpanded = false
    var mallsIndex = 1
    var brandIndex = 1
    var categoryIndex = 1
    
    var categories = [CategoryElement]()
    var brands = [Brand]()
    let sortBy = ["Newest", "Oldest", "Price High to Low", "Price Low to high"]
    var malls = [Mall]()
    
    var selectedCategory: String?
    var selectedBrand: String?
    var selectedSortedBy: String?
    var lowerPrice: String?
    var upperPrice: String?
    var selectedFilterType = "free"
    var selectedArea: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        initCollectionView()
        setUpNavigation()
        setUpTableViews()
        
        if Reachable.isConnectedToNetwork() {
            
        localize()
        getBrands()
        getCategories()
        getMalls()
            
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }

        // Do any additional setup after loading the view.
    }
    
    
    func setUpUI() {
        
        fromPriceTxtField.delegate = self
        toPriceTxtField.delegate = self
        fromPriceTxtField.text = "\(Int(rangeSlider.lowerValue))" + "L.E".localizableString()
        toPriceTxtField.text = "\(Int(rangeSlider.upperValue))" + " L.E".localizableString()
        rangeSlider.delegate = self
    }
    
    func localize() {

        resetBtn.setTitle("reset".localizableString(), for: .normal)
        resetBtn.setLocalization()
        
        categoryBtn.text = "category".localizableString()
        categoryBtn.setLocalization()
        
        mallLbl.text = "mall".localizableString()
        mallLbl.setLocalization()
        
        brandLbl.text = "brand".localizableString()
        brandLbl.setLocalization()
        
        priceLbl.text = "price".localizableString()
        priceLbl.setLocalization()
        
        fromBtn.text = "from".localizableString()
        fromBtn.setLocalization()
        
        toLbl.text = "to".localizableString()
        toLbl.setLocalization()
        
        freeLbl.text = "Free".localizableString()
        freeLbl.setLocalization()
        
        premiumLbl.text = "premium".localizableString()
        premiumLbl.setLocalization()
        
        sortByLbl.text = "sortBy".localizableString()
        sortByLbl.setLocalization()
        
        applyBtn.setTitle("apply".localizableString(), for: .normal)
        applyBtn.setLocalization()
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
    
    
    @IBAction func premiumSwichChanged(_ sender: UISwitch) {

        if sender.isOn {
            self.selectedFilterType = "premuim_paid"
        } else {
            self.selectedFilterType = "free"
        }
    }
    
    
    @IBAction func applyBtnTapped(_ sender: Any) {
        
//        guard selectedCategory != nil  else {
//            Toast.show(message: "please select category", controller: self)
//            return
//        }
//        guard selectedBrand != nil  else {
//            Toast.show(message: "please select brand", controller: self)
//            return
//        }
//
//        guard lowerPrice != nil  else {
//            Toast.show(message: "please set lower price", controller: self)
//            return
//        }
//        guard upperPrice != nil  else {
//            Toast.show(message: "please set upper price", controller: self)
//            return
//        }
//
//        guard selectedSortedBy != nil  else {
//            Toast.show(message: "please select sorted by", controller: self)
//            return
//        }

        if Reachable.isConnectedToNetwork() {
        
        filterRequest()
            
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }
        
    }
    
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        
        
    }
    
    
}

extension FilterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoriesCollectionViewCells", for: indexPath) as! FilterCategoriesCollectionViewCells
        
        cell.configureCell(category: categories[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 85, height: 110)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedCategory = categories[indexPath.row].categoryName
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCategoriesCollectionViewCells
        
        let cells = collectionView.visibleCells as! [FilterCategoriesCollectionViewCells]
        
        let opacity:CGFloat = 0.1
        let borderColor =  hexStringToUIColor(hex: "#707070")
        
        
        for cell in cells {
            cell.categoryImageContainerView.borderColor = borderColor.withAlphaComponent(opacity)
        }
        
        cell.categoryImageContainerView.borderColor = hexStringToUIColor(hex: "#282828")
        

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row == self.categories.count - 1 {
            categoryIndex += 1
            getCategories()
        }
    }
    
    
}

extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewBrands {
            
            return brands.count
            
        } else if tableView == tableViewSortBy {
            
            return sortBy.count
            
        } else if tableView == tableViewAreas {
            
            return malls.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if tableView == tableViewBrands {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath) as! ExpandableTableViewCell
            cell.titleLbl.text = brands[indexPath.row].fullName
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
            
        } else if tableView == tableViewAreas {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath) as! ExpandableTableViewCell
            cell.titleLbl.text = malls[indexPath.row].name
            cell.delegate = self
            cell.index = indexPath
            cell.tableView = tableView
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  tableView == tableViewBrands {
            if indexPath.row == self.brands.count - 1 {
                brandIndex += 1
                getBrands()
            }
        } else if tableView == tableViewAreas {
            if indexPath.row == self.malls.count - 1 {
                mallsIndex += 1
                getMalls()
            }
        }

    }
    
    
}

extension FilterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == fromPriceTxtField {
            
            rangeSlider.lowerValue = Double(textField.text!)!
            self.lowerPrice = "\(Double(textField.text!)!)"
            
        } else if textField == toPriceTxtField {
            
            rangeSlider.upperValue = Double(textField.text!)!
            self.upperPrice = "\(Double(textField.text!)!)"
        }
    }
}

extension FilterVC: CheckRadioBtnProtocol {
    
    func checkBtn(index: IndexPath, tableView: UITableView) {
        
        let cell = tableView.cellForRow(at: index) as! ExpandableTableViewCell
        cell.radioBtn.isSelected = true
        cell.radioBtn.iconColor = hexStringToUIColor(hex: "#FBE159")
        cell.radioBtn.indicatorColor = hexStringToUIColor(hex: "#FBE159")
        
        if tableView == tableViewBrands {
            
            self.selectedBrand = brands[index.row].fullName
            
        } else if tableView == tableViewSortBy {
            
            self.selectedSortedBy = sortBy[index.row]
        } else if tableView == tableViewAreas {
            self.selectedArea = malls[index.row].name
        }
        
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
        self.upperPrice = "\(Int(rangeSlider.upperValue))"
    }
    
    func lowerValuesDidChange() {

        fromPriceTxtField.text = "\(Int(rangeSlider.lowerValue))" + " L.E"
        self.lowerPrice = "\(Int(rangeSlider.lowerValue))"
    }
    
    
}

//MARK: - APIs

extension FilterVC {
    
    func getBrands() {
        
        _ = Network.request(req: BrandsRequest(index: "\(brandIndex)", featured: false) , completionHandler: { (result) in
            switch result {
            
            case .success(let response):
                print(response)
                if self.brandIndex == 1 {
                self.brands = response.brands!
                } else {
                    for brand in response.brands! {
                        self.brands.append(brand)
                    }
                }
                self.tableViewBrands.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
    func getCategories() {
        
        _ = Network.request(req: CategoriesRequest(index: "\(categoryIndex)"), completionHandler: { (result) in
           switch result {
           case .success(let response):
           print(response)
            if self.categoryIndex == 1 {
            self.categories = response.categories!
                
            } else {
                
                for cat in response.categories! {
                    
                    self.categories.append(cat)
                }
            }
           self.categoriesCollectionView.reloadData()
           case .cancel(let cancelError):
           print(cancelError!)
           case .failure(let error):
           print(error!)
            }
        })
    }
    
    func getMalls() {
        
        _ = Network.request(req: MallsRequest(index: "\(self.mallsIndex)"), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                if self.mallsIndex == 1 {
                    self.malls = response.malls!
                } else {
                    for mall in response.malls! {
                        self.malls.append(mall)
                    }
                }
                self.tableViewAreas.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
    func filterRequest() {

        
        let filter = Filter(categoryType: self.selectedCategory, type: self.selectedFilterType, startPrice: self.lowerPrice, mall: self.selectedArea, endPrice: self.upperPrice)
        
        _ = Network.request(req: FilterdOffersRequest(filter: filter), completionHandler: { (result) in
            switch result {
            case .success(let offers):
                print(offers)
                if offers.count == 0 {
                    Toast.show(message: "No Offers", controller: self)
                } else {
                    
                    let storyboard = UIStoryboard(name: "Lists", bundle: nil)
                    let offersListVC =  storyboard.instantiateViewController(identifier: "OffersListVC") as! OffersListVC
                    offersListVC.offersArr = offers
                    self.navigationController?.navigationBar.isHidden = false
                    self.navigationController?.pushViewController(offersListVC, animated: true)
                    
                }
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
            
        })

  }
}
