//
//  EditProfileVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit
import AVFoundation
import SkyFloatingLabelTextField

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var genderBtn: UILabel!
    
    var selectedGender: String?
    var userInfo: Profile?
    var profPicSelected = false
    
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!

    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        picker.delegate = self
        localize()
        updateUI()

    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "editProfile".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back

    }
    
    func localize() {

        saveBtn.setTitle("save".localizableString(), for: .normal)
        saveBtn.setLocalization()
        
        genderBtn.text = "gender".localizableString()
        genderBtn.setLocalization()
        
        nameTxtField.placeholder = "name".localizableString()
  //      nameTxtField.setLocalization()
        passwordTextField.placeholder = "password".localizableString()
   //     passwordTextField.setLocalization()
        emailTextField.placeholder = "email".localizableString()
     //   emailTextField.setLocalization()
        phoneNumberTextField.placeholder = "PhoneNumber".localizableString()
      //  phoneNumberTextField.setLocalization()
    }
    
    func updateUI() {
        
        nameTxtField.text = userInfo?.accountName
        emailTextField.text = userInfo?.email
        
        if let gender = userInfo?.gender  {
            
            if gender == "female" {
                
                self.selectedGender = "Female"
                femaleBtn.setImage(UIImage(named: "femaleFilled"), for: .normal)
                maleBtn.setImage(UIImage(named: "male"), for: .normal)
            
            } else {
                
                self.selectedGender = "Male"
                femaleBtn.setImage(UIImage(named: "Female"), for: .normal)
                maleBtn.setImage(UIImage(named: "maleFilled"), for: .normal)
            }
        }
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
      func that asks user for grant permission of accessing camera
     - Parameters :
     - alert : the alert of options displayed passed to be dismissed
             */
    func openCamera(alert : UIAlertController){
           alert.dismiss(animated: true, completion: nil)
           if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                       // Already Authorized
                       print("Already Authorized")
               self.presentCamera()
                     } else {
                         AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                            if granted == true {
                                // User granted
                                 print("User granted")
                               self.presentCamera()
                            } else {
                                // User rejected
                                print("User rejected")
                                self.whenAuthorizationdenied()
                   }
               })
           }
       }
       
    
       /**
         func that opens gallery when user select gallery option while changing profile pic
        - Parameters :
        - alert : the alert of options displayed passed to be dismissed
                */
       func openGallery(alert : UIAlertController){
              alert.dismiss(animated: true, completion: nil)
              picker.sourceType = .photoLibrary
              self.present(picker, animated: true, completion: nil)
          }
       
    /**
     func that opens camera when user select camera option while changing profile pic
    - Parameters :
    - zero parameters
            */
       func presentCamera() {
           if(UIImagePickerController.isSourceTypeAvailable(.camera)){
               DispatchQueue.main.async {
               self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
               }
                 } else {
                       let alertWarning = UIAlertController(title: "Warning", message:  "You don't have camera", preferredStyle: .alert)
                          self.present(alertWarning,animated: true)
          }
       }
       
       /**
         func called when user denied camera permission
        - Parameters :
        - zero parameters
                */
       func whenAuthorizationdenied() {
           let alert = UIAlertController(title: "Camera is denied", message: "If you want to use the camera later, You should changes the app's persmission from the settings", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default))
           DispatchQueue.main.async {
               self.present(alert, animated: true, completion: nil)
           }
       }
    
    
    @IBAction func changePhotoBtnTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera( alert: alert)
        }
        let gallaryAction = UIAlertAction(title: "Photos gallery", style: .default){
            UIAlertAction in
            self.openGallery(alert: alert)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func femaleBtnTapped(_ sender: Any) {
        
        self.selectedGender = "Female"
        femaleBtn.setImage(UIImage(named: "femaleFilled"), for: .normal)
        maleBtn.setImage(UIImage(named: "male"), for: .normal)
    }
    

    @IBAction func maleBtnTapped(_ sender: Any) {
        
        self.selectedGender = "Male"
        femaleBtn.setImage(UIImage(named: "Female"), for: .normal)
        maleBtn.setImage(UIImage(named: "maleFilled"), for: .normal)
    }
    

    @IBAction func saveBtnTapped(_ sender: Any) {
        
        if Reachable.isConnectedToNetwork() {
            
        updateProfile()
            
        } else {
            
            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
    }
    

}

extension EditProfileVC {
    
    func updateProfile() {
        
        var user = UserToRegister()
        user.accountName = nameTxtField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text
        user.phone = phoneNumberTextField.text

        
        if profPicSelected {
            let dict = try! user.asDictionary()
            
            Network.upload(image: self.profileImageView.image!, parameters:dict) { [weak self] (error, newName) in
            if error != nil {
                print(error!)
            } else {
                
                print(newName!)
                
            }
        }
            
            
            
            _ = Network.request(req: EditProfileRequest(user: user), completionHandler: { (result) in
                switch result {
                case .success(let success):
                    print(success)
                    if success.state != nil {
                        Toast.show(message: success.state!, controller: self)
                    } else {
                        Toast.show(message: success.error!, controller: self)
                    }
                case .cancel(let cancelError):
                    print(cancelError!)
                    Toast.show(message: cancelError!.localizedDescription, controller: self)
                case .failure(let error):
                    print(error!)
                    Toast.show(message: error!.localizedDescription , controller: self)
                }
            })
            
            
        } else {
            
                    _ = Network.request(req: EditProfileRequest(user: user), completionHandler: { (result) in
                        switch result {
                        case .success(let success):
                            print(success)
                            if success.state != nil {
                                Toast.show(message: success.state!, controller: self)
                            } else {
                                Toast.show(message: success.error!, controller: self)
                            }
                        case .cancel(let cancelError):
                            print(cancelError!)
                            Toast.show(message: cancelError!.localizedDescription, controller: self)
                        case .failure(let error):
                            print(error!)
                            Toast.show(message: error!.localizedDescription , controller: self)
                        }
                    })
        }

    }
        
}

extension EditProfileVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    /**
            delegate func that called after user picked an image from photoLibrary
            - Parameters :
     - picker : instance of the presented photoLibrary picker , didFinishPickingMediaWithInfo : dictionary containing info about the selected photo
            */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let selectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImageView.image = selectedPhoto
        profPicSelected = true
    }
}
