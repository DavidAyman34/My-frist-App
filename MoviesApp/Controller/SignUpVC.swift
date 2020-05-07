//
//  ViewController.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/25/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
import SQLite
class SignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SendingAddressDelegate {
    func getLocation(address: String) {
        addressTextField.text = address
    }
    
    @IBOutlet weak var switchOut: UISwitch!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var imagePicker = UIImagePickerController( )
    var selectedGender:Gender!
    let data = UserDefaultsManager.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        SQLiteURl.openDataBase()
        SQLiteURl.createTable()
        switchOut.isOn = true
        // Do any additional setup after loading the view.
    }
    
    
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
        //        There’s some text before the @
        //        There’s some text after the @
        //        There’s at least 2 alpha characters after a .
    }
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    func goToMap(){
        let mapVc = UIStoryboard.init(name: Storybords.main, bundle: nil).instantiateViewController(withIdentifier: VCs.mapVC) as! MapViewController
        mapVc.Delegate = self
        self.present(mapVc, animated: true, completion: nil)
    }
    func selectPhoto(){
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePicker,animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
            let imageSaved =  SQLiteURl.convertImageToBase64String(img: profileImage.image  ?? UIImage(named: Images.defaultProfileImg)! ) 
            SQLiteURl.insertTable(profileUrl: imageSaved)
        }
//        let imageSaved =  SQLiteURl.convertImageToBase64String(img: profileImage.image!)
//        SQLiteURl.insertTable(profileUrl: imageSaved)
        selectLabel.text = nil
        dismiss(animated: true, completion: nil)
        
    }
    func check() -> Bool  {
        guard  let name = nameTextField.text,!name.isEmpty,  let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let phone = phoneTextField.text, !phone.isEmpty, let address = addressTextField.text, !address.isEmpty
            else {return false}
//
        return true
    }
    func Empty () {
        switch  check() {
        case !nameTextField.text!.isEmpty:
            AlertManager.alert(title: "Name", massage: "Please write your name", present: self, titleBtn: "Ok")
        case !passwordTextField.text!.isEmpty:
            AlertManager.alert(title: "Password", massage: "Please write password", present: self, titleBtn: "Ok")
        case !emailTextField.text!.isEmpty:
            AlertManager.alert(title: "Email", massage: "Please write your email", present: self, titleBtn: "Ok")
        case !addressTextField.text!.isEmpty:
            AlertManager.alert(title: "Address", massage: "Please select your Address,  click save when your address reading ", present: self, titleBtn: "Ok")
        case !phoneTextField.text!.isEmpty:
            AlertManager.alert(title: "Phone", massage: "Please write your phone number", present: self, titleBtn: "Ok")
        default:
            goToSignIn()
        }
    }
    func goToSignIn (){
        let signInVC =   UIStoryboard.init(name: Storybords.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signinVC) as! SignInVC
        let userInit = User(name: nameTextField.text!, email: emailTextField.text!, passWord: passwordTextField.text!, addres: addressTextField.text!, phone: phoneTextField.text!, isLogin: false, gender: genderLabel!.text.map { Gender(rawValue: $0)! })

        signInVC.user = userInit
    data.saveDataFor(user: userInit).self
    data.saveDataFor(user: signInVC.user)
        print(data.getSavedData().email ?? "error email")
        self.present(signInVC, animated: true, completion: nil)
    }
    @IBAction func SignUpBtn(_ sender: UIButton) {
        if isValidEmail(email: emailTextField.text) == true {
            if isValidPassword(testStr: passwordTextField.text) == true {
                if check() == true{
                    goToSignIn()
                } else {
                    Empty()
                }
            }else {
                AlertManager.alert(title: "Password", massage: "at least one uppercaseat least one digit , at least one lowercase ,8 characters total.", present: self, titleBtn: "Ok")
            }
        }else{
            AlertManager.alert(title: "Email", massage: "There’s some text before the @, There’s some text after the @, a There’s at least 2 alpha characters after a .", present: self, titleBtn: "Ok")
        }
    }
    
    @IBAction func selectBtn(_ sender: UIButton) {
        selectPhoto()
    }
    @IBAction func adderssBtn(_ sender: UIButton) {
        goToMap()
    }
    @IBAction func genderSwitch(_ sender: UISwitch) {
    
        genderLabel.text =  switchOut.isOn ?  Gender.male.rawValue : Gender.female.rawValue
        selectedGender = switchOut.isOn ? Gender.male : Gender.female
    
    }
    
}

