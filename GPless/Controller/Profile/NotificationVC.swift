//
//  NotificationVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var notificationsTableView: UITableView!
    var notificationsArr = [Notification]()
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if getUserData() == true {
            
            setUpTableView()
            setUpNavigation()
            getNotification()
            
        } else {
        
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let pleaseLoginVC =  storyboard.instantiateViewController(identifier: "PleaseLoginVC") as! PleaseLoginVC
        self.addChild(pleaseLoginVC)
      //  pleaseLoginVC.view.frame = self.view.frame
        pleaseLoginVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview((pleaseLoginVC.view)!)
        pleaseLoginVC.didMove(toParent: self)
            
            self.view.addConstraints([
                NSLayoutConstraint(item: pleaseLoginVC.view!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: pleaseLoginVC.view!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: pleaseLoginVC.view!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: pleaseLoginVC.view!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
                ])
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")


        self.title = "Notification"
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
    
    func setUpTableView() {
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        let nib = UINib(nibName: "NotificationTableViewCell", bundle: nil)
        let imageNib = UINib(nibName: "ImageNotificationTableViewCell", bundle: nil)
        notificationsTableView.register(nib, forCellReuseIdentifier: "NotificationTableViewCell")
        notificationsTableView.register(imageNib, forCellReuseIdentifier: "ImageNotificationTableViewCell")
        
    }
    

}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notificationsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notif = notificationsArr[indexPath.row]
        
        if notif.imageLink != nil {
            
            let cell = notificationsTableView.dequeueReusableCell(withIdentifier: "ImageNotificationTableViewCell", for: indexPath) as! ImageNotificationTableViewCell
            cell.imageView?.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.notificationsLink) ?? "" + "/" + (notif.imageLink!)))
            return cell
        } else {
        
        let cell = notificationsTableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = storyBoard.instantiateViewController(identifier: "ProfileVC")
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.notificationsArr.count - 1 {
            index += 1
            getNotification()
        }
    }
    
    
}

extension NotificationVC {
    
    func getNotification() {

        _ = Network.request(req: NotificationRequest(index: "\(self.index)"), completionHandler: { (result) in
            
            switch result {
            case .success(let response):
                print(response)
                if self.index == 1 {
                    self.notificationsArr = response.notifications!
                    
                } else {
                    
                    for notif in response.notifications! {
                        
                        self.notificationsArr.append(notif)
                    }
                }
                
                self.notificationsTableView.reloadData()
                
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
