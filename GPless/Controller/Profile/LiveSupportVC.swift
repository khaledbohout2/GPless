//
//  LiveSupportVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class LiveSupportVC: UIViewController {
    
    
    @IBOutlet weak var chatTableView: UITableView!
    
    var index = 1
    var messagesArr = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        initTableView()
        getMessagesHistory()

        // Do any additional setup after loading the view.
    }
    
    func initTableView() {
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        let fromNib = UINib(nibName: "ChatFromTableViewCell", bundle: nil)
        let toNib = UINib(nibName: "ChatToTableViewCell", bundle: nil)
        chatTableView.register(fromNib, forCellReuseIdentifier: "ChatFromTableViewCell")
        chatTableView.register(toNib, forCellReuseIdentifier: "ChatToTableViewCell")
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 100
        
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "Live Support"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
     //   search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    @IBAction func sentMessageBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let settingVC = storyBoard.instantiateViewController(identifier: "SettingVC")
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    


}

extension LiveSupportVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatFromTableViewCell", for: indexPath) as! ChatFromTableViewCell
            cell.messageLbl.text = messagesArr[indexPath.row].messageDescription
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatToTableViewCell", for: indexPath) as! ChatToTableViewCell
            cell.messageLbl.text = messagesArr[indexPath.row].messageDescription
            return cell
            
        }
    }
}

extension LiveSupportVC {
    
    func getMessagesHistory() {
        
        _ = Network.request(req: ContactUsRequest(index: "\(self.index)"), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                if self.index == 1 {
                    self.messagesArr = response.messages!
                } else {
                    for mesaage in response.messages! {
                        self.messagesArr.append(mesaage)
                    }
                }
                self.chatTableView.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
