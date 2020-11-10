//
//  CategoriesListSearchVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class CategorySearchVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var notFoundLbl: UILabel!
    @IBOutlet weak var noResultLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.0)
      //self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        self.navigationController?.navigationBar.isHidden = true
        makeBottomCornerRadius(myView: searchView)
        searchBar.layer.borderColor = searchBar.barTintColor?.cgColor
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismisSearch))
        self.mainView.addGestureRecognizer(dismissGesture)

        // Do any additional setup after loading the view.
    }
    
    @objc func dismisSearch() {
        
        self.view.removeFromSuperview()
        self.navigationController?.navigationBar.isHidden = false
        
    }
    

}

extension CategorySearchVC: UISearchBarDelegate {
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        notFoundImage.isHidden = false
//        notFoundLbl.isHidden = false
//        noResultLbl.isHidden = false
//
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            
            if searchText == "123" {
                
                
                let storyboard = UIStoryboard(name: "Lists", bundle: nil)
                let categorySearchResultsVC =  storyboard.instantiateViewController(identifier: "CategorySearchResultsVC") as? CategorySearchResultsVC
                self.addChild(categorySearchResultsVC!)
                categorySearchResultsVC?.view.frame = self.view.frame
                self.view.addSubview((categorySearchResultsVC?.view)!)
                categorySearchResultsVC?.didMove(toParent: self)
                notFoundImage.isHidden = true
                notFoundLbl.isHidden = true
                noResultLbl.isHidden = true
                
            } else {
        
                notFoundImage.isHidden = false
                notFoundLbl.isHidden = false
                noResultLbl.isHidden = false
                
        self.view.backgroundColor = UIColor(white: 1, alpha: 1.0)
        searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
                
            }
            
        } else {
            
            notFoundImage.isHidden = true
            notFoundLbl.isHidden = true
            noResultLbl.isHidden = true
            self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
            mainView.backgroundColor = UIColor(white: 1, alpha: 0.0)
            searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)

            
        }
    }
    
  
}
