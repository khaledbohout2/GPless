//
//  HomeSearchVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class HomeSearchVC: UIViewController {
    
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
      //  self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        self.navigationController?.navigationBar.isHidden = true
        makeBottomCornerRadius(myView: searchView)
        searchBar.layer.borderColor = searchBar.barTintColor?.cgColor

        // Do any additional setup after loading the view.
    }


}

extension HomeSearchVC: UISearchBarDelegate {
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        notFoundImage.isHidden = false
//        notFoundLbl.isHidden = false
//        noResultLbl.isHidden = false
//
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
        
                notFoundImage.isHidden = false
                notFoundLbl.isHidden = false
                noResultLbl.isHidden = false
        self.view.backgroundColor = UIColor(white: 1, alpha: 1.0)
        searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
            
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
