//
//  EmailUsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit
import SkyFloatingLabelTextField

class EmailUsVC: UIViewController {
    
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var sendMessageBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    
    func localize() {

        sendMessageBtn.setTitle("sendMessage", for: .normal)
        sendMessageBtn.setLocalization()
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "emailUs".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func sendMessageBtnTapped(_ sender: Any) {
        
        guard nameTextField.text != "" else {
            Toast.show(message: "PleaseEnterYourName".localizableString(), controller: self)
            return
        }
        guard emailTextField.text != "" else {
            Toast.show(message: "Please enter your email", controller: self)
            return
        }
        
        guard phoneNumberTextField.text != "" else {
            Toast.show(message: "pleaseEnterYourPhoneNumber".localizableString(), controller: self)
            return
        }
        guard messageTextView.text != "" else {
            Toast.show(message: "pleaseEnterYourMessage".localizableString(), controller: self)
            return
        }
        
        if Reachable.isConnectedToNetwork() {
        
        postMessage()
            
        } else {
            
            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
        
    }
    
    @IBAction func testBtnTapped(_ sender: Any) {
        
        print("button tapped")
    }
    

}

extension EmailUsVC {
    
    func postMessage() {
        
        var postMessage = PostMessage()
        postMessage.email = emailTextField.text
        postMessage.name = nameTextField.text
        postMessage.phone = phoneNumberTextField.text
        postMessage.title = "title"
        postMessage.postMessageDescription = messageTextView.text
        
        _ = Network.request(req: PostMessageRequest(messageObject: postMessage), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                if response.state == "done" {
                    print(response)
                   // Toast.show(message: "messageSent".localizableString(), controller: self)
                    
                    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                    let doneContactUsVC =  storyboard.instantiateViewController(identifier: "DoneContactUsVC") as! DoneContactUsVC
                    self.addChild(doneContactUsVC)
                    doneContactUsVC.view.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview((doneContactUsVC.view)!)
                    doneContactUsVC.didMove(toParent: self)
                    
                } else {
                    print(response.error!)
                    Toast.show(message: response.error!.localizedLowercase, controller: self)
                }
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
