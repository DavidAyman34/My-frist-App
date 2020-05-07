//
//  SignInVC.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/25/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()

     
        print( UserDefaultsManager.shared().getSavedData().email) // 3shan bnsahom😂
        print( UserDefaultsManager.shared().getSavedData().passWord) // 3shan bnsahom😂
        
    
    }
    func goToTabBar(){
        let tabBar = UIStoryboard.init(name: Storybords.main, bundle: nil).instantiateViewController(withIdentifier: VCs.tabBar) as! UITabBarController
        self.present(tabBar, animated: true, completion: nil)
    }
    func checkData() { 
        if emailTextField.text == UserDefaultsManager.shared().getSavedData().email{
            if passwordTextField.text == UserDefaultsManager.shared().getSavedData().passWord {
                goToTabBar()
            }else{
                AlertManager.alert(title: "Check Password", massage: "please write Your password", present: self, titleBtn: "OK")
            }
        }
        else {
            AlertManager.alert(title: "Check Email", massage: "please write Your Email", present: self, titleBtn: "Ok")
        }
    }
    @IBAction func signInBtn(_ sender: UIButton) {
        checkData()
    }
}
