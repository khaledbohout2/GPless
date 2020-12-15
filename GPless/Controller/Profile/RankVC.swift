//
//  RankVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class RankVC: UIViewController {
    
    @IBOutlet weak var rankTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userRankLbl: UILabel!
    
    var ratedUsers = [UserRank]()
    var userRank : UserRank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setUpNavigation()
        makeBottomCornerRadius(myView: headerView)
        
        if Reachable.isConnectedToNetwork() {
            
        getRank()
            
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }

    }
    
    func initTableView() {
        rankTableView.delegate = self
        rankTableView.dataSource = self
        let nib = UINib(nibName: "RankTableViewCell", bundle: nil)
        rankTableView.register(nib, forCellReuseIdentifier: "RankTableViewCell")
    }
    
    
    func setUpNavigation() {
        

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "Rank"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateHeaderView() {
        self.userProfileImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.usersPhotoLink) ?? "" + "/" + (userRank?.photoLink ?? "")))
        self.userNameLbl.text = "Hello".localizableString() + (userRank?.accountName ?? "")
        self.userRankLbl.text = "YourRankis".localizableString() + "\(userRank?.rank ?? 0)"
    }
}

extension RankVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankTableViewCell", for: indexPath) as! RankTableViewCell
        cell.configureCell(user: ratedUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
//        let moneySavedVC = storyBoard.instantiateViewController(identifier: "MoneySavedVC")
//        self.navigationController?.pushViewController(moneySavedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }
    
    
}

extension RankVC {
    
    func getRank() {
        
        print(getCurrentDate())
        print(getLastWeakDate())
        
        _ = Network.request(req: UsersRankRequest(from: getLastWeakDate(), to: getCurrentDate()), completionHandler: { (result) in
            switch result {
            case .success(let rank):
                print(rank)
                self.ratedUsers = rank.users!
                self.userRank = rank.authUser
                self.updateHeaderView()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
            print(error!)
            }
        })
    }
}
