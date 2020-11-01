//
//  SetLocationVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit

class SetLocationVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var searchBtn: UIButton!
    
    var keyBoardHeight: CGFloat?
    var height: CGFloat?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.isOpaque = false
      //  searchBar.searchBarStyle = .minimal
      //  searchBar.barTintColor = UIColor.clear
      //  searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
        searchBar.isTranslucent = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
                self.height = keyboardSize.height
                self.searchBtn.frame.origin.y -= height!
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        if self.height != nil {
            
            self.searchBtn.frame.origin.y += self.height!
        }
        
        
    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }


}
